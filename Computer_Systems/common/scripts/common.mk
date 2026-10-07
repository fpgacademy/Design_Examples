# Check if the Makefile is running on WSL or directly in Linux
ifeq ($(origin WSL_DISTRO_NAME),environment)
    EXE := .exe
else
    EXE := 
endif

# find quartus executables
WSL_QUARTUS_DIR := $(shell wslpath '$(INSTALL)')
export PATH := $(WSL_QUARTUS_DIR)/quartus/bin64/:$(PATH)
export PATH := $(WSL_QUARTUS_DIR)/quartus/sopc_builder/bin/:$(PATH)

QSYSOBJS = $(TCLSRCS:.tcl=.qsys)
SOPCOBJS = $(QSYSSRC:.qsys=.sopcinfo)
CURPATH  = $(shell pwd)

QP_PROGRAMMER	:= quartus_pgm.exe
# for most FPGA boards the JTAG index of the FPGA will be 1. But for the DE1-SoC board it
# will most often be 2. So, set a default appropriately:
JTAG_INDEX := $(if $(findstring DE1-SoC,$(CURPATH)),2,1)

CABLE_NAME = -c "$(shell $(WSL_QUARTUS_DIR)/quartus/bin64/$(QP_PROGRAMMER) --auto | grep "Using programming cable" | sed -n 's/.*"\(.*\)".*/\1/p')"

default: generate_qsys_files

all: generate_qsys_files run_platform_designer reduce_sopcinfo fix_for_niosVg run_quartus generate_rbf release grep_for_errors

continue: run_platform_designer reduce_sopcinfo fix_for_niosVg run_quartus generate_rbf release grep_for_errors

generate_qsys_files: $(QSYSOBJS)

%.tcl: # dummy make target
	
%.qsys: %.tcl
	qsys-script$(EXE) --script=$(S2CPATH)/$< > $(CURPATH)/o_$<.txt 2>&1

run_platform_designer: $(QSYSSRC)
	mkdir -p $(DSTPATH)
	cp *.qsys $(DSTPATH)
	cd $(DSTPATH) && qsys-generate$(EXE) ./$< --synthesis=VERILOG > $(CURPATH)/o_$<.txt 2>&1

reduce_sopcinfo:
	cd $(DSTPATH) && python3 $(D2CPATH)/strip_info.py Computer_System.sopcinfo

fix_for_niosVg: # need to repair NiosVg due to platform designer bug
ifeq ($(findstring NiosVg,$(QP_NAME)), NiosVg)
	sed -i 's/000000-/1111111/' $(DSTPATH)/Computer_System/synthesis/submodules/Computer_System_NiosVg.v
endif

run_quartus: $(QP_NAME)
	cp -r $(SRCPATH) $(DSTPATH)
	cd $(DSTPATH) && quartus_sh$(EXE) --64bit --flow compile $< > $(CURPATH)/o_$<.txt 2>&1

generate_rbf: $(QP_NAME)
ifeq ($(GEN_RBF), 1)
	cd $(DSTPATH) && quartus_cpf$(EXE) -m FPP -o bitstream_compression=on -c $<.sof $<.rbf > $(CURPATH)/o_$<.rbf.txt 2>&1
endif

release:
	mkdir -p $(RELPATH)
	cp $(DSTPATH)/*.sopcinfo $(RELPATH)
	cp $(DSTPATH)/*.amp $(RELPATH)
	cp $(DSTPATH)/*.sof $(RELPATH)
ifeq ($(GEN_RBF), 1)
	cp $(DSTPATH)/*.rbf $(RELPATH)
endif


grep_for_errors:
	@grep Error *.txt || true 

clean:
	rm -f *.qsys
	rm -f o_*.txt

detect:
	$(QP_PROGRAMMER) --auto
	
board:
	$(eval SOF_FILE := $(shell ls $(RELPATH)/*.sof))
	$(QP_PROGRAMMER) $(CABLE_NAME) -m jtag -o "P;$(SOF_FILE)@$(JTAG_INDEX)"

.PHONY: default all continue generate_qsys_files run_platform_designer run_quartus $(QP_NAME) release grep_for_errors clean


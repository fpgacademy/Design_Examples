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
CURPATH  = $(shell pwd)

QP_PROGRAMMER	:= quartus_pgm.exe
CABLE_NAME = -c "$(shell $(WSL_QUARTUS_DIR)/quartus/bin64/$(QP_PROGRAMMER) --auto | grep "Using programming cable" | sed -n 's/.*"\(.*\)".*/\1/p')"

default: clean_qsys generate_qsys_files

all: generate_qsys_files run_platform_designer run_quartus generate_rbf release grep_for_errors

continue: run_platform_designer run_quartus generate_rbf release grep_for_errors

clean_qsys:
	rm -f *.qsys
	rm -f ip/*/*.ip
	rm -f *.qpf
	rm -f *.qsf
	cp $(SRCPATH)/$(QP_NAME).qpf .
	cp $(SRCPATH)/$(QP_NAME).qsf .

generate_qsys_files: $(QSYSOBJS)

%.tcl: # dummy make target
	
# for each .qsys file run its tcl script to make its qsys system. The ip config files that 
# are produced will be saved in the ip folder in scripts, and each ip file will be added to 
# the quartus project's settings file (which was copied into the scripts folder by clean_qsys)
%.qsys: %.tcl
	qsys-script$(EXE) --script=$(S2CPATH)/$< > $(CURPATH)/o_$<.txt 2>&1 --quartus-project=$(QP_NAME).qpf

# make the out folder if it doesn't exist. Then, clear it in case it did exist and has unwanted
# content. Copy the qsys files and ip and then generate the HDL 
run_platform_designer: $(QSYSSRC)
	mkdir -p $(DSTPATH)
	rm -rf $(DSTPATH)/*
	rm -rf $(DSTPATH)/.q*
	cp *.qsys $(DSTPATH)
	cp -r ip $(DSTPATH)
	cd $(DSTPATH) && qsys-generate$(EXE) ./$< --synthesis=VERILOG > $(CURPATH)/o_$<.txt 2>&1

# copy the source files, and then overwrite the qsf created by qsys-script (has the ip files)
run_quartus: $(QP_NAME)
	cp -r $(SRCPATH) $(DSTPATH)
	cp $(QP_NAME).qpf $(DSTPATH)
	cp $(QP_NAME).qsf $(DSTPATH)
	cd $(DSTPATH) && quartus_sh$(EXE) --64bit --flow compile $< > $(CURPATH)/o_$<.txt 2>&1

generate_rbf: $(QP_NAME)
ifeq ($(GEN_RBF), 1)
	cd $(DSTPATH) && quartus_cpf$(EXE) -m FPP -o bitstream_compression=on -c $<.sof $<.rbf > $(CURPATH)/o_$<.rbf.txt 2>&1
endif

release:
	mkdir -p $(RELPATH)
	cp $(DSTPATH)/*.sof $(RELPATH)
ifeq ($(GEN_RBF), 1)
	cp $(DSTPATH)/*.rbf $(RELPATH)
endif


grep_for_errors:
	@grep Error *.txt || true 

clean:
	rm -f *.qsys
	rm -f o_*.txt
	rm -f ip/*/*.ip
	rm -rf ip
	rm -rf dni
	rm -rf qdb
	rm -f *.qpf
	rm -f *.qsf

detect:
	$(QP_PROGRAMMER) --auto

board:
	$(eval SOF_FILE := $(shell ls $(RELPATH)/*.sof))
	$(QP_PROGRAMMER) $(CABLE_NAME) -m jtag -o "P;$(SOF_FILE)"

.PHONY: default all continue generate_qsys_files run_platform_designer run_quartus $(QP_NAME) release grep_for_errors clean



QSYSOBJS = $(TCLSRCS:.tcl=.qsys)
SOPCOBJS = $(QSYSSRC:.qsys=.sopcinfo)
CURPATH  = $(shell pwd)

default: generate_qsys_files

all: generate_qsys_files run_platform_designer reduce_sopcinfo run_quartus generate_rbf grep_for_errors

continue: run_platform_designer reduce_sopcinfo run_quartus generate_rbf grep_for_errors

generate_qsys_files: $(QSYSOBJS)

%.tcl: # dummy make target
	
%.qsys: %.tcl
	qsys-script.exe --script=$(S2CPATH)/$< > $(CURPATH)/o_$<.txt 2>&1

run_platform_designer: $(QSYSSRC)
	mkdir -p $(DSTPATH)
	cp *.qsys $(DSTPATH)
	cd $(DSTPATH) && qsys-generate.exe ./$< --synthesis=VERILOG > $(CURPATH)/o_$<.txt 2>&1

reduce_sopcinfo:
	cd $(DSTPATH) && python3 $(D2CPATH)/strip_info.py Computer_System.sopcinfo

run_quartus: $(QP_NAME)
	cp -r $(SRCPATH) $(DSTPATH)
	cd $(DSTPATH) && quartus_sh.exe --64bit --flow compile $< > $(CURPATH)/o_$<.txt 2>&1

generate_rbf: $(QP_NAME)
ifeq ($(GEN_RBF), 1)
	cd $(DSTPATH) && quartus_cpf.exe -m FPP -o bitstream_compression=on -c $<.sof $<.rbf > $(CURPATH)/o_$<.rbf.txt 2>&1
endif

release:
	mkdir -p $(RELPATH)
	cp $(DSTPATH)/*.sopcinfo $(RELPATH)
	cp $(DSTPATH)/*.amp $(RELPATH)
	cp $(DSTPATH)/*.sof $(RELPATH)
	cp $(DSTPATH)/*.rbf $(RELPATH)


grep_for_errors:
	@grep Error *.txt || true 

clean:
	rm -f *.qsys
	rm -f o_*.txt

.PHONY: default all continue generate_qsys_files run_platform_designer run_quartus $(QP_NAME) grep_for_errors clean


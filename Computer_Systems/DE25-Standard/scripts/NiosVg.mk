# This Makefile generates and compiles the DE23-Lite Nios V/g Computer
# To be run in the Nios II Command shell

TCLSRCS = gen_char_buf_subsystem_pro.tcl gen_vga_subsystem_pro.tcl gen_niosvg_computer_system_pro.tcl
QSYSSRC = Computer_System.qsys
QP_NAME = DE25_Standard_NiosVg_Computer
GEN_RBF = 0

include paths.mk


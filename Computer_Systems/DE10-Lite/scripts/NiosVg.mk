# This Makefile generates and compiles the DE10-Lite Nios V/g Computer
# To be run in the Nios II Command shell

TCLSRCS = gen_char_buf_subsystem.tcl gen_vga_subsystem.tcl gen_niosvg_computer_system.tcl
QSYSSRC = Computer_System.qsys
QP_NAME = DE10_Lite_NiosVg_Computer
GEN_RBF = 0

include paths.mk


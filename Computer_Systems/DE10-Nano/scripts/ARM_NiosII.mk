# This Makefile generates and compiles the DE10-Nano ARM/Nios II Computer
# To be run in the Nios II Command shell

TCLSRCS = gen_audio_subsystem.tcl gen_char_buf_subsystem.tcl gen_vga_subsystem.tcl gen_arm_niosii_computer_system.tcl
QSYSSRC = Computer_System.qsys
QP_NAME = DE10_Nano_ARM_NiosII_Computer
GEN_RBF = 1

include paths.mk


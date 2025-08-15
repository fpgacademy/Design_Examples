# This Makefile generates and compiles the DE10-Standard ARM/Nios II Computer
# To be run in the Nios II Command shell

TCLSRCS = gen_audio_subsystem.tcl gen_char_buf_subsystem.tcl gen_vga_subsystem.tcl gen_video_in_edge_detection_subsystem.tcl gen_video_in_subsystem.tcl gen_arm_niosii_computer_system.tcl
QSYSSRC = Computer_System.qsys
QP_NAME = DE10_Standard_ARM_NiosII_Computer
GEN_RBF = 1

include paths.mk


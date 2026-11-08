INSTALL := C:/altera_pro/26.1
MAIN	:= gpio_example.c
HDRS	:= ../address_map_niosv.h
SRCS	:= $(MAIN)

SHELL	:= cmd.exe

# The following variables are set based on the value of the INSTALL variable
COMPILER		:= $(INSTALL)/fpgacademy/AMP/cygwin64/home/compiler/bin
BASH			:= $(INSTALL)/fpgacademy/AMP/cygwin64/bin/bash --noprofile -norc -c 

# for Quartus programmer (three possible paths)
export PATH := $(INSTALL)/quartus/bin64/:$(PATH)
export PATH := $(INSTALL)/qprogrammer/quartus/bin64/:$(PATH)
export PATH := $(INSTALL)/qprogrammer/bin64/:$(PATH)
# for GDB server (two possible paths)
export PATH := $(INSTALL)/riscfree/debugger/gdbserver-riscv/:$(PATH)
export PATH := $(INSTALL)/fpgacademy/GDB/debugger/gdbserver-riscv/:$(PATH)
# for GDB client (two possible paths)
export PATH := $(INSTALL)/riscfree/toolchain/riscv32-unknown-elf/bin/:$(PATH)
export PATH := $(INSTALL)/fpgacademy/GDB/toolchain/riscv32-unknown-elf/bin/:$(PATH)
# for the nios2-terminal
export PATH := $(INSTALL)/fpgacademy/AMP/bin/:$(PATH)
# for checking JTAG chain
export PATH := $(INSTALL)/quartus/sopc_builder/bin/:$(PATH)

CYGWIN_INSTALL := $(shell $(BASH) 'export PATH=/usr/local/bin:/usr/bin; cygpath $(INSTALL)')
CYGWIN_PATH := export PATH=/usr/local/bin:/usr/bin:$(CYGWIN_INSTALL)/fpgacademy/AMP/bin

# Programs used for C code
ifeq ($(suffix $(MAIN)), .c)
CC	:= $(COMPILER)/riscv32-unknown-elf-gcc.exe
LD	:= $(CC)

# Flags used for C code
USERCCFLAGS	:= -g -O1 -ffunction-sections -fverbose-asm -fno-inline -gdwarf-2 
USERLDFLAGS	:= -Wl,--defsym=__stack_pointer$$=0x4000000 -Wl,--defsym  -Wl,JTAG_UART_BASE=0xff201000 -lm
ARCHCCFLAGS	:= -march=rv32im_zicsr -mabi=ilp32
ARCHLDFLAGS	:= -march=rv32im_zicsr -mabi=ilp32
CCFLAGS		:= -Wall -c $(USERCCFLAGS) $(ARCHCCFLAGS)
LDFLAGS		:= $(USERLDFLAGS) $(ARCHLDFLAGS)
endif

# Programs used for assembly code
ifeq ($(suffix $(MAIN)), .s)
AS	:= $(COMPILER)/riscv32-unknown-elf-as.exe
LD	:= $(COMPILER)/riscv32-unknown-elf-ld.exe
OC	:= $(COMPILER)/riscv32-unknown-elf-objcopy.exe

# Flags used for assembly code
ARCHASFLAGS	:= -march=rv32im_zicsr --gdwarf2
ARCHLDFLAGS	:= --section-start .text=0x0 --no-relax
ASFLAGS		:= $(ARCHASFLAGS)
LDFLAGS		:= $(USERLDFLAGS) $(ARCHLDFLAGS)
endif

OD	:= $(COMPILER)/riscv32-unknown-elf-objdump.exe
NM	:= $(COMPILER)/riscv32-unknown-elf-

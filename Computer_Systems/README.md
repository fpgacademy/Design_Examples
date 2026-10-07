# Computer Systems

This repository provides Computer Systems that have been designed specifically for the DE-series boards. Each board has one or more systems depending on the included processor(s) within the system. In addition to one or more processors, the systems include memory ports, basic input/output ports (for switches, lights, etc.), and multimedia ports (for video, audio, and the like). Accompanying the systems is a set of sample programs. To start using the Computer Systems, please download them from the [Design Examples releases](https://github.com/fpgacademy/Design_Examples/releases) page and read the associated user manual for the target board and processor.

## Repository Contents

This repository contains the source code for the Computer Systems, the associated documentation, and some sample programs:
    
    Computer_Systems/
    +-- <Board Name>/
    │   +-- doc/
    │   │       - Documentation for the Computer Systems of the given board 
    │   +-- scripts/
    │   │       - Makefile and TCL scripts for building and compiling the various Computer Systems for the given board
    │   +-- software/
    │   │       - Software header files with the address map of all the system components. These are used by the sample programs.
    │   +-- src/
    │           - Source files required by the scripts, such as the Quartus software project files, Verilog code, etc.
    +-- common/
    │   +-- doc/
    │   │       - System component description used by multiple systems/boards 
    │   +-- figs/
    │   │       - Contains figures and diagrams used in the documents of multiple systems/boards 
    │   +-- scripts/
    │           - Contains generic Makefile and TCL scripts used by multiple systems/boards 
    +-- sample_programs/
        +-- <Processor Type>
            +-- <Programming Language>
                    -Sample program demonstrating how to write software for each computer system

## Compiling or Modifying the Computer Systems

The Computer Systems are build using a set makefiles and TCL scripts. Complete each of the following sections to modify and update the Computer Systems. Note that you may require licenses for some of Altera's Intellectual Property (IP) core to compile the Computer Systems. Altera University Program members can request IP licenses via the Members section of the Altera University Program website.

### Source Code

Download a copy of this _Design Example Repository_ to your computer, using a tool of your choice such as _Command-Line Git_, _GitHub Desktop_, etc.

### Quartus Prime Software

Download and install an appropriate version of the Quartus Prime software. Links to the download pages for the various versions of the software are found at https://www.altera.com/products/development-tools/quartus-prime. 
We recommend using the latest version of the *Quartus Prime **Pro** Edition* software when targeting the DE25-Standard, DE25-Nano or DE23-Lite boards. We recommend using the latest version of the *Quartus Prime **Standard** Edition* software when targeting the DE10-Standard, DE10-Nano, DE10-Lite or DE1-SoC boards, unless you are using the Nios II processor. In this case, we recommend using version 23.1 of the *Quartus Prime **Standard** Edition* software (Nios II is not included in releases after 23.1).

### IP Cores

The Computer Systems require a set of IP Core components that can be obtained from their GitHub repository, at https://github.com/fpgacademy/IP_Cores. Follow the instructions provided in that repository to install these IP Cores.

### Building the Computer Systems using Linux

The Tcl scipts that create the Computer Systems are designed to run within a Linux
command-line environment. If using Microsoft Windows ensure that you enable the Windows 
Subsystem for Linux (WSL). Then, open a Windows Terminal and run Ubuntu on WSL. All commands 
described below can then be executed in this Ubuntu Terminal.

### Makefiles

In the Ubuntu Terminal navigate to the scripts directory for your chosen board. You have to specify the location where you have installed the Quartus Prime Pro software. To complete this step open the file named paths.mk, and set the INSTALL variable as needed. For
example: 

INSTALL = C:/altera_pro/26.1

In the scripts directory, you'll find one or more Makefile, named *.mk, depending on how many systems exist for the board. For example, the DE1-SoC has 3 systems; one for the ARM and Nios II processors (ARM_NiosII.mk), one for the Nios V/g processor (NiosVg.mk) and (for some boards) one for the Nios V/m processor (NiosVm.mk). The Makefile can be run using the *\"make -f \<system name\>.mk\"*, such as *\"make -f NiosVg.mk\"*. The Makefiles have several targets. The main targets are:

- default: Creates Platform Designer system files for the computer system
- continue: Generates the computer system's HDL (Verilog) description in Platform Designer and then compiles the circuit using the Quartus Prime software.
- all: Runs both the default and continue targets

After the Computer System has been built it can be downloaded into your FPGA board. Once you have a board properly connected to your computer using a USB Blaster (I/II/III) connection, execute the command such as

make -f NiosVg.mk board

Now, your board should be successfully configured with the computer system, and you can run 
code on this system.

Notes
-----

There are other Makefile targets that you can use, if desired. For examples the target "all" 
runs both steps 2. and 3., above. You can examine the makefile commands by looking at the file
named ../../common/scripts/common_pro.mk. This makefile executes several Tcl (Tool Command 
Language) scripts, including common_pro.tcl, gen_niosvg_computer_pro.tcl, and others.

As an example, to create the Nios Vg Computer System for the DE23-Lite board, navigate to the DE23-Lite/scripts folder, set up the INSTALL variable and then run the command "make -f NiosVg.mk". This command will generate a set of .qsys files in the scripts directory. These files specify all components and their interconnections for the computer system that is being made. Now, you can create the computer system hardware circuit by running the command "make -f NiosVg.mk continue". This command will make a folder called "out" in the filesystem location ..\ (the parent folder of the scripts folder). The makefile will copy into the "out" folder the .qsys files and the top-level Verilog and Quartus project files for the computer system. Then, the makefile will run the Platform Designer software to generate the Verilog code for the computer system (corresponding to the components and connections in the .qsys files), and then compile this Verilog code by using the Quartus Prime software. The compilation process will create an FPGA programming file such as \<system name\>.sof, which can be downloaded into your FPGA board. 


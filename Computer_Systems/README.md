# Computer System

We have designed a series of Computer Systems specifically for the DE-series boards. Each board has one or more systems depending on the included processor(s) within the system. In addition to one or more processors, the systems include memory ports, basic input/output ports (for switches, lights, etc.), and multimedia ports (for video, audio, and the like). Accompanying the systems, is a set of sample programs. To start using the Computer Systems, please download them from the [Design Examples releases](https://github.com/fpgacademy/Design_Examples/releases) page and read the associated user manual for the target board and processor.

## Repo Contents

This repo contains the source code for building the Computer Systems and Documentation and the sample programs with the following directory structure:
    
    Computer_Systems/
    +-- <Board Name>/
    │   +-- doc/
    │   │       - Documentation for the Computer Systems of the given board 
    │   +-- scripts/
    │   │       - Makefile and TCL scripts for building and compiling the various Computer System for the given board
    │   +-- software/
    │   │       - Software header files with the address map of all the system components. These are used by the sample programs.
    │   +-- src/
    │           - Source files, such as the Quartus software project files, required by the scripts
    +-- common/
    │   +-- doc/
    │   │       - System component description used by multiple system/boards 
    │   +-- figs/
    │   │       - Contains figures and diagrams used in the documents of multiple system/boards 
    │   +-- scripts/
    │           - Contains generic Makefile and TCL scripts used by multiple system/boards 
    +-- sample_programs/
        +-- <Processor Type>
            +-- <Programming Language>
                    -Sample program demostrating how to write software for the given processor and programming language

## Modifying the Computer Systems

The Computer Systems are build using a set of TCL scripts that run within Altera's Platform Designer software. Complete each of the following sections to modify and update the Computer Systems.

### Source Code

Download a copy of this _Design Example Repository_ to your computer, using a tool of your choice such as _Command-Line Git_, _GitHub Desktop_, etc.

### Quartus Prime Software

Download and install an appropriate version of the Quartus Prime software. Links to the download pages for the various versions of the software are found at https://www.altera.com/products/development-tools/quartus-prime. 
We recommend using the latest version of the *Quartus Prime **Pro** Edition* software when targetting the DE25-Standard, DE25-Nano or DE23-Lite boards. We recommend using the latest version of the *Quartus Prime **Standard** Edition* software when targetting the DE10-Standard, DE10-Nano, DE10-Lite or DE1-SoC boards, unless you are using the Nios II processor. In this case, we recommend using version 23.1 of the *Quartus Prime **Standard** Edition* software.

### Nios II Command Shell

The scipts are designed to run within the Nios II Command Shell.
- Windows:
    1. Opening a command prompt
    2. Navigating to the *\<altera install directory\>/nios2eds/* directory
    3. Executing the *\"Nios II Command Shell.bat\"* script
- Linux:
    1. Opening a terminal window
    2. Navigating to the *\<altera install directory\>/nios2eds/* directory
    3. Executing the *nios2_command_shell.sh* script

### Makefiles

Finally, navigate to the scripts directory for your choosen board within the *Nios II Command Shell*. In the scripts directory, you'll find one or more Makefile, named *.mk, depending on how many system exist for the board. For example, the DE1-SoC has 3 systems; one for the ARM and Nios II processors (ARM_NiosII.mk), one for the Nios V/g processor (NiosVg.mk) and one for the Nios V/m processor (NiosVm.mk). The Makefile can be run using the *\"make -f \<system name\>.mk\"*, such as *\"make -f ARM_NiosII.mk\"*. The Makefiles have several targets. The main targets are:

- Default: Create the Platform Designer system
- continue: Generates the system's HDL description in Platform Designer and then compiles the circuit using the Quartus Prime software.
- all: Runs both the Default and continue targets


These scripts are provided for building the DE10-Standard Computer with Nios V. Before running
the scripts you have to install the necessary software and IP, as described below.

Quartus Prime
-------------

Download and install an appropriate version of the Quartus Prime software. We recommend using 
the latest version of the Quartus Prime Standard or Lite Edition software for targeting the 
DE10-Standard board.

IP Cores
--------

The DE10-Standard Computer System with Nios V requires a set of IP Core components that can be
obtained from their GitHub repository, at https://github.com/fpgacademy/IP_Cores. Follow the
instructions provided in that repository to install these IP Cores.

Building the DE10-Standard Computer System with Nios V
--------------------------------------------------

You have to specify the location where you have installed the Quartus Prime Standard or Lite 
software. To complete this step open the file named paths.mk, and set the INSTALL variable as 
needed. For example: 

INSTALL = C:/altera_lite/25.1std

You are now ready to run the provided makefiles, and scripts, for building the DE10-Standard
Computer with Nios V. These scripts have to be executed in a Linux command-line environment. 
If using a Windows computer:

1. open a Ubuntu Linux Terminal by using WSL (Windows Subsystem for Linux)
2. in the Ubuntu Terminal execute the command 
   
   make -f NiosVg.mk

   This command builds a Platform Designer system that contains several subsystems: 
   audio in/out, video-in/out subsystem, edge detection, character-buffer video-out, and 
   the main NiosVg computer system.

3. The next steps are to generate Verilog code and IP configuration for the platform 
   designer system, include this generated code, along with a top-level Verilog file for the 
   DE10-Standard Computer with Nios V, into a Quartus project, and then compile that project
   using Quartus Prime Standard or Lite. To perform these steps, execute the command
   
   make -f NiosVg.mk continue

4. At this point the DE10-Standard Computer with Nios V has been built and can be downloaded 
   into a DE10-Standard board. Once you have a board properly connected to your computer using a
   USB Blaster connection, execute the command

   make -f NiosVg.mk board

Now, your board should be successfully configured with the computer system, and you can run 
Nios V code on this system.

Notes
-----

There are other Makefile targets that you can use, if desired. For examples the target "all" 
runs both steps 2. and 3., above. The target "detect" reports the device(s) found on your 
JTAG cable, and the target "clean" erases temporary files. You can examine the makefile 
commands by looking at the file named ../../common/scripts/common.mk. This makefile executes
several Tcl (Tool Command Language) scripts, including common.tcl, gen_niosvg_computer.tcl, 
and others.

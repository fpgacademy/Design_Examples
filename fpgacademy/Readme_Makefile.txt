The fpgacademy.zip archive in the fpgacademy folder contains the Nios V custom cygwin tools, 
which include the C compiler, linker, etc, and the computer systems .sof files. 

To make an update to the fpgacademy.zip file, in Ubuntu WSL first run:

make SOF

This command updates the computer systems SOF files in the Computer_Systems
folder (by copying from the Design_Examples repo source files)

then, Create a new zip file by running

make ZIP

This command first saves a copy of fpgacademy.zip (named using the current
date), and then makes a new fpgacademy.zip. Alternately, you can zip up the three folders 
AMP, Computer_Systems, and GDB by using "Compress to" in the Windows GUI (this command is 
much faster to execute than running zip via WSL).


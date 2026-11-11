The fpgacademy.zip archive in the fpgacademy folder contains the Nios V custom cygwin tools, 
which include the C compiler, linker, etc, and the computer systems .sof files. 

To make an update to the fpgacademy.zip file:

1. Extract (if not previously done) into THIS folder all files and folders inside the current
version of the fpgacademy.zip file. This step is needed so that you have all of the source files
that have to be included in the fpgacademy.zip archive, before creating your new zip archive.
The extracted folders will be named AMP, Computer_Systems, and GDB.

2. Then, in Ubuntu WSL run:

make SOF

This command updates the computer systems SOF files in the Computer_Systems
folder (by copying from the Design_Examples repo source files).

3. Finally, create a new zip file by running:

make ZIP

This command first saves a copy of fpgacademy.zip (named using the current
date), and then makes a new fpgacademy.zip. Alternately, you can zip up the three folders 
AMP, Computer_Systems, and GDB by using "Compress to" in the Windows GUI (this command is 
much faster to execute than running zip via WSL).


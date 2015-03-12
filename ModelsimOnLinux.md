Altera have a free edition of Modelsim for Linux. Download and install it.

Once it's installed nothing will happen.

Attempt to run it by going to a shell and running
<path to installation>/bin/vsim

If you get an error along the lines of "can't find libXft.so.2" try installing the ia32 libraries
sudo apt-get install ia32-libs

Run again and hopefully it will spring into life

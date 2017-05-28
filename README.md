# GPN 2017 Badge trashVNC server

trashVNC allows you to use your GPN 2017 badge as an external monitor. This is done via a simple UDP protocol-server on the ESP and a script on the computer-side.

To use trashVNC simply download the shell script from [this gist](https://gist.github.com/rroohhh/2fe5d2738be818bf80db979d61f91a1c), connect to the wifi hotspot of your badge and run the script.

## Requirements

For the PC side to work properly, you will need to have a GNU/Linux system with the following packages installed:
* Python3
* PyAutoGui
* xrandr
* gstreamer with xvideosrc

## ROMstore

You can also download this ROM from the (GPN romstore)[https://badge.entropia.de/roms/details/24/].

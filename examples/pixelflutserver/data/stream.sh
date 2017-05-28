#!/bin/bash
xrandr --newmode "480x480_60.00"   17.50  480 496 536 592  480 483 493 500 -hsync +vsync
xrandr --addmode VIRTUAL1 480x480_60.00
xrandr --output VIRTUAL1 --mode 480x480_60.00 --left-of $(xrandr | head -n2 | tail -n1 | sed 's/\ .*$//g')
gst-launch-1.0 -q -e ximagesrc endx=479 endy=479 ! video/x-raw,format=BGRx,framerate=25/1,width=480,height=480 ! videoscale ! videoconvert ! videorate ! video/x-raw,format=RGB16,framerate=25/1,width=128,height=128 ! fpsdisplaysink video-sink=fdsink sync=false async=true | dd conv=swab bs=1024 | python3 -c "
import sys
import socket
import os
import time

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.setblocking(False)

total_lines = 128
line_length = 256
chunk_size = 4

fuzzyness = 50
up = True
down = True
right = True
left = True
first = False

def fuzzy_match(v, t, f):
    return(t - f < v and t + f > v)

with os.fdopen(sys.stdin.fileno(), 'rb') as stdin:
    while True:
        last = time.time()
        for c in range(int(total_lines / chunk_size)):
            try:
                sock.sendto((c * line_length * chunk_size).to_bytes(2, byteorder = 'little') 
                         + stdin.read(line_length * chunk_size)
                         , ('10.0.0.1', 1337))
            except:
                pass
        print(1 / (time.time() - last))
" &

python3 -c "
import sys                                                                                                                                                                                                [40/49868]
import socket           
import os               
import time            
import pyautogui        
import _thread                            
                 
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', 1337))     
                                   
fuzzyness = 50                     
up = True            
down = True            
right = True             
left = True            
first = False           
bttn = True                                
                
def fuzzy_match(v, t, f):            
    return(t - f < v and t + f > v)
                                   
while True:                         
    by = sock.recv(4)
    joy = int.from_bytes(by[:2], byteorder='little')
    btn = by[2]         
    print(joy, btn)     
    print(by)           
    if btn:
        if bttn:     
            pyautogui.keyDown('enter')
            bttn = False         
        else:                      
            pyautogui.keyUp('enter')
            bttn = True             
                     
    if fuzzy_match(joy, 780, fuzzyness):
        if up:          
            pyautogui.keyDown('up')
            pyautogui.keyUp('down')
            pyautogui.keyUp('left')
            pyautogui.keyUp('right')
            up = False                         
            down = True
            right = True
            left = True
            first = True
    elif fuzzy_match(joy, 630, fuzzyness):
        if down:
            pyautogui.keyDown('down')
            pyautogui.keyUp('up')
            pyautogui.keyUp('left')
            pyautogui.keyUp('right')
            up = True
            down = False
            right = True
            left = True 
            first = True                   
    elif fuzzy_match(joy, 530, fuzzyness):
        if right:                    
            pyautogui.keyDown('right')
            pyautogui.keyUp('up')  
            pyautogui.keyUp('down') 
            pyautogui.keyUp('left')
            up = True                               
            down = True 
            right = False
            left = True 
            first = True
    elif fuzzy_match(joy, 1024, fuzzyness):
        if left:                      
            pyautogui.keyDown('left')
            pyautogui.keyUp('up')  
            pyautogui.keyUp('down') 
            pyautogui.keyUp('right')
            up = True
            down = True                 
            right = True
            left = False           
            first = True           
    else:                          
        print('shit')               
        if first:                              
            pyautogui.keyUp('up')
            pyautogui.keyUp('down')
            pyautogui.keyUp('left')
            pyautogui.keyUp('right')
            up = True                     
            down = True
            right = True             
            left = True          
            first = False          
"
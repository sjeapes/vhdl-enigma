EESchema Schematic File Version 2  date Mon 24 Mar 2014 21:55:02 GMT
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:enigma_board
EELAYER 25  0
EELAYER END
$Descr A3 16535 11700
encoding utf-8
Sheet 1 7
Title "Enigma - Top Sheet"
Date "24 mar 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Bus Line
	4550 3450 3050 3450
Wire Bus Line
	4550 2950 3050 2950
$Sheet
S 1650 7400 800  650 
U 53308CDD
F0 "Power" 60
F1 "power.sch" 60
$EndSheet
$Sheet
S 2200 3300 850  300 
U 53308CC4
F0 "Plugboard" 60
F1 "Plugboard.sch" 60
F2 "PLUG[0..25]" U R 3050 3450 60 
$EndSheet
$Sheet
S 8050 3950 1200 550 
U 53308CAB
F0 "Wheel Buttons" 60
F1 "wheel_buttons.sch" 60
$EndSheet
$Sheet
S 2200 2800 850  300 
U 53308C1B
F0 "Keyboard" 60
F1 "keyboard.sch" 60
F2 "KEY[0..25]" U R 3050 2950 60 
$EndSheet
$Sheet
S 8050 2400 1250 1150
U 53308C10
F0 "LCD" 60
F1 "LCD.sch" 60
$EndSheet
$Sheet
S 4550 2350 2000 3200
U 53308C00
F0 "CPLD" 60
F1 "cpld.sch" 60
F2 "KEY[0..25]" U L 4550 2950 60 
F3 "PLUG[0..25]" U L 4550 3450 60 
$EndSheet
$EndSCHEMATC

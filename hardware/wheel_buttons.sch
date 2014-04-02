EESchema Schematic File Version 2  date Tue 25 Mar 2014 19:29:54 GMT
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
LIBS:topsheet-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 4 7
Title "Enigma - Wheel Buttons"
Date "25 mar 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 3000 5000 2    60   UnSpc ~ 0
WHEEL_UP[0..3]
Text GLabel 3150 4600 2    60   UnSpc ~ 0
WHEEL_DWN[0..3]
Wire Bus Line
	3150 4600 3050 4600
Wire Bus Line
	3050 4600 3050 1100
Wire Wire Line
	3150 2850 3800 2850
Wire Wire Line
	3150 1000 3800 1000
Wire Wire Line
	3150 1900 3800 1900
Wire Wire Line
	3150 3750 3800 3750
Wire Wire Line
	1600 3700 2250 3700
Wire Wire Line
	1600 1850 2250 1850
Wire Wire Line
	1600 950  2250 950 
Wire Wire Line
	1600 2800 2250 2800
Wire Bus Line
	2350 1050 2350 5000
Wire Bus Line
	2350 5000 3000 5000
Text Label 3750 1000 2    60   ~ 0
WHEEL_DWN0
Text Label 3750 1900 2    60   ~ 0
WHEEL_DWN1
Text Label 3750 2850 2    60   ~ 0
WHEEL_DWN2
Text Label 3750 3750 2    60   ~ 0
WHEEL_DWN3
Text Label 2200 3700 2    60   ~ 0
WHEEL_UP3
Text Label 2200 2800 2    60   ~ 0
WHEEL_UP2
Text Label 2200 1850 2    60   ~ 0
WHEEL_UP1
Text Label 2200 950  2    60   ~ 0
WHEEL_UP0
Entry Wire Line
	2250 950  2350 1050
Entry Wire Line
	2250 1850 2350 1950
Entry Wire Line
	2250 2800 2350 2900
Entry Wire Line
	2250 3700 2350 3800
Entry Wire Line
	3050 3850 3150 3750
Entry Wire Line
	3050 2950 3150 2850
Entry Wire Line
	3050 2000 3150 1900
Entry Wire Line
	3050 1100 3150 1000
$Comp
L CAPBUTTON SW?
U 1 1 5330A714
P 4350 3750
F 0 "SW?" H 4350 4050 60  0000 C CNN
F 1 "CAPBUTTON" H 4400 3450 60  0000 C CNN
	1    4350 3750
	-1   0    0    -1  
$EndComp
$Comp
L CAPBUTTON SW?
U 1 1 5330A712
P 4350 2850
F 0 "SW?" H 4350 3150 60  0000 C CNN
F 1 "CAPBUTTON" H 4400 2550 60  0000 C CNN
	1    4350 2850
	-1   0    0    -1  
$EndComp
$Comp
L CAPBUTTON SW?
U 1 1 5330A70E
P 4350 1900
F 0 "SW?" H 4350 2200 60  0000 C CNN
F 1 "CAPBUTTON" H 4400 1600 60  0000 C CNN
	1    4350 1900
	-1   0    0    -1  
$EndComp
$Comp
L CAPBUTTON SW?
U 1 1 5330A70C
P 4350 1000
F 0 "SW?" H 4350 1300 60  0000 C CNN
F 1 "CAPBUTTON" H 4400 700 60  0000 C CNN
	1    4350 1000
	-1   0    0    -1  
$EndComp
$Comp
L CAPBUTTON SW?
U 1 1 5330A709
P 1050 3700
F 0 "SW?" H 1050 4000 60  0000 C CNN
F 1 "CAPBUTTON" H 1100 3400 60  0000 C CNN
	1    1050 3700
	1    0    0    -1  
$EndComp
$Comp
L CAPBUTTON SW?
U 1 1 5330A705
P 1050 2800
F 0 "SW?" H 1050 3100 60  0000 C CNN
F 1 "CAPBUTTON" H 1100 2500 60  0000 C CNN
	1    1050 2800
	1    0    0    -1  
$EndComp
$Comp
L CAPBUTTON SW?
U 1 1 5330A700
P 1050 1850
F 0 "SW?" H 1050 2150 60  0000 C CNN
F 1 "CAPBUTTON" H 1100 1550 60  0000 C CNN
	1    1050 1850
	1    0    0    -1  
$EndComp
$Comp
L CAPBUTTON SW?
U 1 1 5330A6FD
P 1050 950
F 0 "SW?" H 1050 1250 60  0000 C CNN
F 1 "CAPBUTTON" H 1100 650 60  0000 C CNN
	1    1050 950 
	1    0    0    -1  
$EndComp
$EndSCHEMATC

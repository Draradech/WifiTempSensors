EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ESP8266:ESP-03 U2
U 1 1 6082D056
P 6250 2700
F 0 "U2" H 5750 3400 50  0000 C CNN
F 1 "ESP-03" H 6600 3400 50  0000 C CNN
F 2 "ESP8266:ESP-03" H 6250 2800 50  0001 C CNN
F 3 "http://l0l.org.uk/2014/12/esp8266-modules-hardware-guide-gotta-catch-em-all/" H 6250 2800 50  0001 C CNN
	1    6250 2700
	1    0    0    -1  
$EndComp
$Comp
L Sensor_Temperature:DS18B20 U1
U 1 1 6082F0E0
P 3650 2650
F 0 "U1" H 3420 2696 50  0000 R CNN
F 1 "DS18B20" H 3420 2605 50  0000 R CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 2650 2400 50  0001 C CNN
F 3 "http://datasheets.maximintegrated.com/en/ds/DS18B20.pdf" H 3500 2900 50  0001 C CNN
	1    3650 2650
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery_Cell BT1
U 1 1 60830A94
P 2200 2700
F 0 "BT1" H 2318 2796 50  0000 L CNN
F 1 "Battery_Cell" H 2318 2705 50  0000 L CNN
F 2 "battery:BLM_26650" V 2200 2760 50  0001 C CNN
F 3 "~" V 2200 2760 50  0001 C CNN
	1    2200 2700
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05_Female J1
U 1 1 60836E9C
P 8600 2650
F 0 "J1" H 8650 2700 50  0000 L CNN
F 1 "Conn_01x05_Female" H 8650 2800 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Vertical" H 8600 2650 50  0001 C CNN
F 3 "~" H 8600 2650 50  0001 C CNN
	1    8600 2650
	1    0    0    1   
$EndComp
$Comp
L Connector:Conn_01x03_Female J2
U 1 1 60838866
P 10100 2750
F 0 "J2" H 10150 2700 50  0000 L CNN
F 1 "Conn_01x03_Female" H 10150 2800 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 10100 2750 50  0001 C CNN
F 3 "~" H 10100 2750 50  0001 C CNN
	1    10100 2750
	1    0    0    1   
$EndComp
Wire Wire Line
	2200 2500 2200 1500
Wire Wire Line
	1700 1500 1750 1500
Connection ~ 2200 1500
Wire Wire Line
	1700 4000 1750 4000
Wire Wire Line
	3650 2350 3650 1500
Text Label 3950 2650 0    50   ~ 0
OneWire
Text Label 7150 2800 0    50   ~ 0
OneWire
Text Label 9900 2750 2    50   ~ 0
OneWire
Wire Wire Line
	9900 2650 9750 2650
Wire Wire Line
	9750 2650 9750 1500
Wire Wire Line
	9900 2850 9750 2850
Text Label 8400 2750 2    50   ~ 0
RX
Text Label 8400 2650 2    50   ~ 0
TX
Text Label 8400 2450 2    50   ~ 0
Boot
Text Label 8400 2550 2    50   ~ 0
Reset
Text Label 5350 2500 2    50   ~ 0
TX
Text Label 5350 2600 2    50   ~ 0
RX
$Comp
L Device:R R2
U 1 1 6083B873
P 5000 2000
F 0 "R2" H 5070 2046 50  0000 L CNN
F 1 "10k" H 5070 1955 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 4930 2000 50  0001 C CNN
F 3 "~" H 5000 2000 50  0001 C CNN
	1    5000 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 2800 5000 2800
Wire Wire Line
	5000 2800 5000 2150
Wire Wire Line
	5000 1850 5000 1500
Connection ~ 5000 1500
Wire Wire Line
	5000 1500 6250 1500
Wire Wire Line
	6250 1800 6250 1500
Connection ~ 6250 1500
Wire Wire Line
	6250 1500 7600 1500
Connection ~ 6250 4000
Wire Wire Line
	6250 4000 7600 4000
$Comp
L Device:R R3
U 1 1 6083D48C
P 7600 2000
F 0 "R3" H 7670 2046 50  0000 L CNN
F 1 "10k" H 7670 1955 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 7530 2000 50  0001 C CNN
F 3 "~" H 7600 2000 50  0001 C CNN
	1    7600 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 2400 7600 2400
Wire Wire Line
	7600 2400 7600 2150
Wire Wire Line
	7600 1850 7600 1500
Connection ~ 7600 1500
Text Label 5350 2800 2    50   ~ 0
Reset
Text Label 7150 2400 0    50   ~ 0
Boot
$Comp
L Device:R R4
U 1 1 6083EF04
P 7600 3500
F 0 "R4" H 7670 3546 50  0000 L CNN
F 1 "10k" H 7670 3455 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 7530 3500 50  0001 C CNN
F 3 "~" H 7600 3500 50  0001 C CNN
	1    7600 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 2600 7600 2600
Wire Wire Line
	7600 2600 7600 3350
Connection ~ 7600 4000
Connection ~ 9750 4000
Wire Wire Line
	9750 4000 10250 4000
Connection ~ 8250 4000
Wire Wire Line
	8250 4000 9750 4000
Wire Wire Line
	7600 4000 8250 4000
NoConn ~ 7150 2500
NoConn ~ 7150 2700
NoConn ~ 7150 2900
NoConn ~ 5350 2900
NoConn ~ 5350 2700
$Comp
L power:PWR_FLAG #FLG02
U 1 1 608473B4
P 1700 4000
F 0 "#FLG02" H 1700 4075 50  0001 C CNN
F 1 "PWR_FLAG" V 1700 4127 50  0000 L CNN
F 2 "" H 1700 4000 50  0001 C CNN
F 3 "~" H 1700 4000 50  0001 C CNN
	1    1700 4000
	0    -1   -1   0   
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 60847AC3
P 1700 1500
F 0 "#FLG01" H 1700 1575 50  0001 C CNN
F 1 "PWR_FLAG" V 1700 1627 50  0000 L CNN
F 2 "" H 1700 1500 50  0001 C CNN
F 3 "~" H 1700 1500 50  0001 C CNN
	1    1700 1500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7600 1500 9750 1500
Wire Wire Line
	8250 2850 8400 2850
Connection ~ 9750 1500
Wire Wire Line
	9750 1500 10250 1500
$Comp
L Device:R R1
U 1 1 60869DD1
P 4350 2000
F 0 "R1" H 4420 2046 50  0000 L CNN
F 1 "10k" H 4420 1955 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 4280 2000 50  0001 C CNN
F 3 "~" H 4350 2000 50  0001 C CNN
	1    4350 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 2650 4350 2650
Wire Wire Line
	4350 2650 4350 2150
Wire Wire Line
	4350 1850 4350 1500
Wire Wire Line
	4350 1500 3650 1500
Wire Wire Line
	4350 1500 5000 1500
Wire Wire Line
	3650 4000 6250 4000
Wire Wire Line
	2200 1500 3650 1500
Connection ~ 3650 1500
Connection ~ 4350 1500
Connection ~ 2200 4000
Connection ~ 3650 4000
Wire Wire Line
	2200 4000 3650 4000
Wire Wire Line
	2200 2800 2200 4000
Wire Wire Line
	3650 2950 3650 4000
Wire Wire Line
	6250 3500 6250 4000
Wire Wire Line
	7600 3650 7600 4000
Wire Wire Line
	8250 2850 8250 4000
Wire Wire Line
	9750 2850 9750 4000
$Comp
L power:+3.3V #PWR0101
U 1 1 60887AD1
P 1750 1450
F 0 "#PWR0101" H 1750 1300 50  0001 C CNN
F 1 "+3.3V" H 1765 1623 50  0000 C CNN
F 2 "" H 1750 1450 50  0001 C CNN
F 3 "" H 1750 1450 50  0001 C CNN
	1    1750 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 1450 1750 1500
Connection ~ 1750 1500
Wire Wire Line
	1750 1500 2200 1500
$Comp
L power:GND #PWR0102
U 1 1 60889375
P 1750 4050
F 0 "#PWR0102" H 1750 3800 50  0001 C CNN
F 1 "GND" H 1755 3877 50  0000 C CNN
F 2 "" H 1750 4050 50  0001 C CNN
F 3 "" H 1750 4050 50  0001 C CNN
	1    1750 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 4050 1750 4000
Connection ~ 1750 4000
Wire Wire Line
	1750 4000 2200 4000
$EndSCHEMATC

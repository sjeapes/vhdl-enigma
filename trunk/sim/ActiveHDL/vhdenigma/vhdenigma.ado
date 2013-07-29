setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/svn/vhdl-enigma/sim/ActiveHDL/vhdenigma/vhdenigma.adf"]} { 
	design create vhdenigma "C:/svn/vhdl-enigma/sim/ActiveHDL"
  set newDesign 1
}
design open "C:/svn/vhdl-enigma/sim/ActiveHDL/vhdenigma"
cd "C:/svn/vhdl-enigma/sim/ActiveHDL"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/svn/vhdl-enigma/rtl/letters_pak.vhd"
addfile "C:/svn/vhdl-enigma/rtl/debounce.vhd"
addfile "C:/svn/vhdl-enigma/rtl/reflector.vhd"
addfile "C:/svn/vhdl-enigma/rtl/plugboard.vhd"
addfile "C:/svn/vhdl-enigma/rtl/wheel.vhd"
addfile "C:/svn/vhdl-enigma/rtl/machine.vhd"
addfile "C:/svn/vhdl-enigma/rtl/top_level.vhd"
vlib "C:/svn/vhdl-enigma/sim/ActiveHDL/vhdenigma/work"
set worklib work
adel -all
vcom -dbg -work work "C:/svn/vhdl-enigma/rtl/letters_pak.vhd"
vcom -dbg -work work "C:/svn/vhdl-enigma/rtl/debounce.vhd"
vcom -dbg -work work "C:/svn/vhdl-enigma/rtl/reflector.vhd"
vcom -dbg -work work "C:/svn/vhdl-enigma/rtl/plugboard.vhd"
vcom -dbg -work work "C:/svn/vhdl-enigma/rtl/wheel.vhd"
vcom -dbg -work work "C:/svn/vhdl-enigma/rtl/machine.vhd"
vcom -dbg -work work "C:/svn/vhdl-enigma/rtl/top_level.vhd"
entity top_level
vsim +access +r top_level   -PL pmi_work -L ovi_machxo2
add wave *
run 1000ns

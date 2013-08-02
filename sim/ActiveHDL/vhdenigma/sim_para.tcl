lappend auto_path "C:/lscc/diamond/2.2_x64/data/script"
package require simulation_generation
set ::bali::simulation::Para(PROJECT) {vhdenigma}
set ::bali::simulation::Para(PROJECTPATH) {C:/svn/vhdl-enigma/sim/ActiveHDL}
set ::bali::simulation::Para(FILELIST) {"C:/svn/vhdl-enigma/rtl/letters_pak.vhd" "C:/svn/vhdl-enigma/rtl/debounce.vhd" "C:/svn/vhdl-enigma/rtl/reflector.vhd" "C:/svn/vhdl-enigma/rtl/plugboard.vhd" "C:/svn/vhdl-enigma/rtl/wheel.vhd" "C:/svn/vhdl-enigma/rtl/machine.vhd" "C:/svn/vhdl-enigma/rtl/top_level.vhd" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" "work" "work" "work" }
set ::bali::simulation::Para(COMPLIST) {"VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo2}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {top_level}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {VHDL}
set ::bali::simulation::Para(SDFPATH)  {}
set ::bali::simulation::Para(ADDTOPLEVELSIGNALSTOWAVEFORM)  {1}
set ::bali::simulation::Para(RUNSIMULATION)  {1}
set ::bali::simulation::Para(POJO2LIBREFRESH)    {}
set ::bali::simulation::Para(POJO2MODELSIMLIB)   {}
::bali::simulation::ActiveHDL_Run

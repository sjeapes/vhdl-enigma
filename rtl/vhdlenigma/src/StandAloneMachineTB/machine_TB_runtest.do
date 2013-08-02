SetActiveLib -work
comp -include "C:\svn\vhdl-enigma\rtl\machine.vhd" 
comp -include "$dsn\src\StandAloneMachineTB\machine_TB.vhd" 
asim +access +r TESTBENCH_FOR_machine 
wave 
wave -noreg clk_in
wave -noreg reset_in
wave -noreg sig_in
wave -noreg sig_out
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\StandAloneMachineTB\machine_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_machine 


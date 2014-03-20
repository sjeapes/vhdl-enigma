vsim work.bench
add wave -position insertpoint sim:/bench/dut/*
add wave -position insertpoint sim:/bench/dut/wheels(0)/rotor/*
add wave -position insertpoint sim:/bench/dut/wheels(1)/rotor/*
add wave -position insertpoint sim:/bench/dut/wheels(2)/rotor/*
run -all

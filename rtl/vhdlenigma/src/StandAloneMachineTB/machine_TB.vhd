library vhdlenigma;
use vhdlenigma.letters_pak.all;
use vhdlenigma.wheel_config_pak.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity machine_tb is
	-- Generic declarations of the tested unit
		generic(
		num_wheels : INTEGER := 3;
		wheel_order : t_wheel_order := ('4','3','2','1')
		);
end machine_tb;

architecture TB_ARCHITECTURE of machine_tb is
	-- Component declaration of the tested unit
	component machine
		generic(
		num_wheels : INTEGER := 3;
		wheel_order : t_wheel_order
		);
	port(
		clk_in : in STD_LOGIC;
		reset_in : in STD_LOGIC;
		sig_in : in letter;
		sig_out : out letter );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk_in : STD_LOGIC;
	signal reset_in : STD_LOGIC;
	signal sig_in : letter;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal sig_out : letter;

	-- Add your code here ...

begin
			-- Unit Under Test port map
	UUT : machine
		generic map (
			num_wheels => 3,
			wheel_order => ('4','3','2','1')
		)

		port map (
			clk_in => clk_in,
			reset_in => reset_in,
			sig_in => sig_in,
			sig_out => sig_out
		);

clock_gen: process
begin
	clk_in <= '0';
	wait for 10 ns;
	clk_in <= '1';
	wait for 10 ns;
end process;

reset_in <= '0', '1' after 50 ns; 

tb: process
begin 
	sig_in <= a;
	wait for 200 ns; --! 200ns wait to let everything settle down during/after reset
	
	sig_in <= b;
	
		
		



	assert false
	report "Test Complete - no other messages = good"
	severity note;

end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_machine of machine_tb is
	for TB_ARCHITECTURE
		for UUT : machine
			use entity work.machine(rtl);
		end for;
	end for;
end TESTBENCH_FOR_machine;


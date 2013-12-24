--Filename: smoketest_tb.vhdl
--
--Description: 
--Basic Test Bench
--Used for sanity checking some basic patterns. Far from a comprehensive test
--
--
--    Copyright (C) 2013 Stephen Jeapes (vhdl-enigma@arcoarena.co.uk)
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

use work.letters_pak.all;
use work.wheel_config_pak.all;

entity bench is
  generic(
      clk_period : time := 100 ns;
      num_wheels: integer := 3; --! The number of wheels in the machine, only 3 or 4 are valid
      wheel_order: t_wheel_order := ('4','3','2','1') --! The wheels fitted in the machine, hi    
  );
  port (
      test_running : inout boolean := true
  );

end entity;

architecture behav of bench is

component machine
   generic(
      num_wheels: integer := 3; --! The number of wheels in the machine, only 3 or 4 are valid
      wheel_order: t_wheel_order := ('4','3','2','1') --! The wheels fitted in the machine, highest wheel number to lowest
   );

   port 
   (
      clk_in   :  inout std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! reset_in signal, ('1' = reset_in)
      sig_in   :  in letter;
 
      sig_out  :  out letter
   );

end component;


signal clk_tb, reset_tb : std_logic := '1';
signal sig_tb : letter := ' ';

begin
  

process
  begin
    clk_tb <= '1';
    wait for clk_period;
    clk_tb <= '0';
    wait for clk_period;
  end process;

reset_tb <= '1', '0' after 50 ns;
  
process
  
  
  begin
    test_running <= TRUE;  
    
    
    wait for 5000 ns;
    
    
    
    
    for i in 0 to 10 loop
		sig_tb <= a;
		wait for 2000 ns;
		sig_tb <= ' ';
		wait for 2000 ns;
	end loop;
    
    
    
    test_running <= FALSE;
    wait for 100 ns;
    
    assert test_running
    report "End of Testbench; No errors = Good"
    severity failure;
    
  end process;



dut: machine 
    port map(
      clk_in   => clk_tb,
      reset_in => reset_tb,
      sig_in   => sig_tb, 
      sig_out  => open      
    );
  
  
  
  
end architecture behav;

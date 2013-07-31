--Filename: top_level.vhd
--
--Description: 
--Top Level VHDL file for VHDL based Enigma Machine
--Contains all of the IO etc. 
--Structural file only, no behavioural code
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


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.letters_pak.all;
use work.wheel_config_pak.all;

entity top_level is
   port
   (
      -- Input ports
      clk         : in  std_logic; --! Input clock
      reset_n     : in  std_logic; --! Reset input signal ('0' = Reset)

      -- Inout ports
      sig_in      : in  letter; 

      -- Output ports
      sig_out     : out letter

   );
end top_level;

architecture rtl of top_level is

signal reset: std_logic;

component machine

   generic
   (
      num_wheels: integer := 3; --! The number of wheels in the machine, only 3 or 4 are valid
      wheel_order: wheel_order := ('1','2','3','4') --! The wheels fitted in the machine, highest wheel number to lowest
   );

   port
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
         
      reset_in :  in std_logic; --! Reset signal, ('1' = Reset)
      sig_in   :  in letter;
      
      sig_out  :  out letter      
   );

end component;



begin

reset <= reset_n;	
   
enigma_machine : machine 
   generic map
   (
      num_wheels => 3,
      wheel_order => ('4','3','2','1')
   )
   port map 
   (
      clk_in => clk,
      reset_in => reset,
      sig_in => sig_in,
      sig_out => sig_out
   );



end rtl;


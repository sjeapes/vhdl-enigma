--Filename: debounce.vhd
--
--Description: 
--Debounce module - synchronizes signals with clock domain 
--(clock domain provided on clock pin)
--Also, optionally debounces signals with configurable lengths 
--(to allow for either switch debounce or simple de-glitch)
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

entity debounce is

   generic
   (
      sig_width   :  natural := 1 --! Width of input bus
            --! for signle signals use '1' and assign array slice
      
      
      );

   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
         
      reset_in :  in std_logic; --! Reset signal, ('1' = Reset)
      sig_in   :  in std_logic_vector(sig_width-1 downto 0);
      
      sig_out  :  out std_logic_vector(sig_width-1 downto 0)
   );

end entity;

architecture rtl of debounce is



begin



end rtl;

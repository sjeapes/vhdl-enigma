--Filename: plugboard.vhd
--
--Description: 
-- Performs the actions of the plugboard
-- Initial file does not allow plugs and acts as if none are selected
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

use work.letters_pak.all;


entity plugboard is

   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! Reset signal, ('1' = Reset)
      siga_in  :  in letter;   --! Letter coming into the entity
      sigb_in  :  in letter;   --! Letter coming into the entity
      siga_out :  out letter;   --! Partially encoded letter leaving entity
      sigb_out :  out letter   --! Partially encoded letter leaving entity
   );

end entity;

architecture rtl of plugboard is

begin

--! Dummy statement for now, no plugboard settings supported
procPlugboard: process(clk_in, reset_in)
begin
   if reset_in = '1' then
      siga_out <= ' ';
      sigb_out <= ' ';
   elsif rising_edge(clk_in) then
      siga_out <= siga_in;
      sigb_out <= sigb_in;      
   end if;
end process;


end rtl;

--Filename: reflector.vhd
--
--Description: 
-- Performs the actions of the reflector
-- Currently only supports Reflector B
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

--Wiring for Umkehrwalzes B (non-rotatable) taken from:
-- http://www.ellsbury.com/ultraenigmawirings.htm


library ieee;
use ieee.std_logic_1164.all;

use work.letters_pack.all;


entity reflector is

   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! Reset signal, ('1' = Reset)
      sig_in   :  in letter;   --! Letter coming into the entity
      sig_out  :  out letter   --! Partially encoded letter leaving entity
	);

end entity;

architecture rtl of reflector is

type wiring is array (letter) of letter;
signal reflector_b: wiring := 
	(y,r,u,h,q,s,l,d,p,x,n,g,o,k,m,i,e,b,f,z,c,w,v,j,a,t);
	
begin

reflector: process(clk_in,reset_in)
begin
	if reset_in then
		sig_out <= a;
	elsif rising_edge(clk_in) then
		sig_out <= (sig_in)
	end if;
	
end process;


end rtl;

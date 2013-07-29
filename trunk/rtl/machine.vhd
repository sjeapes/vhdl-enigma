--Filename: machine.vhd
--
--Description: 
--Top Level Enigma Machine
--Structural file containing elements of machine
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

--!   This is a structural file which wires the sub-components together
--!   The wiring is Input -> Plugboard -> Wheels (low to high numbered)
--!               Reflector -> Wheels (high to low numbered) 
--!               Plugboard -> Output

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.letters_pak.all;


entity machine is
   generic(
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

end entity;

architecture rtl of machine is

component wheel
   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! Reset signal, ('1' = Reset)
      siga_in   :  in letter;   --! Letter coming into the entity
      sigb_in   :  in letter;   --! Letter coming into the entity
      siga_out  :  out letter;   --! Partially encoded letter leaving entity      
      sigb_out  :  out letter   --! Partially encoded letter leaving entity
   );
end component;

component reflector
   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! Reset signal, ('1' = Reset)
      siga_in   :  in letter;   --! Letter coming into the entity
      sigb_in   :  in letter;   --! Letter coming into the entity
      siga_out  :  out letter;   --! Partially encoded letter leaving entity      
      sigb_out  :  out letter   --! Partially encoded letter leaving entity
   );
end component;

component plugboard
   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
         
      reset_in :  in std_logic; --! Reset signal, ('1' = Reset)
      siga_in   :  in letter;   --! Letter coming into the entity
      sigb_in   :  in letter;   --! Letter coming into the entity
      siga_out  :  out letter;   --! Partially encoded letter leaving entity      
      sigb_out  :  out letter   --! Partially encoded letter leaving entity
   );
end component;

type		wheel_interconnect is array(natural range num_wheels*2 downto 0) of letter; --! Wiring type to create an array used in the generate statement below
signal 	wheel_inter_wiring: wheel_interconnect; --! Interconnect signals between wheels

signal   plugboard_wheels, 
         wheels_plugboard, 
         wheels_reflector, 
         reflectors_wheels: letter; --! Interconnect signals for rest of machine

begin

wheel_num: 
   for i in 0 to num_wheels generate
      rotor: wheel 
         port map 
         (
            clk_in   => clk_in,
            reset_in => reset_in,
            siga_in  => wheel_inter_wiring(i),
            sigb_in  => ' ',
            siga_out => wheel_inter_wiring(i+1),
            sigb_out => open
         );
   end generate;



stekerboard :plugboard
   port map 
   (
      clk_in   => clk_in,
      reset_in => reset_in,
      siga_in  => a,
      sigb_in  => a,
      siga_out => open,
      sigb_out => open
   );



umkehrwalze:reflector
   port map 
   (
      clk_in   => clk_in,
      reset_in => reset_in,
      siga_in  => a,
      sigb_in  => a,
      siga_out => open,
      sigb_out => open
   );



end rtl;

--Filename: wheel.vhd
--
--Description: 
-- Performs the actions of the wheels
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

--Wiring for wheels taken from:
-- http://www.ellsbury.com/ultraenigmawirings.htm


library ieee;
use ieee.std_logic_1164.all;

use work.letters_pak.all;
use work.wheel_config_pak.all;


entity wheel is
   generic
      (
      variant: wheel_variants := '1'
      );
   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! Reset signal, ('1' = Reset)
  
      --Wheel Atrributes and control
      turnover  :  in boolean; --! Input signal to tell the wheel to advance
      wheel_pos :  out letter; --! Output signal giving current wheel position
      wheel_set :  in letter;  --! Input used to set wheel position, when turnover = TRUE the wheel position will be set to the letter on this input signal, if this signal is set to ' ' it will be ignored
   
      siga_in   :  in letter;   --! Letter coming into the entity
      sigb_in   :  in letter;   --! Letter coming into the entity
      siga_out  :  out letter;   --! Partially encoded letter leaving entity      
      sigb_out  :  out letter   --! Partially encoded letter leaving entity
   );

end entity;

architecture rtl of wheel is

signal wheel_pos_int : letter;

begin

--! Dummy process for the moment to send data direct through wheel
wheelEncode: process(clk_in,reset_in)
begin
   if reset_in = '1' then
      siga_out <= ' ';
      sigb_out <= ' ';
   elsif rising_edge(clk_in) then
      siga_out <= encode_letter(siga_in, variant);
      sigb_out <= encode_letter(sigb_in, variant);
   end if;

end process;

--! Control of wheel position
--! Setting of wheel position is via the wheel_set signal (wheels set when turnover = TRUE)
--! Turnover = TRUE when wheel_set = ' ' advances the wheel by 1 position
wheelPos: process(clk_in, reset_in)
begin
   if reset_in = '1' then
      wheel_pos_int <= a;
   elsif rising_edge(clk_in) then
      if turnover then
         if wheel_set = ' ' then
            wheel_pos_int <= increment(wheel_pos_int);
         else
            wheel_pos_int <= wheel_set;
         end if;
      else
         wheel_pos_int <= wheel_pos_int;
      end if;
   end if;

end process;

wheel_pos <= wheel_pos_int;


end rtl;

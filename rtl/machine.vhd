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
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

use work.letters_pak.all;
use work.wheel_config_pak.all;


entity machine is
   generic(
      num_wheels: integer := 3; --! The number of wheels in the machine, only 3 or 4 are valid
      wheel_order: t_wheel_order := ('4','3','2','1') --! The wheels fitted in the machine, highest wheel number to lowest
   );

   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! reset_in signal, ('1' = reset_in)
      sig_in   :  in letter;
 
      sig_out  :  out letter
   );

end entity;

architecture rtl of machine is

component wheel
   generic
      (
      variant: wheel_variants
      );
   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! reset_in signal, ('1' = reset_in)
   
      --Wheel Atrributes and control
      turnover  :  in boolean; --! Input signal to tell the wheel to advance
      wheel_pos :  out letter; --! Output signal giving current wheel position
      wheel_set :  in letter;  --! Input used to set wheel position, when turnover = TRUE the wheel position will be set to the letter on this input signal, if this signal is set to ' ' it will be ignored 
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
      reset_in :  in std_logic; --! reset_in signal, ('1' = reset_in)
      sig_in   :  in letter;   --! Letter coming into the entity
      sig_out  :  out letter   --! Partially encoded letter leaving entity      
   );
end component;

component plugboard
   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
         
      reset_in :  in std_logic; --! reset_in signal, ('1' = reset_in)
      siga_in   :  in letter;   --! Letter coming into the entity
      sigb_in   :  in letter;   --! Letter coming into the entity
      siga_out  :  out letter;   --! Partially encoded letter leaving entity      
      sigb_out  :  out letter   --! Partially encoded letter leaving entity
   );
end component;

--! Internal machine wiring signals
type     wheel_interconnect is array(natural range num_wheels+1 downto 0) of letter; --! Wiring type to create an array used in the generate statement below
signal   wheel_inter_wiring_a,
         wheel_inter_wiring_b: wheel_interconnect; --! Interconnect signals between wheels

signal   plugboard_wheels, 
         wheels_plugboard, 
         wheels_reflector, 
         reflector_wheels: letter; --! Interconnect signals for rest of machine

 
--! Delayed input signal definitions; Used to detect key presses
signal  sig_in_d1, sig_in_d2, sig_in_d3:	letter; --! Internal delayed input signals for use in keypress detection and to ensure turnover occurs before encoding
signal  keypress: boolean; --! Boolean signal, will be single clock pulse long when a keypress is detected
signal  sig_out_int:	letter; --! Internal output signal, used to ensure output only changes once the signal has propogated through the 
signal  sig_out_counter: std_logic_vector(2 downto 0); --! Counter used to give enough clock cycles for signal to propogate through machine before output is updated

--! Turn-over control
type t_wheel_turnover is array(0 to 3) of boolean;
signal turnover_wheel : t_wheel_turnover;


type t_position is array(0 to 3) of letter; 
signal wheel_pos : t_position;


begin


stekerboard :plugboard
   port map 
   (
      clk_in   => clk_in,
      reset_in => reset_in,
      siga_in  => sig_in_d3, --! Input from keyboard
      sigb_in  => wheels_plugboard, --! Input from wheels going towards bulbs
      siga_out => plugboard_wheels, --! Output from plugboard going to wheels
      sigb_out => sig_out_int --! Output into internal signal which update output of machine after pre-defined delay
   );

--! Connections into and out of wheels
wheel_conn: process(wheel_inter_wiring_a,
               wheel_inter_wiring_b,
               plugboard_wheels, 
               wheels_plugboard, 
               wheels_reflector, 
               reflector_wheels)
begin
   wheel_inter_wiring_a(0) <= plugboard_wheels; --! Into the start of the wheels in the forward direction
   wheels_reflector <= wheel_inter_wiring_a(num_wheels); --! Out of the wheels into the reflector in the forward direction
   wheel_inter_wiring_b(num_wheels) <= reflector_wheels; --! Into the wheels in the reverse direction
   wheels_plugboard <= wheel_inter_wiring_b(0); --! Out of the wheels into the plugboard in the reverse direction	
end process;

wheels: 
   for i in 0 to num_wheels-1 generate
      rotor: wheel 
         generic map
         (
            variant => wheel_order(i)
         )  
         port map 
         (
            clk_in   => clk_in,
            reset_in => reset_in,
            turnover => turnover_wheel(i),
            wheel_pos => wheel_pos(i),
            wheel_set => ' ',
            siga_in  => wheel_inter_wiring_a(i),
            sigb_in  => wheel_inter_wiring_b(i+1),
            siga_out => wheel_inter_wiring_a(i+1),
            sigb_out => wheel_inter_wiring_b(i)
         );
   end generate;


umkehrwalze:reflector
   port map 
   (
      clk_in   => clk_in,
      reset_in => reset_in,
      sig_in  => wheels_reflector,
      sig_out => reflector_wheels   );
   
 --! Creates delayed versions of the input signal for use in other processes   
input_delay:process(clk_in, reset_in)
begin
   if (reset_in = '1') then 
      sig_in_d1 <= ' ';
      sig_in_d2 <= ' ';
      sig_in_d2 <= ' ';
   elsif rising_edge(clk_in) then
      sig_in_d1 <= sig_in;
      sig_in_d2 <= sig_in_d1;
      sig_in_d3 <= sig_in_d2;
   end if;
end process;   

--! Detects key press has occured based upond delayed signals
keypress_det:process(clk_in, reset_in)
begin
   if (reset_in = '1') then 
      keypress  <= FALSE;
   elsif rising_edge(clk_in) then
      if (sig_in_d2 /= sig_in_d1) and (sig_in_d1 /= ' ') then
         keypress <= TRUE;
      else
         keypress <= FALSE;
      end if;     
   end if;
end process;   

   
--! Wheel Turnover control process
--! This process sends a single clock cycle long pulse to each of the 4 wheels
--! in order for them to advance at the correct time
--! It uses the wheel values, the record of the wheel definition containing the turnover locations
--! and a delayed input signal (to detect key presses
--! N.B. On an Enigma machine the turnover happens on key pressing (i.e. BEFORE the letter is encoded)   
turnover_ctrl:process(clk_in, reset_in)
begin
   if (reset_in = '1') then
      turnover_wheel <= (others => FALSE);
   elsif rising_edge(clk_in)then
      turnover_wheel <= (others => FALSE);
      turnover_wheel(0) <= keypress;
      for i in 1 to 3 loop
        if turnover_wheel(i-1) then
			turnover_wheel(i) <= is_turnover_pos(wheel_pos(i-1), wheel_order(i-1));
		end if;
      end loop;
   end if;
end process;   

--! Controls the output signal
--! Delays the updating of the output signal from the machine for a pre-determined number of clock cyles to allow signal to propagate through machine
sig_out_ctrl:process(clk_in,reset_in)
begin
   if (reset_in='1') then
      sig_out_counter <= (others => '1'); --! reset_in at max value, counting down makes length of counter irrelevant to rest of code
   elsif rising_edge(clk_in) then
      if sig_out_counter > 0 then
         sig_out_counter <= sig_out_counter - 1;
      end if;
      
      if keypress then
         sig_out_counter <= (others => '1');
      end if;
   
      if sig_out_counter = 0 then
         sig_out <= sig_out_int;

      end if;
   
   end if;
end process;


end rtl;

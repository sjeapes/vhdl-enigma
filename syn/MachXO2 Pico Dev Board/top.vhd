-- Top Level VHDL File


library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use IEEE.std_logic_unsigned.all;

use work.letters_pak.all;
use work.wheel_config_pak.all;

entity top_level is
   --generic(
      
   --);

   port 
   (
      CLK_12MHZ	: in  std_logic;	  
	  
	  INPUT_SW	: in  std_logic;
	  
	  --Capacitive Buttons
	  CAP_BUT	: inout  std_logic_vector(25 downto 0);
	  
	  --4-Digit LCD Control
	  LCD_CTRL  : out std_logic_vector(11 downto 0)
	  
   );

end entity;

architecture rtl of top_level is


component lcd is
	port(
		clk		 : in std_logic;
		reset   : in std_logic;
		display1 : in letter;
		display2 : in letter;
		display3 : in letter;
		display4 : in letter;
		lcd_pins : out std_logic_vector(11 downto 0)
	);
end component;

component cap_button is
	generic(
		num_buttons  : integer := 26
	);
	port(
		clk 		 : in std_logic;
		reset		 : in std_logic;
		button_input : inout std_logic_vector(num_buttons-1 downto 0);
		button_press : out std_logic_vector(num_buttons-1 downto 0)
	);
end component;

component machine is
   generic(
      num_wheels: integer := 3; --! The number of wheels in the machine, only 3 or 4 are valid
      wheel_order: t_wheel_order := ('4','3','2','1'); --! The wheels fitted in the machine, highest wheel number to lowest;
      double_step: boolean := TRUE
   );

   port 
   (
      clk_in   :  in std_logic; --! Clock input signal, 
         --! output signals will be synchroized to this clock domain
      reset_in :  in std_logic; --! reset_in signal, ('1' = reset_in)
      sig_in   :  in letter;
 
      sig_out  :  out letter
   );
end component;


signal global_reset: std_logic;

signal input_letter, output_letter: letter; --! input and output of enigma machine
signal letter_buffer0, letter_buffer1, letter_buffer2, letter_buffer3: letter; --! Delayed versions of machine output for display

signal buttons: std_logic_vector(25 downto 0);

begin

--Skeleton process for reset control. This will need to get more complicated later
reset_ctrl: process(INPUT_SW)
begin
	global_reset <= not INPUT_SW; 
end process;

letter_input:process(buttons)
begin
	input_letter <= ' ';
	input_letter <= bitvector_to_letter(buttons);	
end process;

letter_buffer:process(CLK_12MHZ, global_reset)
begin
	if global_reset = '1' then
		letter_buffer0 <= ' ';
		letter_buffer1 <= ' ';
		letter_buffer2 <= ' ';
		letter_buffer3 <= ' ';
	elsif rising_edge(CLK_12MHZ) then
		if letter_buffer0 /=  output_letter then
			letter_buffer0 <= output_letter;
			letter_buffer1 <= letter_buffer0;
			letter_buffer2 <= letter_buffer1;
			letter_buffer3 <= letter_buffer2;
		end if;
	end if;
end process;


enigma:machine
	port map(
		clk_in => CLK_12MHZ,
		reset_in => global_reset,
		sig_in => input_letter,
		sig_out => output_letter
	);
	

keyboard:cap_button
	generic map(
		num_buttons  => 26
	)
	port map(
		clk => CLK_12MHZ,
		reset => global_reset,
		button_input => CAP_BUT,
		button_press => buttons
	);

display:lcd
	port map(
		clk => CLK_12MHZ,
		reset => global_reset,
		display1 => letter_buffer0,
		display2 => letter_buffer1,
		display3 => letter_buffer2,
		display4 => letter_buffer3,
		lcd_pins => LCD_CTRL
	);

end rtl;
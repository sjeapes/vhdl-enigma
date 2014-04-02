library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use IEEE.std_logic_unsigned.all;

entity cap_button is
	generic(
		num_buttons  : integer := 4
	);
	port(
		clk 		 : in std_logic;
		reset		 : in std_logic;
		button_input : inout std_logic_vector(num_buttons-1 downto 0);
		button_press : out std_logic_vector(num_buttons-1 downto 0)
	);
end entity;


architecture rtl of cap_button is
type sense_state is (drive_low, highz, sense);
signal current_state, next_state : sense_state;


begin

fsm_reg:process(clk,reset)
begin
	if reset = '1' then
		current_state <= drive_low;
	elsif rising_edge(clk) then
		current_state <= next_state;
	end if;
end process;

fsm_proc:process(current_state)
begin
	case current_state is
		when drive_low => button_input <= (others => '0');
		when highz => button_input <= (others => 'Z');
		when sense => button_input <= (others => 'Z');
	end case;
end process;

button_press <= button_input;

end	rtl;

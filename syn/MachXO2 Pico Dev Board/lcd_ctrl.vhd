library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use IEEE.std_logic_unsigned.all;

use work.letters_pak.all;
use work.wheel_config_pak.all;

entity lcd is
	port(
		clk : in std_logic;
		reset : in std_logic;
		display1 : in letter; --First digit reading left to right
		display2 : in letter;
		display3 : in letter;
		display4 : in letter; --Last digit reading left to right
		lcd_pins : out std_logic_vector(11 downto 0)
	);
end entity;

architecture rtl of lcd is

signal  common : std_logic_vector(3 downto 0);

type letter_matrix is array(3 downto 0) of std_logic_vector(1 downto 0);

signal digit1, digit2, digit3, digit4: letter_matrix;


function letter_to_pins(toconvert:letter) return letter_matrix is
begin
	case toconvert is
		when a => return (('1','1'),('1','1'),('1','1'),('0','0'));
		when b => return (('0','1'),('0','1'),('1','1'),('0','1'));
		when c => return (('1','1'),('0','0'),('0','1'),('0','1'));
		when d => return (('0','0'),('1','1'),('1','1'),('0','1'));
		when e => return (('1','1'),('0','1'),('0','1'),('0','1'));
		when f => return (('1','1'),('0','1'),('0','1'),('0','0'));
		when g => return (('0','0'),('1','1'),('1','1'),('0','1'));
		when h => return (('1','1'),('0','1'),('1','1'),('0','0'));
		when i => return (('0','0'),('1','0'),('1','0'),('0','0'));
		when j => return (('0','0'),('1','0'),('1','0'),('0','1'));
		when k => return (('0','0'),('0','0'),('0','0'),('0','1')); -- Can't do 'k' will print low dash '-' (element d of digit)
		when l => return (('0','1'),('0','0'),('0','1'),('0','1'));
		when m => return (('0','0'),('0','1'),('0','0'),('0','0')); -- Can't do 'M' will print dash '-'
		when n => return (('0','0'),('0','1'),('1','1'),('0','0'));
		when o => return (('1','1'),('1','0'),('1','1'),('0','1'));
		when p => return (('1','1'),('1','1'),('0','1'),('0','0'));
		when q => return (('0','1'),('1','1'),('1','0'),('0','0'));
		when r => return (('0','0'),('0','1'),('0','1'),('0','0'));
		when s => return (('1','1'),('0','1'),('1','0'),('0','1'));
		when t => return (('0','1'),('0','1'),('0','1'),('0','1'));
		when u => return (('0','1'),('1','0'),('1','1'),('0','1')); -- Capital U
		when v => return (('0','0'),('0','0'),('1','1'),('0','1')); -- Might look like small u
		when w => return (('1','0'),('0','0'),('0','0'),('0','0')); -- Can't do 'w'  will print high '-' (element A of digit
 		when x => return (('0','1'),('0','1'),('1','1'),('0','0')); 
		when y => return (('0','1'),('1','0'),('1','0'),('0','0')); 
		when z => return (('1','0'),('1','1'),('0','1'),('0','1'));
		when others => return (others=>(others=>'0'));
	end case;
end function;

begin

com_ctrl: process(clk,reset)
begin
	if reset = '1' then
		common <= "0001";
	elsif rising_edge(clk) then
		common(1) <= common(0);
		common(2) <= common(1);
		common(3) <= common(2);
		common(0) <= common(3);
	end if;
end process;

lcd_pins(3 downto 0) <= common;

outputletter:process(clk,reset)
begin
	if reset = '1' then
	
	elsif rising_edge(clk) then
		digit1 <= letter_to_pins(display1);
		digit2 <= letter_to_pins(display2);
		digit3 <= letter_to_pins(display3);
		digit4 <= letter_to_pins(display4);
		
		case common is
			when "0001" => 	lcd_pins(11 downto 10) <= digit1(0);
							lcd_pins(9 downto 8) <= digit2(0);
							lcd_pins(7 downto 6) <= digit3(0);
							lcd_pins(5 downto 4) <= digit4(0);
			when "0010" => 	lcd_pins(11 downto 10) <= digit1(1);
							lcd_pins(9 downto 8) <= digit2(1);
							lcd_pins(7 downto 6) <= digit3(1);
							lcd_pins(5 downto 4) <= digit4(1); 
			when "0100" => 	lcd_pins(11 downto 10) <= digit1(2);
							lcd_pins(9 downto 8) <= digit2(2);
							lcd_pins(7 downto 6) <= digit3(2);
							lcd_pins(5 downto 4) <= digit4(2);
			when "1000" =>  lcd_pins(11 downto 10) <= digit1(3);
							lcd_pins(9 downto 8) <= digit2(3);
							lcd_pins(7 downto 6) <= digit3(3);
							lcd_pins(5 downto 4) <= digit4(3);
			when others => lcd_pins(11 downto 4) <= (others => '0');
		end case;
	
	end if;
end process;



end rtl;
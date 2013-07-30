--Filename: wheel_config_pak.vhd
--
--Description: 
--Provides types and definitions for wheel variants and wiring
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

use work.letters_pak.all;

package wheel_config_pak is

type wheel_variants is ('1','2','3','4','5','6','7','8',beta,gamma); --! The wheel types available
type wheel_order is array(3 downto 0) of wheel_variants; --! The wheels fitted in the machine, highest wheel number to lowest, if only 3 wheels are used the MSB will be ignored

type wheel_wiring is array(wheel_variants'left to wheel_variants'right) of letter_mapping;

type wheel_def is 
	record 
		wiring : wheel_wiring;
		turnover: letter;	end record;
	
type wheel_set is array(wheel_variants) of wheel_def;


function encode_letter(to_encode: letter; variant: wheel_variants; position:letter) return letter;

end wheel_config_pak;

package body wheel_config_pak is



function encode_letter(to_encode: letter; variant: wheel_variants; position:letter) return letter is
begin
	return a;
end encode_letter;


end wheel_config_pak;

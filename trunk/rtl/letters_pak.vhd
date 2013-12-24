--Filename: letters_pak.vhd
--
--Description: 
--Letters package, allows the use of 'a' to 'z' in the code,
--rather than forcing binary representations
--Will also handle conversion functions into and out of the letters type
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




package letters_pak is

type letter is (a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,' '); --! An enumerated type for letters of the alphabet, purely for readability
type letter_mapping is array(letter) of letter; --! An array type used to map the incoming letter to an outgoing letter

function increment(toincrement: letter) return letter;

function number_to_letter(num_to_convert: integer range 0 to 26) return letter;
function letter_to_number(letter_to_convert: letter) return integer;

end letters_pak;

package body letters_pak is

type num_letters is array(integer range 0 to 26) of letter;
constant letter_array: num_letters := (a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,' ');

type letters_num is array(letter) of integer;
constant number_array: letters_num := (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26);

function increment(toincrement: letter) return letter is
variable incremented : letter := ' ';
begin
   if toincrement = z then
      incremented := a;
   elsif toincrement = ' ' then
	  incremented := ' ';
   else
      incremented := letter_array(number_array(toincrement)+1);
   end if;
   
   return incremented;
end increment;

function number_to_letter(num_to_convert: integer range 0 to 26) return letter is
begin 
   return letter_array(num_to_convert);
end number_to_letter;


function letter_to_number(letter_to_convert: letter) return integer is
begin
   return number_array(letter_to_convert);
end letter_to_number;



end letters_pak;

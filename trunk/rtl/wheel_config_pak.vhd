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
type t_wheel_order is array(3 downto 0) of wheel_variants; --! The wheels fitted in the machine, highest wheel number to lowest, if only 3 wheels are used the MSB will be ignored
--type wheel_wiring is array(wheel_variants'left to wheel_variants'right) of letter_mapping;
type t_turnover is array (1 downto 0) of letter;

type wheel_def is 
   record 
      turnover: t_turnover;   
      wiring : letter_mapping;
      reverse_wiring : letter_mapping;
  end record;
   
type t_wheel_set is array(wheel_variants) of wheel_def;

function is_turnover_pos(wheel_pos: letter; variant: wheel_variants) return boolean;
function encode_letter(to_encode: letter; variant: wheel_variants; forward: boolean) return letter;
function wheel_entry(entry: boolean; wheel_pos: letter; encoded_letter: letter) return letter;

end wheel_config_pak;

package body wheel_config_pak is

--! wheel_data: Variable containint all wheel configuration i.e. turnover and wiring
--Wiring Definition is available from http://www.codesandciphers.org.uk/enigma/rotorspec.htm as shown below
--! INPUT	    A	B	C	D	E	F	G	H	I	J	K	L	M	N	O	P	Q	R	S	T	U	V	W	X	Y	Z
--! Rotor I	    E	K	M	F	L	G	D	Q	V	Z	N	T	O	W	Y	H	X	U	S	P	A	I	B	R	C	J
--! Rotor II	A	J	D	K	S	I	R	U	X	B	L	H	W	T	M	C	Q	G	Z	N	P	Y	F	V	O	E
--! Rotor III	B	D	F	H	J	L	C	P	R	T	X	V	Z	N	Y	E	I	W	G	A	K	M	U	S	Q	O
--! Rotor IV	E	S	O	V	P	Z	J	A	Y	Q	U	I	R	H	X	L	N	F	T	G	K	D	C	M	W	B
--! Rotor V	    V	Z	B	R	G	I	T	Y	U	P	S	D	N	H	L	X	A	W	M	J	Q	O	F	E	C	K
--! Rotor VI	J	P	G	V	O	U	M	F	Y	Q	B	E	N	H	Z	R	D	K	A	S	X	L	I	C	T	W
--! Rotor VII	N	Z	J	H	G	R	C	X	M	Y	S	W	B	O	U	F	A	I	V	L	P	E	K	Q	D	T
--! Rotor VIII	F	K	Q	H	T	L	X	O	C	B	J	S	P	D	Z	R	A	M	E	W	N	I	U	Y	G	V
--! Beta rotor	L	E	Y	J	V	C	N	I	X	W	P	B	Q	M	D	R	T	A	K	Z	G	F	U	H	O	S
--! Gamma rotor	F	S	O	K	A	N	U	E	R	H	M	B	T	I	Y	C	W	L	Q	P	Z	X	V	G	J	D
constant wheel_data: t_wheel_set :=  (
      '1' => (turnover => (' ',q),
              wiring => (e,k,m,f,l,g,d,q,v,z,n,t,o,w,y,h,x,u,s,p,a,i,b,r,c,j,' '),
              reverse_wiring => (u,w,y,g,a,d,f,p,v,z,b,e,c,k,m,t,h,x,s,l,r,i,n,q,o,j,' ')),
      '2' => (turnover => (' ',e),
              wiring => (a,j,d,k,s,i,r,u,x,b,l,h,w,t,m,c,q,g,z,n,p,y,f,v,o,e,' '),
              reverse_wiring => (a,j,p,c,z,w,r,l,f,b,d,k,o,t,y,u,q,g,e,n,h,x,m,i,v,s,' ')),
      '3' => (turnover => (' ',v),
              wiring => (b,d,f,h,j,l,c,p,r,t,x,v,z,n,y,e,i,w,g,a,k,m,u,s,q,o,' '),
              reverse_wiring => (t,a,g,b,p,c,s,d,q,e,u,f,v,n,z,h,y,i,x,j,w,l,r,k,o,m,' ')),      
      '4' => (turnover => (' ',j),
              wiring => (e,s,o,v,p,z,j,a,y,q,u,i,r,h,x,l,n,f,t,g,k,d,c,m,w,b,' '),
              reverse_wiring => (h,z,w,v,a,r,t,n,l,g,u,p,x,q,c,e,j,m,b,s,k,d,y,o,i,f,' ')),
      '5' => (turnover => (' ',z),
              wiring => (v,z,b,r,g,i,t,y,u,p,s,d,n,h,l,x,a,w,m,j,q,o,f,e,c,k,' '),
              reverse_wiring => (q,c,y,l,x,w,e,n,f,t,z,o,s,m,v,j,u,d,k,g,i,a,r,p,h,b,' ')),
      '6' => (turnover => (z,m),
              wiring => (j,p,g,v,o,u,m,f,y,q,b,e,n,h,z,r,d,k,a,s,x,l,i,c,t,w,' '),
              reverse_wiring => (s,k,x,q,l,h,c,n,w,a,r,v,g,m,e,b,j,p,t,y,f,d,z,u,i,o,' ')),
      '7' => (turnover => (z,m),
              wiring => (n,z,j,h,g,r,c,x,m,y,s,w,b,o,u,f,a,i,v,l,p,e,k,q,d,t,' '),
              reverse_wiring => (q,m,g,y,v,p,e,d,r,c,w,t,i,a,n,u,x,f,k,z,o,s,l,h,j,b,' ')),
      '8' => (turnover => (z,m),
              wiring => (f,k,q,h,t,l,x,o,c,b,j,s,p,d,z,r,a,m,e,w,n,i,u,y,g,v,' '),
              reverse_wiring => (q,j,i,n,s,a,y,d,v,k,b,f,r,u,h,m,c,p,l,e,w,z,t,g,x,o,' ')),
      beta => (turnover => (' ',' '), --! Beta wheel can only be used in 4th position so doesn't have a turnover position
              wiring => (l,e,y,j,v,c,n,i,x,w,p,b,q,m,d,r,t,a,k,z,g,f,u,h,o,s,' '),
              reverse_wiring => (r,l,f,o,b,v,u,x,h,d,s,a,n,g,y,k,m,p,z,q,w,e,j,i,c,t,' ')),
      gamma => (turnover => (' ',' '), --! Gamma wheel can only be used in 4th position so doesn't have a turnover position
              wiring => (f,s,o,k,a,n,u,e,r,h,m,b,t,i,y,c,w,l,q,p,z,x,v,g,j,d,' '),
              reverse_wiring => (e,l,p,z,h,a,x,j,n,y,d,r,k,f,c,t,s,i,b,m,g,w,q,v,o,u,' '))
  );

--! is_turnover_pos takes Current Wheel Position and Wheel Type
--! returns true is the current position is a turnover position for that wheel
--! Used to abstract away exact datatypes to allow change later without affecting the rest of the code
function is_turnover_pos(wheel_pos: letter; variant: wheel_variants) return boolean is
begin
   if wheel_data(variant).turnover(0) = wheel_pos OR wheel_data(variant).turnover(1) = wheel_pos then
      return TRUE;
   else
      return FALSE;
   end if;
end is_turnover_pos;

--! Returns the resulting enecoded letter through the wheel, hte forward paremeter defines which direction the encoding happens
function encode_letter(to_encode: letter; variant: wheel_variants; forward:boolean) return letter is
variable encoded : letter;
begin
	if forward then
		encoded := wheel_data(variant).wiring(to_encode);
	else
		encoded := wheel_data(variant).reverse_wiring(to_encode);		
	end if;
	
	return encoded;
end encode_letter;


--! wheel_entry_exit transposes the letter from the entry of the wheel mechanism into the wiring based upon the wheel position
--! entry: boolean - when true the function transposes from a letter into the wheel, when false it transposes from the wheel wiring out of the wheel
--! wheel_pos: the wheel position
--! encoded_letter: the letter to be transposed (either the letter to go into the wheel or the exit of the wiring to produce the letter to go out of the wheel)
function wheel_entry(entry: boolean; wheel_pos: letter; encoded_letter: letter) return letter is
variable inputnumber: integer range 0 to 26;
variable wheelposnumber: integer range 0 to 25;
variable offsetnumber: integer range 0 to 51;
variable outputletter : letter;
begin
   --! For entry transposition take entry letter, convert to number and then add together convert the remainder (after modulo 26 conversion) back to a letter
   if encoded_letter = ' ' then
		outputletter := ' ';
   else   
	   inputnumber := letter_to_number(encoded_letter);
	   wheelposnumber := letter_to_number(wheel_pos);
	   if entry then 
			offsetnumber := inputnumber + wheelposnumber;
			   if offsetnumber > 25 then
					offsetnumber := offsetnumber - 26;
			   end if;
		else
			if inputnumber < wheelposnumber then
				offsetnumber := inputnumber + 26 - wheelposnumber;
			else
				offsetnumber := inputnumber - wheelposnumber;
			end if;
		end if;
	   outputletter := number_to_letter(offsetnumber);	   
	end if;
	
   return outputletter;
end wheel_entry;

end wheel_config_pak;

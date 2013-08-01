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
--type wheel_wiring is array(wheel_variants'left to wheel_variants'right) of letter_mapping;
type t_turnover is array (1 downto 0) of letter;

type wheel_def is 
   record 
      wiring : letter_mapping;
      turnover: t_turnover;   end record;
   
type t_wheel_set is array(wheel_variants) of wheel_def;

function is_turnover_pos(wheel_pos: letter; variant: wheel_variants) return boolean;
function encode_letter(to_encode: letter; variant: wheel_variants) return letter;

end wheel_config_pak;

package body wheel_config_pak is

--! wheel_data: Variable containint all wheel configuration i.e. turnover and wiring
--Wiring Definition is available from http://www.codesandciphers.org.uk/enigma/rotorspec.htm as shown below
--! INPUT	A	B	C	D	E	F	G	H	I	J	K	L	M	N	O	P	Q	R	S	T	U	V	W	X	Y	Z
--! Rotor I	E	K	M	F	L	G	D	Q	V	Z	N	T	O	W	Y	H	X	U	S	P	A	I	B	R	C	J
--! Rotor II	A	J	D	K	S	I	R	U	X	B	L	H	W	T	M	C	Q	G	Z	N	P	Y	F	V	O	E
--! Rotor III	B	D	F	H	J	L	C	P	R	T	X	V	Z	N	Y	E	I	W	G	A	K	M	U	S	Q	O
--! Rotor IV	E	S	O	V	P	Z	J	A	Y	Q	U	I	R	H	X	L	N	F	T	G	K	D	C	M	W	B
--! Rotor V	V	Z	B	R	G	I	T	Y	U	P	S	D	N	H	L	X	A	W	M	J	Q	O	F	E	C	K
--! Rotor VI	J	P	G	V	O	U	M	F	Y	Q	B	E	N	H	Z	R	D	K	A	S	X	L	I	C	T	W
--! Rotor VII	N	Z	J	H	G	R	C	X	M	Y	S	W	B	O	U	F	A	I	V	L	P	E	K	Q	D	T
--! Rotor VIII	F	K	Q	H	T	L	X	O	C	B	J	S	P	D	Z	R	A	M	E	W	N	I	U	Y	G	V
--! Beta rotor	L	E	Y	J	V	C	N	I	X	W	P	B	Q	M	D	R	T	A	K	Z	G	F	U	H	O	S
--! Gamma rotor	F	S	O	K	A	N	U	E	R	H	M	B	T	I	Y	C	W	L	Q	P	Z	X	V	G	J	D
constant wheel_data: t_wheel_set :=  (
      '1' => (turnover => (' ',r),
              wiring => (i,e,k,m,f,l,g,d,q,v,z,n,t,o,w,y,h,x,u,s,p,a,i,b,r,c,j)),
      '2' => (turnover => (' ',f),
              wiring => (a,j,d,k,s,i,r,u,x,b,l,h,w,t,m,c,q,g,z,n,p,y,f,v,o,r)),
      '3' => (turnover => (' ',w),
              wiring => (b,d,f,h,j,l,c,p,r,t,x,v,z,n,y,e,i,w,g,a,k,m,u,s,q,o)),      
      '4' => (turnover => (' ',k),
              wiring => (e,s,o,v,p,z,j,a,y,q,u,i,r,h,x,l,n,f,t,g,k,d,c,m,w,b)),      
      '5' => (turnover => (' ',a),
              wiring => (v,z,b,r,g,i,t,y,u,p,s,d,n,h,l,x,a,w,m,j,q,o,f,e,c,k)),      
      '6' => (turnover => (a,n),
              wiring => (j,p,g,v,o,u,m,f,y,q,b,e,n,h,z,r,d,k,a,s,x,l,i,c,t,w)),
      '7' => (turnover => (a,n),
              wiring => (n,z,j,h,g,r,c,x,m,y,s,w,b,o,u,f,a,i,v,l,p,e,k,q,d,t)),        
      '8' => (turnover => (a,n),
              wiring => (f,k,q,h,t,l,x,o,c,b,j,s,p,d,z,r,a,m,e,w,n,i,u,y,g,v)),  
      beta => (turnover => (' ',' '), --! Beta wheel can only be used in 4th position so doesn't have a turnover position
              wiring => (l,e,y,j,v,c,n,i,x,w,p,b,q,m,d,r,t,a,k,z,g,f,u,h,o,s)),
      gamma => (turnover => (' ',' '), --! Gamma wheel can only be used in 4th position so doesn't have a turnover position
              wiring => (f,s,o,k,a,n,u,e,r,h,m,b,t,i,y,c,w,l,q,p,z,x,v,g,j,d))
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

function encode_letter(to_encode: letter; variant: wheel_variants) return letter is
begin
   return wheel_data(variant).wiring(to_encode);
end encode_letter;


end wheel_config_pak;

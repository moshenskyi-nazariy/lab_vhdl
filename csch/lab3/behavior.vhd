library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity ram128x4 is
	port (
		address:in std_logic_vector (4 downto 0);
		rd:in std_logic; 
		wt: in std_logic;
		cs:in std_logic;
		i:in std_logic;
		q:inout std_logic_vector (3 downto 0)
		
		);
end ram128x4;
--}} End of automatically maintained section
architecture  ram128x4 of  ram128x4 is
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;

	subtype TRow is std_logic_vector(15 downto 0);
	type TMemArray is array(31 downto 0) of TRow;
	Signal MemArray : TMemArray;  
	
	signal a: std_logic_vector(8 downto 0);
begin

	a(4 downto 0) := address when cas = '0' else unaffected;
	a(8 downto 5) := address when ras = '0' else unaffected;
	
	process(a,q,rd,cs,i, wt) 
		variable Row:TRow;   
		variable rownum,colnum:integer; 
	begin		
		
		q <= "ZZZZ";
		if cs='0' then 
			if rd = '0' then
				rownum:=conv_integer(a(4 downto 0));
				colnum:=conv_integer(a(8 downto 5));
				row:=MemArray(rownum);   
				q<=row(colnum*4+3 downto colnum*4); 
			elsif wt = '0' then
				rownum:=conv_integer(a(4 downto 0));
				colnum:=conv_integer(a(8 downto 5));
				row:=MemArray(rownum); 
				row(colnum*4 +3 downto colnum*4) := q;
				MemArray(rownum)<= row;
			end if; 
		end if;			  
	end process;
end  ram128x4;
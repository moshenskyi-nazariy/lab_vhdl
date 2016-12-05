library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_signed.all;
entity OA is
	port(
		clk,rst : in STD_LOGIC;
		y : in STD_LOGIC_VECTOR(8 downto 1);
		d : in STD_LOGIC_VECTOR(9 downto 0);
		r:out STD_LOGIC_VECTOR(9 downto 0) ;
		x1,x2:out STD_LOGIC
		);
end OA;



architecture OA of OA is
signal A,Ain,B,Bin: STD_LOGIC_VECTOR(9 downto 0);
signal	Count: STD_LOGIC_VECTOR(2 downto 0);
signal	CF: STD_LOGIC;	--Carry
begin
	process(clk,rst)is
	begin
		if rst='0' then
			a<=(others=>'0'); -- асинхронный сброс
			b<=(others=>'0');
			Count<="000"; 
			CF<='0';
		elsif rising_edge(clk)then
			A<=Ain;B<=Bin ; -- синхронна€ запись
		end if;
	end process;
	
	Ain <=b(8 downto 0)&a(9) when y(2)='1'
		else d when y(5)='1' -- загрузка данных
		else a;
	
	--Bin(conv_integer(Count)) <= not A (conv_integer(Count)) when y(3)='1' 
	  --Bin <= ((b(conv_integer(Count)) <= not A (conv_integer(Count))) when y(3)='1'
	Bin <= A + not B+1 when y(1)='1'
		else not A(Count) when y(3)='1'
		else d when y(6)='1' -- загрузка данных
		else b;	  			  
	
			
	Count <= Count - 1 when y(4)='1';
	
	r <=A when y(7)='1' -- формирование шины результата
		else B when y(8)='1'
		else(others=>'0');
	x1<='1' when Count = "111" else '0';
	x2<='1' when Bin(9) = '1';
end OA;	
--	ain<=(others=>'0') when y(1)='1' -- ќбнуление регистра ј
--		else a+b when y(2)='1' -- сложение регистров
--		else d when y(5)='1' -- загрузка данных
--		else a; -- сохранение данных в регистре ј если
--				-- не выполн€етс€ ни одной микрооперации
--	bin<=a(0)&b(9 downto 1) when y(3)='1'
--		else a xor b when y(4)='1' -- сложение по модулю 2
--		else d when y(6)='1' -- загрузка данных
--		else b; -- сохранение
--	r <=a when y(7)='1' -- формирование шины результата
--		else b when y(8)='1'
--		else(others=>'0');
--	x1<='1' when A="0000000000" else '0'; -- формирование признаков результата
--	x2<='1' when a=b else '0';
--end OA;
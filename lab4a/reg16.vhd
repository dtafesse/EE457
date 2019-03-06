LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY reg16 is
	PORT(
		clk: IN STD_LOGIC;
		sclr_n : IN STD_LOGIC;
		clk_ena : IN STD_LOGIC;
		datain: IN UNSIGNED (15 downto 0);
		reg_out : OUT UNSIGNED (15 downto 0));
END ENTITY reg16;

ARCHITECTURE logic of reg16 is
BEGIN
	PROCESS(clk)
	BEGIN
		if rising_edge (clk) then 
			if clk_ena = '1' AND sclr_n = '0' then
				reg_out <= (others => '0');
			elsif clk_ena = '1' AND sclr_n /= '0' then
				reg_out <= datain;
			end if;
		end if;
	end PROCESS;
END ARCHITECTURE logic;
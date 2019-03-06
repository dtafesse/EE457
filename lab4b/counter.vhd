LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY counter is
	PORT(
		clk: IN STD_LOGIC;
		aclr_n  : IN STD_LOGIC;
		count_out : OUT UNSIGNED (1 downto 0)
	);
END ENTITY counter;

ARCHITECTURE logic of counter is
BEGIN
	PROCESS(clk, aclr_n)
		variable count : unsigned (1 downto 0);
	BEGIN
		if aclr_n = '0' then
			count := "00";
		elsif rising_edge (clk) then
			count := count + "01";
		end if;
		count_out <= count;
	END PROCESS;
END ARCHITECTURE logic;
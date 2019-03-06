LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mult4X4 IS
	PORT(
		dataa: IN UNSIGNED (3 downto 0);
		datab: IN UNSIGNED (3 downto 0);
		product: OUT UNSIGNED (7 downto 0)
	);
END ENTITY mult4X4;

ARCHITECTURE logic Of mult4X4 IS
BEGIN
	product <= dataa * datab;
END ARCHITECTURE logic;
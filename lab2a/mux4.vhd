LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mux4 IS 
	PORT (
		mux_in_a : IN UNSIGNED (3 downto 0);
		mux_in_b: IN UNSIGNED (3 downto 0);
		mux_sel : IN STD_LOGIC;
		mux_out : OUT UNSIGNED (3 downto 0)
	);
END ENTITY mux4;

ARCHITECTURE logic Of mux4 is
BEGIN
	PROCESS (mux_in_a, mux_in_b, mux_sel) is
	BEGIN
		IF(mux_sel = '0') then
			mux_out <= mux_in_a;
		ELSE
			mux_out <= mux_in_b;
		END IF;
	END PROCESS;
END ARCHITECTURE logic;
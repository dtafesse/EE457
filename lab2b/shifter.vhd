LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY shifter IS
	PORT(
		input : IN UNSIGNED (7 downto 0);
		shift_cntrl : IN UNSIGNED (1 downto 0);
		shift_out : OUT UNSIGNED (15 downto 0)
	);
END ENTITY shifter;

ARCHITECTURE logic Of shifter IS
BEGIN
	PROCESS(input, shift_cntrl)
	BEGIN
		shift_out <= "0000000000000000";
		IF(shift_cntrl=0) then 
			shift_out (7 downto 0) <= input (7 downto 0);
		ELSIF(shift_cntrl=1) then 
			shift_out (11 downto 4) <= input (7 downto 0);
		ELSIF(shift_cntrl=2) then 
			shift_out (15 downto 8) <= input (7 downto 0);	
		ELSE
			shift_out (7 downto 0) <= input (7 downto 0);
		END IF;
	END PROCESS;
END ARCHITECTURE logic;
LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY seven_segment_cntrl is
	PORT(
		input : IN UNSIGNED (2 downto 0);
		seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g : OUT STD_LOGIC
	);
END ENTITY seven_segment_cntrl;

ARCHITECTURE logic of seven_segment_cntrl is
BEGIN 
	PROCESS (input)
	BEGIN
	CASE input IS
		WHEN "000" => 
			seg_a <= '1';
			seg_b <= '1';
			seg_c <= '1';
			seg_d <= '1';
			seg_e <= '1';
			seg_f <= '1';
			seg_g <= '0';
		WHEN "001" => 
			seg_a <= '0';
			seg_b <= '1';
			seg_c <= '1';
			seg_d <= '0';
			seg_e <= '0';
			seg_f <= '0';
			seg_g <= '0';
		WHEN "010" => 
			seg_a <= '1';
			seg_b <= '1';
			seg_c <= '0';
			seg_d <= '1';
			seg_e <= '1';
			seg_f <= '0';
			seg_g <= '1';
		WHEN "011" => 
			seg_a <= '1';
			seg_b <= '1';
			seg_c <= '1';
			seg_d <= '1';
			seg_e <= '0';
			seg_f <= '0';
			seg_g <= '1';
		WHEN OTHERS => 
			seg_a <= '1';
			seg_b <= '0';
			seg_c <= '0';
			seg_d <= '1';
			seg_e <= '1';
			seg_f <= '1';
			seg_g <= '1';
		END CASE;
	END PROCESS;
END ARCHITECTURE logic;
LIBRARY ieee;
USE ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_1164.all;

ENTITY gen_double_dff IS
-- we are using the generic construct to allow this double dff to be generic.
    generic (
        wide: positive
    );
	PORT (
		input : IN STD_LOGIC_VECTOR (wide-1 downto 0);
        clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		output : OUT STD_LOGIC_VECTOR(wide-1 downto 0)
	);
			
END gen_double_dff;

-- Double D Flip Flop
ARCHITECTURE logic OF gen_double_dff IS
	-- Output from the first D Flip Flop
	signal first_meta_output : STD_LOGIC_VECTOR (wide-1 downto 0);
BEGIN
	process (input, clk, reset) is
	begin
		if reset = '0' then
            first_meta_output <= (others => '0');
            output <= (others => '0');
		elsif rising_edge(clk) then
            first_meta_output <= input;
            output <= first_meta_output;
		end if;
	end process;
END logic;
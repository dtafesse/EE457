LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity de1_top_tb is
end entity;

architecture behav of de1_top_tb is

component de1_top is
generic (
    simulation_wide : positive := 28;    -- used for simulation to overide width
	simulation_max  : positive := 50000000); -- used for simulaiton to oreride max value
port (
   CLOCK_50 :in std_logic;
   -- 7 Segment Display
	HEX0		:out	std_logic_vector( 6 downto 0); -- right most
	HEX1		:out	std_logic_vector( 6 downto 0);	
	HEX2		:out	std_logic_vector( 6 downto 0);	
	HEX3		:out	std_logic_vector( 6 downto 0);	
	HEX4		:out	std_logic_vector( 6 downto 0);	
	HEX5		:out	std_logic_vector( 6 downto 0); -- left most
   -- Red LEDs above Slider switches
    LEDR		:out	std_logic_vector( 9 downto 0);	
	-- Push Button
	KEY		    :in     std_logic_vector( 3 downto 0);  
   -- Slider Switch
	SW			:in	    std_logic_vector( 9 downto 0 ) 
		);
end component;
	
constant CLK_PER:time := 20 ns;
constant clk_cycle:time := 2*clk_per;
	
signal aclr_n : std_logic;
signal clk    : std_logic;
signal sw     : std_logic_vector(9 downto 0);
signal key    : std_logic_vector(3 downto 0);
signal ledr   : std_logic_vector(9 downto 0);
signal hex0	  : std_logic_vector(6 downto 0); -- right most
signal hex1	  : std_logic_vector(6 downto 0);	
signal hex2	  : std_logic_vector(6 downto 0);	
signal hex3	  : std_logic_vector(6 downto 0);	
signal hex4	  : std_logic_vector(6 downto 0);	
signal hex5	  : std_logic_vector(6 downto 0); -- left most

begin
	
	-- testbench for 2019
	clock:process begin  -- this process just continues to run as the simulation time continues
		 clk <= '0';
		 wait for CLK_PER;
		 clk <= '1';
		 wait for CLK_PER;
		 end process;
		
	vectors:process begin -- put you test vectors here, remember to advance the simulation in modelsim
	-- we are using key(0) as the clock for the memory design for Part I through III
	-- for Part IV key(0) will be the reset and the clk will be the normal clk create above
	-- make sure you change the component instantition below for Part IV
	
		sw     <= "0000000000"; -- drive all the switch inputs to a 0
		key    <= "1110";   -- default state on the board, all '1's
		wait for 5 ns; 			-- wait for a fraction of the clock so stimulus is not occuring on clock edges
 
	    -- use the assert statement so you know where to go look in the simulation to make
		-- sure you are getting the results you need.  the message will be displayed along with
		-- the simulation time
		assert false report "starting test vectors" severity note;
	
		wait for 3*clk_cycle;
	    assert false report "just waited 5 clock cycles" severity note;
	  	key <= "1111" ;

		-- READING from addresses, initial!
		-- 1)
		-- sw <= "0000000000";
		-- wait for 500*clk_cycle;

		-- WRITING 
		-- 2-a)
		sw <= "1000111100"; -- write "1100" to address decimal 3/hex "03"
		wait for 20*clk_cycle; 

		-- -- b
		-- sw <= "1011100011"; -- write "0011" to address decimal 14/hex "0E"
		-- wait for 20*clk_cycle; 

		-- -- c
		-- sw <= "1110101111"; -- write "1111" to address decimal 26/hex "1A"
		-- wait for 20*clk_cycle; 

		-- -- d
		-- sw <= "1110110101"; -- write "0101" to address decimal 27/hex "1B"
		-- wait for 20*clk_cycle; 

		sw <= "0000000000"; -- read
		wait for 500*clk_cycle;
		
		assert false report "******* This is not a Failure it is the end of the simulation ********" severity failure;
		end process;

		

-- instantiate the device under test (dut)
dut :de1_top
generic map (
		simulation_wide => 4, -- make it 4 bits
		simulation_max  => 10 -- have it only count to 10 for shorter simulation
		)
port map (
    CLOCK_50 => clk,
   -- 7 Segment Display
	HEX0 => hex0,--		:out	std_logic_vector( 6 downto 0); -- right most
	HEX1 => hex1,--		:out	std_logic_vector( 6 downto 0);	
	HEX2 => hex2,-- 	:out	std_logic_vector( 6 downto 0);	
	HEX3 => hex3,--     :out	std_logic_vector( 6 downto 0);	
	HEX4 => hex4,--		:out	std_logic_vector( 6 downto 0);	
	HEX5 => hex5,--	    :out	std_logic_vector( 6 downto 0); -- left most
   -- Red LEDs above Slider switches
    LEDR => ledr,--		:out	std_logic_vector( 9 downto 0);	
	-- Push Button
	KEY => key, --	    :in     std_logic_vector( 3 downto 0);  
   -- Slider Switch
    SW  => sw--		:in	std_logic_vector( 9 downto 0 ) 
		);	
end architecture;
		
		
		
	
	
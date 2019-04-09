LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity de1_top is
generic (
   simulation_wide : positive := 28;    -- used for simulation to overide width
	simulation_max  : positive := 50000000); -- used for simulaiton to oreride max value
port
(
	-- 50Mhz clock, i.e. 50 Million rising edges per second
   clock_50 :in  std_logic; 
   -- 7 Segment Display
	hex0     :out std_logic_vector(6 downto 0); -- right most
	hex1     :out std_logic_vector(6 downto 0);	
	hex2     :out std_logic_vector(6 downto 0);	
	hex3     :out std_logic_vector(6 downto 0);	
	hex4     :out std_logic_vector(6 downto 0);	
	hex5     :out std_logic_vector(6 downto 0); -- left most
   -- Red LEDs above Slider switches
	-- drive the ledr's high to light them up
   ledr     :out std_logic_vector(9 downto 0);
	-- key/Push Button, push button to drive a signal low, normally high
	key      :in  std_logic_vector(3 downto 0);  
   -- Slider Switch, logic 0 when slide down, logic 1 when pushed towards 7 segments
	sw       :in	 std_logic_vector(9 downto 0) 
);

end de1_top;

architecture struct of de1_top is

	signal clk : std_logic;
	signal q_dt: std_logic_vector(3 downto 0);
	signal address: std_logic_vector(4 downto 0);
	signal data: std_logic_vector(3 downto 0);
	signal upper_address: std_logic_vector(3 downto 0);

	-- define the component	
	component seven_segment_cntrl IS
		-- Begin port declaration
		port (
			-- Declare data input "input"
			input : in std_logic_vector(3 downto 0);
			-- Declare the seven segment output
			hex   : out std_logic_vector(6 downto 0));
	-- End entity		
	end component;


	-- define the ram32x4 component	
	component ram32x4 IS 
		port(
			address: in std_logic_vector(4 downto 0);
			clock: in std_logic := '1';
			data: in std_logic_vector(3 downto 0);
			wren: in std_logic;
			q: out std_logic_vector(3 downto 0)
		);
	end component;


	begin

		-- turn off the other 7 segments, drive high to turn off
		hex1 <= (others => '1');
		hex3 <= (others => '1');

		data <= sw(3 downto 0);
		address <= sw(8 downto 4);

		-- turn off unused LEDs, drive 0 to keep off
		ledr(9 downto 0) <= (others =>'0');

		-- use key 0 as the clock, normally high, push and release for rising edge
		-- for lab7 memory lab, use key (0) as clock for parts 2 
		clk<=key(0); 
		
		upper_address <= "000" & address(4);
		
		ram: ram32x4
			port map (
				address => address,
				clock => clk,
				data => data,
				wren => sw(9),
				q => q_dt
			);
		
		hex0segment: seven_segment_cntrl
			port map (
				input => q_dt,
				hex => hex0
			);
		hex2segment: seven_segment_cntrl
			port map (
				input => data,
				hex => hex2
			);
		hex4segment: seven_segment_cntrl
			port map (
				input => address(3 downto 0),
				hex => hex4
			);
		hex5segment: seven_segment_cntrl
			port map (
				input => upper_address,
				hex => hex5
			);
		
end; -- end the design










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

-- define signals to be used
--signal enable_pulse_every_second  : std_logic;
--signal reset                      : std_logic;
--signal one_second_count_value     : std_logic_vector(3 downto 0);
--signal ten_second_count_value     : std_logic_vector(3 downto 0);
--signal enable_10_second           : std_logic;
--signal load_counter               : std_logic;

signal clk : std_logic;

-- define the component	
component seven_segment_cntrl IS
	-- Begin port declaration
	port (
		-- Declare data input "input"
		input : in unsigned(3 downto 0);
		-- Declare the seven segment output
		hex   : out std_logic_vector(6 downto 0));
-- End entity		
end component;

-- define the component
component gen_counter is
generic (
		wide :positive; -- how many bits is the counter
		max  :positive  -- what is the max count
		);
port (
		clk	 :in	std_logic;
		data	 :in  std_logic_vector(wide-1 downto 0 );
		load	 :in  std_logic;
		enable :in  std_logic;
		reset	 :in  std_logic;
		count	 :out std_logic_vector(wide-1 downto 0 );
		term	 :out std_logic);
	end component;


begin

-- turn off the other 7 segments, drive high to turn off
--hex1 <= (others => '1');

-- turn off unused LEDs, drive 0 to keep off
ledr(9 downto 0) <= (others =>'0');

-- use key 0 as the clock, normally high, push and release for rising edge
-- for lab7 memory lab, use key (0) as clock for parts I through III
-- for Part IV you will use clock_50 as the clock
clk<=key(0); 

end; -- end the design










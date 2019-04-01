LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity de1_top is
generic (
  simulation_wide : positive := 24;    -- used for simulation to overide width
  simulation_max  : positive := 12500000); -- used for simulaiton to oreride max value, counts a fourth of a second
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

	signal enable_pulse_every_one_fourth_second     : std_logic;
	signal enable_pulse_every_one_second     : std_logic; -- for flash-r or y
	signal one_sec_count_value					: std_logic_vector(1 downto 0); -- 2 bits 

	-- *******
	signal reset_n                       : std_logic;
	signal load_counter                  : std_logic;
	
	signal main_one_second_counter: std_logic_vector(0 downto 0);

	-- define the component
	component gen_counter is
	generic (
		wide :positive; -- how many bits is the counter
		max  :positive  -- what is the max count
		);
	port (
		clk	     :in	std_logic;
		data	 :in  std_logic_vector(wide-1 downto 0 );
		load	 :in  std_logic;
		enable   :in  std_logic;
		reset_n	 :in  std_logic;
		count	 :out std_logic_vector(wide-1 downto 0 );
		term	 :out std_logic);
	end component;
	
	component traffic_ns_cntrl is 
		PORT (
			clk, reset_a, green_timer_switch, night_mode, error_mode : IN STD_LOGIC;
			time_counter: IN STD_LOGIC_VECTOR(0 downto 0);
			hex_0 : OUT STD_LOGIC_VECTOR(6 downto 0)
		);
	end component traffic_ns_cntrl;
		
	component traffic_ew_cntrl is
		PORT (
			clk, reset_a, red_timer_switch, night_mode, error_mode: IN STD_LOGIC;
			time_counter: IN STD_LOGIC_VECTOR(0 downto 0);
			hex_5 : OUT STD_LOGIC_VECTOR(6 downto 0)
		);
	end component traffic_ew_cntrl;
		
		
	begin
	
		-- use a name that makes sense, key(0) is our reset, push to reset
		reset_n <= key(0);  -- key is normally high
		
		
		-- first use an instance of counter to get clock enable
		-- never ever use the term output as clock, always use as an enable 
		large_counter : gen_counter
		generic map (
				wide => simulation_wide, -- need 24 bits do divide 12.5Mhz down to .25th of a second
				max  => simulation_max   -- terminate the count when you hit 12.5 MHz
				)
		port map (
				clk      => clock_50,
				data	 => (others => '0'),
				load	 => '0',   -- not loadable
				enable   => '1',   -- always enabled
				reset_n	 => reset_n, 
				count	 => open,  -- we are not using this signal
				term	 => enable_pulse_every_one_fourth_second -- goes high for 1 clock cycle max value hit
				);
			
		load_counter <= not key(2); -- need to invert, key is normally high		
	
		-- this counter will count 1 seconds.			
		one_second_counter : gen_counter 
		generic map (
			wide => 2,  -- created a two bit counter (max count would be 3) which will hold the max, 0,1,2,3 
			max  => 3   -- .25 * 4 = 1 second thus 4 is count, if count is 4, then max is count - 1 = 3
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter, 
			enable   => enable_pulse_every_one_fourth_second, -- always enabled
			reset_n	 => reset_n,
			count	 => one_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_every_one_second -- this signal will pulse for 1 clock cycle when the cunter roles over
		);
			

		main_one_second_counter(0) <= enable_pulse_every_one_second;
	
		ns_main: traffic_ns_cntrl PORT MAP ( 
			clk => clock_50,
			reset_a => reset_n,
			green_timer_switch => SW(8), 
			night_mode => SW(9),
			error_mode => KEY(3),
			time_counter => main_one_second_counter,
			hex_0 => hex0
		);

		ew_main: traffic_ew_cntrl PORT MAP ( 
			clk => clock_50,
			reset_a => reset_n,
			red_timer_switch => SW(8), 
			time_counter => main_one_second_counter,
			night_mode => SW(9),
			error_mode => KEY(3),
			hex_5 => hex5
		);

end architecture; -- end the design










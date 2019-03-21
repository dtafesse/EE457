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

	-- define signals to be used for NS
	signal enable_pulse_seven_seconds     : std_logic; -- red <= ew(green + yellow)
	signal enable_pulse_seven_half_seconds     : std_logic; -- ns <= green SW == 0
	signal enable_pulse_ten_seconds     : std_logic; -- ns <= green SW == 1
	signal enable_pulse_one_point_five_seconds     : std_logic; -- ns <= yellow

	signal seven_sec_count_value					: std_logic_vector(4 downto 0); -- 5 bit for 5 bit counter
	signal seven_half_sec_count_value					: std_logic_vector(4 downto 0); -- 5 bit for 5 bit counter
	signal ten_sec_count_value					: std_logic_vector(5 downto 0); -- 6 bit for 6 bit counter
	signal one_point_five_sec_count_value					: std_logic_vector(2 downto 0); -- 3 bit for 3 bit counter

	-- define signals to be used for EW
	signal enable_pulse_nine_seconds     : std_logic; -- red <= nw(green + yellow) with SW8 - 0
	signal enable_pulse_eleven_half_seconds     : std_logic; -- red <= nw(green + yellow) with SW8 - 1
	signal enable_pulse_five_fourth_seconds     : std_logic; -- ew <= green
	signal enable_pulse_one_point_seven_five_seconds     : std_logic; -- ew <= yellow

	signal nine_sec_count_value					: std_logic_vector(5 downto 0); -- 6 bit for 6 bit counter
	signal eleven_half_sec_count_value					: std_logic_vector(5 downto 0); -- 6 bit for 6 bit counter
	signal five_fourth_sec_count_value					: std_logic_vector(4 downto 0); -- 5 bit for 5 bit counter
	signal one_point_seven_five_sec_count_value					: std_logic_vector(2 downto 0); -- 3 bit for 3 bit counter

	-- *******
	signal reset_n                       : std_logic;
	signal sw8                       : std_logic;
	signal selected_green_ns_timer_value : std_logic;
	signal selected_red_ew_timer_value : std_logic;
	signal load_counter                  : std_logic;
	signal nw_state_input 					: std_logic_vector(3 downto 0); 
	signal ew_state_input						: std_logic_vector(3 downto 0); 

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
			clk, reset_a, red_timer, green_timer, yellow_timer, flash_yellow_timer, night_mode, error_mode : IN STD_LOGIC;
			east_west_state: IN STD_LOGIC_VECTOR(3 downto 0);
			hex_0 : OUT STD_LOGIC_VECTOR(6 downto 0);
			nw_state_out: OUT STD_LOGIC_VECTOR(3 downto 0) 
		);
	end component traffic_ns_cntrl;
		
	component traffic_ew_cntrl is
		PORT (
			clk, reset_a, red_timer, green_timer, yellow_timer, flash_red_timer, night_mode, error_mode: IN STD_LOGIC;
			north_south_state: IN STD_LOGIC_VECTOR(3 downto 0);
			hex_5 : OUT STD_LOGIC_VECTOR(6 downto 0);
			ew_state_out: OUT STD_LOGIC_VECTOR(3 downto 0) 
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
			
			-- this counter will count 1.5 seconds.			
		one_point_five_second_counter : gen_counter 
		generic map (
			wide => 3,  -- created a 3 bit counter (max count would be 5) which will hold the max, max: 0, 1, 2, 3, 4, 5
			max  => 5   --.25 * 6 = 1.5 seconds thus 6 is count, if count is 6, then max is count - 1 = 5
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => one_point_five_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_one_point_five_seconds
		);

		-- this counter will count 1.75 seconds.			
		one_point_seven_five_second_counter : gen_counter 
		generic map (
			wide => 3,  -- created a 3 bit counter (max count would be 5) which will hold the max, max: 0, 1, 2, 3, 4, 5, 6
			max  => 6   --.25 * 7 = 1.75 seconds thus 7 is count, if count is 7, then max is count - 1 = 6
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => one_point_seven_five_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_one_point_seven_five_seconds
		);

		-- this counter will count 5.25 seconds.			
		five_fourth_counter : gen_counter 
		generic map (
			wide => 5,  -- created a 5 bit counter (max count would be 5) which will hold the max, max: 0, 1,..., 20
			max  => 20   --.25 * 21 = 5.25 seconds thus 21 is count, if count is 21, then max is count - 1 = 20
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => five_fourth_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_five_fourth_seconds
		);

		-- this counter will count 7 seconds.			
		seven_second_counter : gen_counter 
		generic map (
			wide => 5,  -- created a 5 bit counter (max count would be 5) which will hold the max, max: 0, 1,..., 27
			max  => 27   --.25 * 28 = 7 seconds thus 28 is count, if count is 28, then max is count - 1 = 27
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => seven_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_seven_seconds
		);

		-- this counter will count 7.5 seconds.			
		seven_half_second_counter : gen_counter 
		generic map (
			wide => 5,  -- created a 5 bit counter (max count would be 5) which will hold the max, max: 0, 1,..., 29
			max  => 29   --.25 * 30 = 7 seconds thus 30 is count, if count is 30, then max is count - 1 = 29
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => seven_half_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_seven_half_seconds
		);

		-- this counter will count 9 seconds.			
		nine_second_counter : gen_counter 
		generic map (
			wide => 6,  -- created a 6 bit counter (max count would be 35) which will hold the max, max: 0, 1,..., 35
			max  => 35   --.25 * 36 = 9 seconds thus 36 is count, if count is 36, then max is count - 1 = 35
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => nine_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_nine_seconds
		);

		-- this counter will count 10 seconds.			
		ten_second_counter : gen_counter 
		generic map (
			wide => 6,  -- created a 6 bit counter (max count would be 39) which will hold the max, max: 0, 1,..., 39
			max  => 39   --.25 * 40 = 10 seconds thus 40 is count, if count is 40, then max is count - 1 = 39
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => ten_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_ten_seconds
		);

		-- this counter will count 11.5 seconds.			
		eleven_half_second_counter : gen_counter 
		generic map (
			wide => 6,  -- created a 6 bit counter (max count would be 5) which will hold the max, max: 0, 1,..., 43
			max  => 43   --.25 * 44 = 11.5 seconds thus 44 is count, if count is 44, then max is count - 1 = 43
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => eleven_half_sec_count_value, -- we are not using this signal
			term	 => enable_pulse_eleven_half_seconds 
		);
		
		sw8 <= SW(8);
		
		PROCESS(sw8, enable_pulse_ten_seconds, enable_pulse_seven_half_seconds, enable_pulse_nine_seconds, enable_pulse_eleven_half_seconds)
		Begin
		 	if sw8 = '1' then
				selected_green_ns_timer_value <= enable_pulse_ten_seconds;
				selected_red_ew_timer_value <= enable_pulse_eleven_half_seconds;
			else
				selected_green_ns_timer_value <= enable_pulse_seven_half_seconds;
				selected_red_ew_timer_value <= enable_pulse_nine_seconds;
		 	end if;
		END PROCESS;

		ns_main: traffic_ns_cntrl PORT MAP ( 
			clk => clock_50,
			reset_a => reset_n,
			red_timer => enable_pulse_seven_seconds, 
			green_timer => selected_green_ns_timer_value, 
			yellow_timer => enable_pulse_one_point_five_seconds, 
			flash_yellow_timer => enable_pulse_every_one_second,
			night_mode => SW(9),
			error_mode => KEY(3),
			east_west_state => ew_state_input(3 downto 0),
			hex_0 => hex0,
			nw_state_out => nw_state_input
		);

		ew_main: traffic_ew_cntrl PORT MAP ( 
			clk => clock_50,
			reset_a => reset_n,
			red_timer => selected_red_ew_timer_value, 
			green_timer => enable_pulse_five_fourth_seconds, 
			yellow_timer => enable_pulse_one_point_seven_five_seconds, 
			flash_red_timer => enable_pulse_every_one_second,
			night_mode => SW(9),
			error_mode => KEY(3),
			north_south_state => nw_state_input(3 downto 0),
			hex_5 => hex5,
			ew_state_out => ew_state_input
		);

end architecture; -- end the design










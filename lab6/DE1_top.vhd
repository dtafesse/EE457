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

	-- define signals to be used
	signal enable_pulse_every_half_second     : std_logic;
	signal enable_pulse_every_one_fourth_second: std_logic;
	signal one_half_count_value					: std_logic_vector(0 downto 0);
	signal three_fourth_count_value					: std_logic_vector(1 downto 0);
	signal reset_n                       : std_logic;
	signal sw0                       : std_logic;
	signal enable_pulse_every_three_fourth_second  : std_logic;
	signal selected_timer_value : std_logic;
	signal load_counter                  : std_logic;
	
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
	
	component message_cntrl is
		PORT (
			clk, reset_a, count, sliding_msg_sw, shift_msg_left, halt_shift: IN STD_LOGIC;
			hex_0, hex_1, hex_2, hex_3, hex_4, hex_5  : OUT STD_LOGIC_VECTOR(6 downto 0)
		);
	end component message_cntrl;
		
		
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

				
		-- this counter will count 0.5 seconds.			
		one_half_second_counter : gen_counter 
		generic map (
			wide => 1,  -- created a one bit counter (max count would be 1) which will hold the max, 0,1 
			max  => 1   -- .25 * 2 = .5 second thus 2 is count, if count is 2, then max is count - 1 = 1
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter, 
			enable   => enable_pulse_every_one_fourth_second, -- always enabled
			reset_n	 => reset_n,
			count	 => one_half_count_value, -- we are not using this signal
			term	 => enable_pulse_every_half_second -- this signal will pulse for 1 clock cycle when the cunter roles over
		);
			
		three_fourth_second_counter : gen_counter 
		generic map (
			wide => 2,  -- created a 2 bit counter (max count would be 2) which will hold the max, max: 0, 1, 2
			max  => 2   --.25 * 3 = .75 second thus 3 is count, if count is 3, then max is count - 1 = 2
			)
		port map (
			clk	 => clock_50,
			data	 => (others => '0'),
			load	 => load_counter,
			enable   => enable_pulse_every_one_fourth_second,
			reset_n	 => reset_n,
			count	 => three_fourth_count_value, -- we are not using this signal
			term	 => enable_pulse_every_three_fourth_second
		);
		
		sw0 <= SW(0);
		
		PROCESS(sw0, enable_pulse_every_three_fourth_second, enable_pulse_every_half_second)
		Begin
		 	if sw0 = '0' then
		 		selected_timer_value <= enable_pulse_every_three_fourth_second;
		 	else
		 		selected_timer_value <= enable_pulse_every_half_second;
		 	end if;
		END PROCESS;

		msg_main: message_cntrl PORT MAP ( 
			clk => clock_50,
			reset_a => reset_n,
			count => selected_timer_value,
			sliding_msg_sw => SW(1),
			shift_msg_left => KEY(1),
			halt_shift => KEY(2),
			hex_0 => hex0,
			hex_1 => hex1,
			hex_2 => hex2,
			hex_3 => hex3,
			hex_4 => hex4,
			hex_5 => hex5
		);

end architecture; -- end the design










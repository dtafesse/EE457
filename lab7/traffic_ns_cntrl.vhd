LIBRARY ieee;
USE ieee.NUMERIC_STD.all;
USE ieee.STD_LOGIC_1164.all;

ENTITY traffic_ns_cntrl IS
	PORT (
		-- system clock
		clk: IN STD_LOGIC;
		
		--	 when KEY(0) is low we run, when KEY(0) is high we reset the state back to state red
		reset_a : IN STD_LOGIC;
		
		-- selected time intervals for green
        green_timer_switch: IN STD_LOGIC;
		
		-- controls the night mode, if SW(9) = '1', move into night mode 
		night_mode: IN STD_LOGIC;	
		
		-- will shift left when KEY(3) is high (pressed and held) === 0 => error mode
		error_mode: IN STD_LOGIC;
           
        east_west_state: IN STD_LOGIC_VECTOR(3 downto 0);
        
		-- seven segment outputs for north-south
		hex_0 : OUT STD_LOGIC_VECTOR(6 downto 0); -- right most

        -- one second counter, goes high every one second 
        time_counter: IN STD_LOGIC_VECTOR(0 downto 0);

		-- message out to east-west controller
		nw_state_out: OUT STD_LOGIC_VECTOR(3 downto 0) 
	);
END ENTITY traffic_ns_cntrl;


-- Begin Architecture
ARCHITECTURE logic OF traffic_ns_cntrl IS

	-- Declare enumberated state type consisting of 10 values
	TYPE state_type IS (red, green, yellow, flash_y);
	
	-- Declare two signals named "current_state" and "next_state" to be of enumerated type
	signal current_state: state_type;
    signal next_state: state_type;
    signal error_mode_active: std_logic;
    --signal red_timer, green_timer, yellow_timer, flash_yellow_timer: STD_LOGIC; 
    signal count: integer := 0;
   
	BEGIN
		-- Create sequential process to control state transitions by making current_state equal to next state on
		--	rising edge transitions; Use asynchronous clear control
		PROCESS (clk, reset_a, time_counter, green_timer_switch, night_mode, error_mode, east_west_state)
			variable temp_time_counter : integer;		
        BEGIN
			temp_time_counter := to_integer(unsigned(time_counter));
			if reset_a = '0' then
                current_state <= red;
                error_mode_active <= '0'; -- reset the capture and hold of the reset key if it was pressed
                nw_state_out(3 downto 0) <= "0001";
                count <= 0;
            elsif rising_edge(clk) then
                if temp_time_counter = 1 then
                    if count < 27 and (east_west_state = "1000" or east_west_state = "1001" or starting_signal = "1") then -- 27 -> 0.25 * 28 = 7 seconds has passed, count is 28, thus max is 27
                        current_state <= red;
                        nw_state_out(3 downto 0) <= "0001";
                        count <= count + 1; 
                    elsif count > 27 and east_west_state = "0110" then -- between 7 seconds and (7+10=17) or (7+7.5=14.5) in green
                        if green_timer_switch = '1' then
                            if count < 66 then -- 39 = 0.25*40 = 10 seconds, count = 39, max 39 - 1, therefore 7+10 sec (17 sec) -> 27+39 = 66 
                                if night_mode = '1' or error_mode = '0' then -- flash yellow
                                    current_state <= flash_y;
                                    nw_state_out(3 downto 0) <= "0100";
                                elsif night_mode = '0' then
                                    -- should only get out of error mode by reset, so won't have an if statement for it
                                    current_state <= green;
                                    nw_state_out(3 downto 0) <= "0010";
                                    count <= count + 1;
                                end if;
                            elsif count < 71 then  -- between 17 seconds and (17+1.5 = 18.5) seconds - in yellow, 1.5 seconds
                                -- .25 * 6 = 1.5 seconds, count = 6, max is 6-1 = 5, therefore 17 + 1.5 -> 66 + 5 = 71
                                current_state <= yellow;
                                nw_state_out(3 downto 0) <= "0011";
                                count <= count + 1; 
                            end if;
                        else
                            if count < 56 then -- .25 * 30 = 7.5 seconds, count = 30, max 30 - 1 = 29, therefore 7 + 7.5 (14.5) -> 27+29 = 56
                                if night_mode = '1' or error_mode = '0' then -- flash yellow
                                    current_state <= flash_y;
                                    nw_state_out(3 downto 0) <= "0100";
                                elsif night_mode = '0' then
                                    -- should only get out of error mode by reset, so won't have an if statement for it
                                    current_state <= green;
                                    nw_state_out(3 downto 0) <= "0010";
                                    count <= count + 1;        
                                end if;
                            elsif count < 61 then -- between 14.5 seconds and (14.5+1.5 = 16) seconds - in yellow, 1.5 seconds
                                -- .25 * 6 = 1.5 seconds, count = 6, max is 6-1 = 5, therefore 14.5 + 1.5 -> 56 + 5 = 61
                                current_state <= yellow;
                                nw_state_out(3 downto 0) <= "0011";
                                count <= count + 1; 
                            end if;
                        end if; 
                    else
                        -- went through one cycle, reset the count back to zero;
                        count <= 0; 
                    end if;  
                end if;
			end if;
		END PROCESS;
		
		PROCESS(current_state)
		BEGIN
            CASE current_state IS
                WHEN red => 
                    hex_0(6 downto 0) <= "0111001"; -- r      
                WHEN green => 
                    hex_0(6 downto 0) <= "0000100"; -- g
                WHEN yellow => 
                    hex_0(6 downto 0) <= "1001100"; -- y  
                WHEN flash_y =>
                    hex_0(6 downto 0) <= "1001100"; -- y  
                WHEN others =>
                    hex_0(6 downto 0) <= "1111111"; -- empty
            END CASE;		
		END PROCESS;
END ARCHITECTURE logic;
		
					
		
		
		
		
		
		
		
		
		
		
		
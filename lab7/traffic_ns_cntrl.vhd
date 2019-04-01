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
           
		-- seven segment outputs for north-south
		hex_0 : OUT STD_LOGIC_VECTOR(6 downto 0); -- right most

        -- one second counter, goes high every one second 
        time_counter: IN STD_LOGIC_VECTOR(0 downto 0)
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
    signal night_mode_activated: std_logic;

    BEGIN
        

		-- Create sequential process to control state transitions by making current_state equal to next state on
		--	rising edge transitions; Use asynchronous clear control
		PROCESS (clk, reset_a, time_counter, green_timer_switch, night_mode, error_mode, error_mode_active, night_mode_activated)
            variable temp_time_counter : integer;		
        BEGIN
            temp_time_counter := to_integer(unsigned(time_counter));

			if reset_a = '0' then
                current_state <= red;
                error_mode_active <= '0'; -- reset the capture and hold of the reset key if it was pressed
                count <= 0;
                night_mode_activated <= '0';
            elsif rising_edge(clk) then
                if error_mode = '0' then
                    -- key(3) was pushed down
                    -- set up error mode for capture and hold
                    error_mode_active <= '1';
                end if;
                if temp_time_counter = 1 then
                    if green_timer_switch = '1' then -- green is 10 seconds
                        if count < 39 then -- 39 = 0.25*40 = 10 seconds, count = 40, max 39,
                            current_state <= green;
                            count <= count + 1;
                        elsif count = 39 and (night_mode = '1' or error_mode_active = '1') then
                            -- flash yellow
                            current_state <= flash_y;
                            night_mode_activated <= '1';
                        elsif (count = 39 and night_mode_activated = '1') then 
                            -- should only get out of error mode by reset, so won't have an if statement for it
                            -- leaving night mode should take you back to green so reset the count back to end of red   
                            current_state <= green;
                            count <= 0; 
                            night_mode_activated <= '0';
                        elsif count < 44 then  -- in yellow, 1.5 seconds so up to 11.5 seconds
                            -- .25 * 6 = 1.5 seconds, count = 6, max is 6-1 = 5, therefore 10 sec + 1.5 sec -> 39 + 5 = 44
                            current_state <= yellow;
                            count <= count + 1; 
                        elsif count < 71 then -- in red for 7 seconds so up to 18.5 seconds
                            -- 0.25 * 28 = 7 seconds has passed, count is 28, thus max is 27, 11.5 sec + 7 sec = 44 + 27= 71
                            current_state <= red;
                            count <= count + 1; 
                        elsif count >= 71 then 
                            -- went through one cycle, reset the count back to zero;
                            count <= 0; 
                        end if;
                    else
                        if count < 29 then -- .25 * 30 = 7.5 seconds, count = 30, max 30 - 1 = 29
                            current_state <= green;
                            count <= count + 1; 
                        elsif count = 29 and (night_mode = '1' or error_mode = '0') then
                            -- flash yellow
                            current_state <= flash_y;
                            night_mode_activated <= '1';
                        elsif (count = 29 and night_mode_activated = '1') then 
                            -- should only get out of error mode by reset, so won't have an if statement for it
                            -- leaving night mode should take you back to green so reset the count back to end of red   
                            current_state <= green;
                            count <= 0; 
                            night_mode_activated <= '0';
                        elsif count < 34 then -- in yellow, 1.5 seconds
                            -- .25 * 6 = 1.5 seconds, count = 6, max is 6-1 = 5, therefore 7.5 + 1.5 -> 29 + 5 = 34
                            current_state <= yellow;
                            count <= count + 1; 
                        elsif count < 61 then 
                            -- 0.25 * 28 = 7 seconds has passed, count is 28, thus max is 27, 9 seconds + 7 seconds = 44 + 27= 71
                            current_state <= red;
                            count <= count + 1; 
                        elsif count >= 61 then 
                            -- went through one cycle, reset the count back to zero;
                            count <= 0; 
                        end if;
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
		
					
		
		
		
		
		
		
		
		
		
		
		
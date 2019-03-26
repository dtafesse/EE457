LIBRARY ieee;
USE ieee.NUMERIC_STD.all;
USE ieee.STD_LOGIC_1164.all;

ENTITY traffic_ew_cntrl IS
	PORT (
		-- system clock
		clk: IN STD_LOGIC;
		
		--	 when KEY(0) is low we run, when KEY(0) is high we reset the state back to state red
        reset_a : IN STD_LOGIC;
        
        red_timer_switch: IN STD_LOGIC;

		-- controls the night mode, if SW(9) = '1', move into night mode 
		night_mode: IN STD_LOGIC;	
		
		-- will shift left when KEY(3) is high (pressed and held) === 0 => error mode
		error_mode: IN STD_LOGIC;
           
        north_south_state: IN STD_LOGIC_VECTOR(3 downto 0);

        -- one second counter, goes high every one second 
        time_counter: IN STD_LOGIC_VECTOR(0 downto 0);
        
		-- seven segment outputs for east-west
		hex_5 : OUT STD_LOGIC_VECTOR(6 downto 0); -- right most
       
        -- message out to north-south controller
        ew_state_out: OUT STD_LOGIC_VECTOR(3 downto 0) 
	);
END ENTITY traffic_ew_cntrl;


-- Begin Architecture
ARCHITECTURE logic OF traffic_ew_cntrl IS

	-- Declare enumberated state type consisting of 10 values
	TYPE state_type IS (red, green, yellow, flash_r);
	
	-- Declare two signals named "current_state" and "next_state" to be of enumerated type
	signal current_state: state_type;
    signal next_state: state_type;
    signal error_mode_active: std_logic;
    signal count: integer := 0;
	
	BEGIN
		-- Create sequential process to control state transitions by making current_state equal to next state on
		--	rising edge transitions; Use asynchronous clear control
        PROCESS (clk, reset_a, time_counter, red_timer_switch, night_mode, error_mode, north_south_state)
				variable temp_time_counter : integer;	
		  BEGIN
            temp_time_counter := to_integer(unsigned(time_counter));
			if reset_a = '0' then
                current_state <= red;
                error_mode_active <= '0'; -- reset the capture and hold of the reset key if it was pressed
                count <= 0;
                ew_state_out(3 downto 0) <= "0110";
            elsif rising_edge(clk) then
                if temp_time_counter = 1 then 
                    if red_timer_switch = '1' then -- red is held for 7.5 seconds
                        if count < 29 and (north_south_state = "0010" or north_south_state = "0011") then -- .25 * 30 = 7.5 seconds, count = 30, max 30 - 1 = 29 sec
                            current_state <= red;
                            ew_state_out(3 downto 0) <= "0110";
                            count <= count + 1; 
                        elsif count > 29 and count < 49 and north_south_state = "0001" then  -- green between 7.5 seconds and 7.5+5.25 seconds (12.75) 
                            --.25 * 21 = 5.25 seconds thus 21 is count, max is count - 1 = 20
                            -- therefore 7.5 + 5.25 (12.75) -> 29 + 20 = 49 
                            next_state <= green;
                            ew_state_out(3 downto 0) <= "1000";
                            count <= count + 1;
                        elsif count > 49 and count < 55 and north_south_state = "0001" then -- yellow between 12.75 seconds and 12.75 + 1.75 (14.5) seconds = 
                            --.25 * 7 = 1.75 seconds thus 7 is count, if count is 7, then max is count - 1 = 6
                            -- 12.75 + 1.75 (14.5) -> 49 + 6 = 55
                            if night_mode = '1' or error_mode = '0' then
                                current_state <= flash_r;
                                ew_state_out(3 downto 0) <= "1010";
                            elsif night_mode = '0' then -- night mode off go back to red
                            -- should only get out of error mode by reset, so won't have an if statement for it
                                current_state <= red;
                                ew_state_out(3 downto 0) <= "0110";
                                count <= count + 1; 
                            else
                                current_state <= yellow;
                                ew_state_out(3 downto 0) <= "1001";
                                count <= count + 1;
                            end if;
                        else -- gone through a cycle, rest counter
                            count <= 0;
                        end if;
                    else -- red is held for 9 seconds
                        if count < 35 and (north_south_state = "0010" or north_south_state = "0011") then -- .25 * 36 = 9 seconds thus 36 is count, if count is 36, then max is count - 1 = 35
                            current_state <= red;
                            ew_state_out(3 downto 0) <= "0110";
                            count <= count + 1; 
                        elsif count > 35 and count < 55 and north_south_state = "0001" then  -- green between 9 seconds and 9+5.25 seconds (14.25)
                            --.25 * 21 = 5.25 seconds thus 21 is count, max is count - 1 = 20
                            -- therefore 9 + 5.25 (14.25) -> 35 + 20 = 49 
                            next_state <= green;
                            ew_state_out(3 downto 0) <= "1000";
                            count <= count + 1;
                        elsif count > 55 and count < 61 and north_south_state = "0001" then -- yellow between 14.75 seconds and 14.75 + 1.75 (16.5) seconds = 
                            --.25 * 7 = 1.75 seconds thus 7 is count, if count is 7, then max is count - 1 = 6
                            -- 14.75 + 1.75 (16.5) -> 55 + 6 = 55
                            if night_mode = '1' or error_mode = '0' then
                                current_state <= flash_r;
                                ew_state_out(3 downto 0) <= "1010";
                            elsif night_mode = '0' then -- night mode off go back to red
                            -- should only get out of error mode by reset, so won't have an if statement for it
                                current_state <= red;
                                ew_state_out(3 downto 0) <= "0110";
                                count <= count + 1; 
                            else
                                current_state <= yellow;
                                ew_state_out(3 downto 0) <= "1001";
                                count <= count + 1;
                            end if;
                        else -- gone through a cycle, rest counter
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
                    hex_5(6 downto 0) <= "0111001"; -- r      
                WHEN green => 
                    hex_5(6 downto 0) <= "0000100"; -- g
                WHEN yellow => 
                    hex_5(6 downto 0) <= "1001100"; -- y  
                WHEN flash_r =>
                    hex_5(6 downto 0) <= "0111001"; -- r  
                WHEN others =>
                    hex_5(6 downto 0) <= "1111111"; -- empty
            END CASE;		
		END PROCESS;
END ARCHITECTURE logic;
		
					
		
		
		
		
		
		
		
		
		
		
		
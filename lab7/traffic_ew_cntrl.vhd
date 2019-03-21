LIBRARY ieee;
USE ieee.NUMERIC_STD.all;
USE ieee.STD_LOGIC_1164.all;

ENTITY traffic_ew_cntrl IS
	PORT (
		-- system clock
		clk: IN STD_LOGIC;
		
		--	 when KEY(0) is low we run, when KEY(0) is high we reset the state back to state red
		reset_a : IN STD_LOGIC;
		
		-- selected time intervals
		red_timer, green_timer, yellow_timer, flash_red_timer: IN STD_LOGIC; 
		
		-- controls the night mode, if SW(9) = '1', move into night mode 
		night_mode: IN STD_LOGIC;	
		
		-- will shift left when KEY(3) is high (pressed and held) === 0 => error mode
		error_mode: IN STD_LOGIC;
           
      north_south_state: IN STD_LOGIC_VECTOR(3 downto 0);
        
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
	
	BEGIN
		-- Create sequential process to control state transitions by making current_state equal to next state on
		--	rising edge transitions; Use asynchronous clear control
		PROCESS (clk, reset_a)
		BEGIN
			if reset_a = '0' then
                current_state <= red;
                error_mode_active <= '0'; -- reset the capture and hold of the reset key if it was pressed
			elsif rising_edge(clk) then
				-- if count = '1' then
					current_state <= next_state;
				-- end if;
			end if;
		END PROCESS;
		
		-- proccess which determines next state based on if KEY(1) and KEY(2) is held and pressed 
		PROCESS(current_state, red_timer, yellow_timer, green_timer, flash_red_timer, night_mode, error_mode, north_south_state)
		BEGIN
            CASE current_state IS
                WHEN red =>
                    if red_timer = '1' and north_south_state = "0001" then -- finished counting duration of green+yellow of N-S => 9 or 11.5 
                        next_state <= green;
                        ew_state_out(3 downto 0) <= "1000";
                    else
                        next_state <= current_state;
                        ew_state_out(3 downto 0) <= "0110";
                    end if;
                WHEN green => 
                    if green_timer = '1' and north_south_state = "0001" then -- finished counting 5.25 seconds
                        next_state <= yellow;
                        ew_state_out(3 downto 0) <= "1001";
                    else 
                        next_state <= current_state;
                        ew_state_out(3 downto 0) <= "1000";
                    end if;
                WHEN yellow => 
                    if yellow_timer = '1' then -- finished counting 1.75 seconds
								if north_south_state = "0010" or north_south_state = "0011" then
									next_state <= red;
									ew_state_out(3 downto 0) <= "0110";
								end if;
                    elsif night_mode = '1' or error_mode = '0' then
                        next_state <= flash_r;
                        error_mode_active <= '1'; -- error key has been pressed, "capture and hold?"
                        ew_state_out(3 downto 0) <= "1010";
                    else
                        next_state <= current_state;
                        ew_state_out(3 downto 0) <= "1001";
                    end if;
                WHEN flash_r => 
                    if flash_red_timer = '1' then 
                        if night_mode = '0' then
                            next_state <= red;
                            ew_state_out(3 downto 0) <= "0110";
                        elsif error_mode_active = '1' then
                            -- directions says only can get out of error mode via reset
                            next_state <= current_state;
                            ew_state_out(3 downto 0) <= "1010";
                        else
                            -- night mode is zero, thus stay flashing red
                            next_state <= current_state;
                            ew_state_out(3 downto 0) <= "1010";
                        end if;
                    end if;
                WHEN others =>
                    next_state <= red;
                    ew_state_out(3 downto 0) <= "0001";
            END CASE;
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
		
					
		
		
		
		
		
		
		
		
		
		
		
LIBRARY ieee;
USE ieee.NUMERIC_STD.all;
USE ieee.STD_LOGIC_1164.all;

ENTITY traffic_ns_cntrl IS
	PORT (
		-- system clock
		clk: IN STD_LOGIC;
		
		--	 when KEY(0) is low we run, when KEY(0) is high we reset the state back to state red
		reset_a : IN STD_LOGIC;
		
		-- selected time intervals
		red_timer, green_timer, yellow_timer, flash_yellow_timer: IN STD_LOGIC; 
		
		-- controls the night mode, if SW(9) = '1', move into night mode 
		night_mode: IN STD_LOGIC;	
		
		-- will shift left when KEY(3) is high (pressed and held) === 0 => error mode
		error_mode: IN STD_LOGIC;
           
      east_west_state: IN STD_LOGIC_VECTOR(3 downto 0);
        
		-- seven segment outputs for north-south
		hex_0 : OUT STD_LOGIC_VECTOR(6 downto 0); -- right most
       
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
    signal timer: std_logic_vector(5 downto 0); -- highest timer we have is - 6 bit -> 11.5 seconds  
	
	BEGIN
		-- Create sequential process to control state transitions by making current_state equal to next state on
		--	rising edge transitions; Use asynchronous clear control
		PROCESS (clk, reset_a)
            variable count: std_logic_vector(5 downto 0);
        BEGIN
			if reset_a = '0' then
                current_state <= red;
                error_mode_active <= '0'; -- reset the capture and hold of the reset key if it was pressed
			elsif rising_edge(clk) then
				if count = timer then
					current_state <= next_state;
				end if;
			end if;
		END PROCESS;
		
		PROCESS(current_state, red_timer, yellow_timer, green_timer, flash_yellow_timer, night_mode, error_mode, east_west_state)
		BEGIN
            CASE current_state IS
                WHEN red =>
                    if red_timer = '1' and east_west_state = "0110" then -- finished counting duration of green+yellow of E-W => 7 seconds
                        next_state <= green;
                        nw_state_out(3 downto 0) <= "0010";
                    else
                        next_state <= current_state;
                        nw_state_out(3 downto 0) <= "0001";
                    end if;
                WHEN green => 
                    if green_timer = '1' and east_west_state = "0110" then -- finished counting 7.5 seconds  or 10 sec depending on SW8 === 1
                        next_state <= yellow;
                        nw_state_out(3 downto 0) <= "0011";
                    elsif night_mode = '1' or error_mode = '0' then
                        error_mode_active <= '1'; -- error key has been pressed, "capture and hold?"
                        next_state <= flash_y;
                        nw_state_out(3 downto 0) <= "0100";
                    else
                        next_state <= current_state;
                        nw_state_out(3 downto 0) <= "0010";
                    end if;
                WHEN yellow => 
                    if yellow_timer = '1' then -- finished counting 1.5 seconds
								if east_west_state = "1000" or east_west_state = "1001" then 
									next_state <= red;
									nw_state_out(3 downto 0) <= "0001";
								end if;
                    else
                        next_state <= current_state;
                        nw_state_out(3 downto 0) <= "0011";
                    end if;
                WHEN flash_y => 
                    if flash_yellow_timer = '1' then 
                        if night_mode = '0' then
                            next_state <= green;
                            nw_state_out(3 downto 0) <= "0010";
                        elsif error_mode_active = '1' then
                            -- directions says only can get out of error mode via reset
                            next_state <= current_state;
                            nw_state_out(3 downto 0) <= "0100";
                        else
                            -- night mode is zero, thus also stay in flashing yellow
                            next_state <= current_state;
                            nw_state_out(3 downto 0) <= "0100";
                        end if;
                    end if;
                WHEN others =>
                    next_state <= red;
                    nw_state_out(3 downto 0) <= "0001";
            END CASE;
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
		
					
		
		
		
		
		
		
		
		
		
		
		
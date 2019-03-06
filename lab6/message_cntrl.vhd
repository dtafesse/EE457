LIBRARY ieee;
USE ieee.NUMERIC_STD.all;
USE ieee.STD_LOGIC_1164.all;

ENTITY message_cntrl IS
	PORT (
		-- system clock
		clk: IN STD_LOGIC;
		
		--	 when KEY(0) is low we run, when KEY(0) is high we reset the state back to state A
		reset_a : IN STD_LOGIC;
		
		-- switch values sw0 - controls speed of shifting
		-- sw0 IN STD_LOGIC;    --  <-  controls this in the DE1_top ? and just pass in count instead - which deteremines selected time  
		-- or do an if statment to check on these two switches, create a signal here which will be set based the result of the if statement 
		
		-- selected time intervals
		count: IN STD_LOGIC; 
		
		-- controls the sliding message, if SW(1) = '0', message => EE457 else, message => dUdes
		sliding_msg_sw: IN STD_LOGIC;	
		
		-- will shift left when KEY(1) is high (pressed and held)
		shift_msg_left: IN STD_LOGIC;
		
		-- will shald shifting when KEY(2) is high (pressed and held)
		halt_shift: IN STD_LOGIC;
		
		-- seven segment outputs 
		hex_0 : OUT STD_LOGIC_VECTOR(6 downto 0); -- right most
		hex_1, hex_2, hex_3, hex_4  : OUT STD_LOGIC_VECTOR(6 downto 0);
		hex_5 : OUT STD_LOGIC_VECTOR(6 downto 0) -- left most
	);
END ENTITY message_cntrl;


-- Begin Architecture
ARCHITECTURE logic OF message_cntrl IS

	-- Declare enumberated state type consisting of 10 values
	TYPE state_type IS (a, b, c, d, e, f, g, h, i, j);
	
	-- Declare two signals named "current_state" and "next_state" to be of enumerated type
	signal current_state: state_type;
	signal next_state: state_type;
	
	BEGIN
		-- Create sequential process to control state transitions by making current_state equal to next state on
		--	rising edge transitions; Use asynchronous clear control
		PROCESS (clk, reset_a)
		BEGIN
			if reset_a = '0' then
				current_state <= a;
			elsif rising_edge(clk) then
				if count = '1' then
					current_state <= next_state;
				end if;
			end if;
		END PROCESS;
		
		-- proccess which determines next state based on if KEY(1) and KEY(2) is held and pressed 
		PROCESS(current_state, shift_msg_left, halt_shift)
		BEGIN
			IF shift_msg_left = '1' then -- Going clockwise/right
				CASE current_state IS
					WHEN a =>
						if halt_shift = '1' then
							next_state <= b;
						else -- stay on current state
							next_state <= current_state;
						end if;
					WHEN b =>
						if halt_shift = '1' then
							next_state <= c;
						else
							next_state <= current_state;
						end if;
					WHEN c =>
						if halt_shift = '1' then	
							next_state <= d;
						else
							next_state <= current_state;
						end if;
					WHEN d =>
						if halt_shift = '1' then
							next_state <= e;
						else
							next_state <= current_state;
						end if;
					WHEN e =>
						if halt_shift = '1' then
							next_state <= f;
						else
							next_state <= current_state;
						end if;
					WHEN f =>
						if halt_shift = '1' then
							next_state <= g;
						else
							next_state <= current_state;
						end if;
					WHEN g =>
						if halt_shift = '1' then
							next_state <= h;
						else
							next_state <= current_state;
						end if;
					WHEN h =>
						if halt_shift = '1' then
							next_state <= i;
						else
							next_state <= current_state;
						end if;
					WHEN j =>
						if halt_shift = '1' then
							next_state <= a;
						else
							next_state <= current_state;
						end if;
					WHEN others =>
						next_state <= a;
				END CASE;
			ELSE -- Going counter clkwise/left
				CASE current_state IS
					WHEN a =>
						if halt_shift = '1' then
							next_state <= j;
						else
							next_state <= current_state;
						end if;		
					WHEN j =>
						if halt_shift = '1' then
							next_state <= i;
						else
							next_state <= current_state;
						end if;		
					WHEN i =>
						if halt_shift = '1' then
							next_state <= h;
						else
							next_state <= current_state;
						end if;	
					WHEN h =>
						if halt_shift = '1' then
							next_state <= g;
						else
							next_state <= current_state;
						end if;	
					WHEN g =>
						if halt_shift = '1' then
							next_state <= f;
						else
							next_state <= current_state;
						end if;	
					WHEN f =>
						if halt_shift = '1' then
							next_state <= e;
						else
							next_state <= current_state;
						end if;	
					WHEN e =>
						if halt_shift = '1' then
							next_state <= d;
						else
							next_state <= current_state;
						end if;	
					WHEN d =>
						if halt_shift = '1' then
							next_state <= c;
						else
							next_state <= current_state;
						end if;	
					WHEN c =>
						if halt_shift = '1' then
							next_state <= b;
						else
							next_state <= current_state;
						end if;	
					WHEN b =>
						if halt_shift = '1' then
							next_state <= a;
						else
							next_state <= current_state;
						end if;	
					WHEN others =>
						next_state <= a;
				END CASE;
			END IF;
		END PROCESS;
		
		PROCESS(current_state, sliding_msg_sw)
		BEGIN
			IF sliding_msg_sw = '0' then
				CASE current_state IS
					WHEN a => 
						hex_5(6 downto 0) <= "0000110"; -- E 
						hex_4(6 downto 0) <= "0000110"; -- E
						hex_3(6 downto 0) <= "0011001"; -- 4 
						hex_2(6 downto 0) <= "0010010"; -- 5 
						hex_1(6 downto 0) <= "1111000"; -- 7 
						hex_0(6 downto 0) <= "1000000"; -- 0 
					WHEN b =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "0000110"; -- E
						hex_3(6 downto 0) <= "0000110"; -- E
						hex_2(6 downto 0) <= "0011001"; -- 4
						hex_1(6 downto 0) <= "0010010"; -- 5
						hex_0(6 downto 0) <= "1111001"; -- 1 
					WHEN c =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "0000110"; -- E
						hex_2(6 downto 0) <= "0000110"; -- E
						hex_1(6 downto 0) <= "0011001"; -- 4
						hex_0(6 downto 0) <= "0100100"; -- 2 
					WHEN d =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "0000110"; -- E
						hex_1(6 downto 0) <= "0000110"; -- E
						hex_0(6 downto 0) <= "0110000"; -- 3
					WHEN e =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <= "0000110"; -- E
						hex_0(6 downto 0) <= "0011001"; -- 4 
					WHEN f =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <= "1111111"; -- empty
						hex_0(6 downto 0) <= "0010010"; -- 5
					WHEN g =>
						hex_5(6 downto 0) <= "1111000"; -- 7
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <= "1111111"; -- empty
						hex_0(6 downto 0) <= "0000010"; -- 6 
					WHEN h =>
						hex_5(6 downto 0) <= "0010010"; -- 5
						hex_4(6 downto 0) <= "1111000"; -- 7
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <= "1111111"; -- empty
						hex_0(6 downto 0) <= "1111000"; -- 7
					WHEN i =>
						hex_5(6 downto 0) <= "0011001"; -- 4
						hex_4(6 downto 0) <= "0010010"; -- 5
						hex_3(6 downto 0) <= "1111000"; -- 7
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <= "1111111"; -- empty
						hex_0(6 downto 0) <= "0000000"; -- 8
					WHEN j =>
						hex_5(6 downto 0) <= "0000110"; -- E
						hex_4(6 downto 0) <= "0011001"; -- 4
						hex_3(6 downto 0) <= "0010010"; -- 5
						hex_2(6 downto 0) <= "1111000"; -- 7
						hex_1(6 downto 0) <= "1111111"; -- empty
						hex_0(6 downto 0) <= "0010000"; -- 9 
					WHEN others =>
						-- back to a
						hex_5(6 downto 0) <= "0000110"; -- E 
						hex_4(6 downto 0) <= "0000110"; -- E
						hex_3(6 downto 0) <= "0011001"; -- 4 
						hex_2(6 downto 0) <= "0010010"; -- 5 
						hex_1(6 downto 0) <= "1111000"; -- 7 
						hex_0(6 downto 0) <= "1000000"; -- 0 
				END CASE;
			ELSE
				-- message is dUdEs
				CASE current_state IS
					when a => 
						hex_5(6 downto 0) <= "0100001"; -- d 
						hex_4(6 downto 0) <= "1000001"; -- U
						hex_3(6 downto 0) <= "0100001"; -- d
						hex_2(6 downto 0) <= "0000110"; -- E 
						hex_1(6 downto 0) <= "0010010"; -- S 
						hex_0(6 downto 0) <= "1000000"; -- 0
					when b => 
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "0100001"; -- d
						hex_3(6 downto 0) <= "1000001"; -- U
						hex_2(6 downto 0) <= "0100001"; -- d
						hex_1(6 downto 0) <=	"0000110"; -- E
						hex_0(6 downto 0) <= "1111001"; -- 1
					when c =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "0100001"; -- d
						hex_2(6 downto 0) <= "1000001"; -- U
						hex_1(6 downto 0) <=	"0100001"; -- d
						hex_0(6 downto 0) <= "0100100"; -- 2
					when d =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "0100001"; -- d
						hex_1(6 downto 0) <=	"1000001"; -- U
						hex_0(6 downto 0) <= "0110000"; -- 3
					when e =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <=	"0100001"; -- d
						hex_0(6 downto 0) <= "0011001"; -- 4
					when f =>
						hex_5(6 downto 0) <= "1111111"; -- empty
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <=	"1111111"; -- empty
						hex_0(6 downto 0) <= "0010010"; -- 5
					when g =>
						hex_5(6 downto 0) <= "0010010"; -- S
						hex_4(6 downto 0) <= "1111111"; -- empty
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <=	"1111111"; -- empty
						hex_0(6 downto 0) <= "0000010"; -- 6
					when h =>
						hex_5(6 downto 0) <= "0000110"; -- E
						hex_4(6 downto 0) <= "0010010"; -- S
						hex_3(6 downto 0) <= "1111111"; -- empty
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <=	"1111111"; -- empty
						hex_0(6 downto 0) <= "1111000"; -- 7
					when i =>
						hex_5(6 downto 0) <= "0100001"; -- d
						hex_4(6 downto 0) <= "0000110"; -- E
						hex_3(6 downto 0) <=	"0010010"; -- S
						hex_2(6 downto 0) <= "1111111"; -- empty
						hex_1(6 downto 0) <=	"1111111"; -- empty
						hex_0(6 downto 0) <= "0000000"; -- 8
					when j =>
						hex_5(6 downto 0) <= "1000001"; -- U
						hex_4(6 downto 0) <= "1000010"; -- d
						hex_3(6 downto 0) <=	"0110000"; -- E
						hex_2(6 downto 0) <= "0100100"; -- S
						hex_1(6 downto 0) <=	"1111111"; -- empty
						hex_0(6 downto 0) <= "0010000"; -- 9
					WHEN others =>
						-- back to a
						hex_5(6 downto 0) <= "0100001"; -- d 
						hex_4(6 downto 0) <= "1000001"; -- U
						hex_3(6 downto 0) <= "0100001"; -- d
						hex_2(6 downto 0) <= "0000110"; -- E 
						hex_1(6 downto 0) <= "0010010"; -- S 
						hex_0(6 downto 0) <= "1000000"; -- 0
				END CASE;		
			END IF;
		END PROCESS;
END ARCHITECTURE logic;
		
					
		
		
		
		
		
		
		
		
		
		
		
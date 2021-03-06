	
-- Vending Machine

entity vending_machine is
port (
	ck, vdd, vss, reset, soft_drink, juice, cancel: in  bit;
	piasters   : in  bit_vector(1 downto 0); -- "01" for 0.25LE, "10" for 0.5LE, and "11" for 1.0LE
 	drink      : out bit_vector(1 downto 0); -- "00" for Nothing,   "01" for Soft Drink, and "10" for Juice 
 	change25, change50, change100: out bit   
	);
end vending_machine;

architecture MEALY_FSM of vending_machine is 

	-- Enumerated Type for states
	type STATE_TYPE is (S0, S25, S50, S75, S100); 
	-- Signal declaration
	signal CS, NS: STATE_TYPE;
	
	--pragma CURRENT_STATE CS
	--pragma NEXT_STATE    NS
	--pragma CLOCK         ck
	
begin
	
	-- Process (1): State Functions
	process(CS, piasters, soft_drink, juice, reset, cancel) begin

		-- Next state Transition function = f(inputs, CS)
		if (reset='1') then NS <=S0;
		else
			case CS is
				when S0 =>
					if    piasters = "01" then
						NS <= S25; 
					elsif piasters = "10" then
						NS <= S50;
					elsif piasters = "11" then 
						NS <= S100;
					else	
						NS <= S0;
					end if;
					
				when S25 =>
					if piasters = "01" then  
						NS <= S50;
					elsif piasters = "10" then 
						NS <= S75;
					else
						if(soft_drink = '1' or juice = '1' or cancel = '1') then 
							NS <= S0;
					   	else
							NS <= S25;
					   	end if;
					end if;	
				
				when S50 =>
					if    piasters = "01" then
						NS <= S75; 
					elsif piasters = "10" then 
						NS <= S100;
					else
						if (soft_drink = '1' or juice = '1' or cancel = '1') then 
							NS <= S0;
					   	else
							NS <= S50;
					   	end if;
					end if;
					
				when S75 =>
					if    piasters = "01" then 
						NS <= S100;
					else
						if  (soft_drink = '1' or juice = '1' or cancel = '1') then 
							NS <= S0;
					   	else
							NS <= S75;
					   	end if;	
					end if;
					
				when S100 =>
					if piasters = "11" then 
						if  (soft_drink = '1' or juice = '1') then 
							NS <= S0;
						elsif cancel = '1' then
						  	NS <= S25;
					   	else
							NS <= S100;
					  	 end if;
						
					else    
						if  (soft_drink = '1' or juice = '1' or cancel = '1') then 
							NS <= S0;
					  	else
							NS <= S100;
					   	end if;
					end if;
					
				when others =>  
					NS <= S0;
			end case;
		end if;
		
		-- output generation function =f(states, input)
		case CS is
			when S25 =>
			
				change50 <= '0';
				
				if piasters = "00" and cancel = '1' then
					drink <= "00";
					change25  <= '1';
					change100 <= '0';
					
				elsif piasters = "11" then
					drink <= (soft_drink & juice);
					if (soft_drink & juice) = "00" and cancel = '1' then
						change25  <= '1';
						change100 <= '1';
					else 
						change25  <= '0';
						change100 <= '0';
					end if;
				else 
					drink <= "00";
					change25  <= '0';
					change100 <= '0';
					
				end if;
					
			when S50 =>
				
				if piasters = "00" and cancel = '1' then
					drink <= "00";
					change25  <= '0';
					change50  <= '1';
					change100 <= '0';

				elsif piasters = "11" then
					drink <= (soft_drink & juice);
					
					if (soft_drink & juice) = "00" then
						if cancel = '1' then
							change25  <= '0';
							change50  <= '1';
							change100 <= '1';
						else
							change25  <= '0';
							change50  <= '0';
							change100 <= '0';
						end if;
					else
						change25  <= '1';
						change50  <= '0';
						change100 <= '0';					
					end if;
				else
					drink <= "00";
					change25  <= '0';
					change50  <= '0';
					change100 <= '0';
				end if;
				
			when S75 =>
				if piasters = "00" and cancel = '1' then
					drink <= "00";
					change25  <= '1';
					change50  <= '1';
					change100 <= '0';
					
				elsif piasters = "10" then
					drink <= (soft_drink & juice);
					if (soft_drink & juice) = "00" and cancel = '1' then
						change25  <= '1';
						change50  <= '0';
						change100 <= '1';		
					else
						change25  <= '0';
						change50  <= '0';
						change100 <= '0';
					end if;
					
				elsif piasters = "11" then
					drink <= (soft_drink & juice);
					if (soft_drink & juice) = "00" and cancel = '1' then
						change25  <= '1';
						change50  <= '1';
						change100 <= '1';		
					else
						change25  <= '0';
						change50  <= '0';
						change100 <= '0';
					end if;
					
				else
					drink <= "00";
					change25  <= '0';
					change50  <= '0';
					change100 <= '0';
				end if;
				
			when S100 =>
				if piasters = "00" and cancel = '1' then
					drink <= "00";
					change25  <= '0';
					change50  <= '0';
					change100 <= '1';
				
				elsif piasters = "01" then
					drink <= (soft_drink & juice);
					if (soft_drink & juice) = "00" and cancel = '1' then
						change25  <= '0';
						change50  <= '0';
						change100 <= '1';
					else
						change25  <= '0';
						change50  <= '0';
						change100 <= '0';
					end if;
					
				elsif piasters = "10" then
					drink <= (soft_drink & juice);
					
					if (soft_drink & juice) = "00" then
					
						if cancel = '1' then
							change25  <= '0';
							change50  <= '1';
							change100 <= '1';
						else
							change25  <= '0';
							change50  <= '0';
							change100 <= '0';
						end if;
					else
						change25  <= '0';
						change50  <= '0';
						change100 <= '0';
					end if;
				
				elsif piasters = "11" then
					drink <= (soft_drink & juice);
					
					if (soft_drink & juice) = "00" then
					
						if cancel = '1' then
							change25  <= '1';
							change50  <= '1';
							change100 <= '1';
						else
							change25  <= '0';
							change50  <= '0';
							change100 <= '0';
						end if;
					else
						change25  <= '1';
						change50  <= '1';
						change100 <= '0';
					end if;
					
				else
					drink <= "00";
					change25  <= '0';
					change50  <= '0';
					change100 <= '0';
				end if;
					
			when others =>
				drink <= "00";
				change25  <= '0';
				change50  <= '0';
				change100 <= '0';
		end case;
		
	end process;
	
	-- Process (2): State Update (sequential)
	process(ck) begin
		if (ck='1' and not ck'stable) then CS <= NS;
		end if;
	end process;
	
end MEALY_FSM;

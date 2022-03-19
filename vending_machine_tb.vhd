LIBRARY sxlib_ModelSim;

-- Entity declaration 
ENTITY vending_machine_tb IS
END ENTITY vending_machine_tb;

ARCHITECTURE test OF vending_machine_tb IS

-- Component Declaration for the Device Under Test (DUT)
COMPONENT vending_machine IS 
port (
	ck, vdd, vss, reset, soft_drink, juice, cancel : in  bit;
	piasters   : in  bit_vector(1 downto 0); -- "01" for 0.25LE, "10" for 0.5LE, and "11" for 1.0LE
 	drink      : out bit_vector(1 downto 0); -- "00" for Nothing,   "01" for Soft Drink, and "10" for Juice 
 	change25, change50, change100: out bit   
	);
END COMPONENT vending_machine;

COMPONENT vending_machinea_ln IS 
port (
	ck, vdd, vss, reset, soft_drink, juice, cancel : in  bit;
	piasters   : in  bit_vector(1 downto 0); -- "01" for 0.25LE, "10" for 0.5LE, and "11" for 1.0LE
 	drink      : out bit_vector(1 downto 0); -- "00" for Nothing,   "01" for Soft Drink, and "10" for Juice 
 	change25, change50, change100: out bit   
	);
END COMPONENT vending_machinea_ln;

COMPONENT vending_machinea_s IS 
port (
	ck, vdd, vss, reset, soft_drink, juice, cancel: in  bit;
	piasters   : in  bit_vector(1 downto 0); -- "01" for 0.25LE, "10" for 0.5LE, and "11" for 1.0LE
 	drink      : out bit_vector(1 downto 0); -- "00" for Nothing,   "01" for Soft Drink, and "10" for Juice 
 	change25, change50, change100: out bit;
        scanin, test                 : in  bit;
        scanout                      : out bit
	);
END COMPONENT vending_machinea_s;

FOR beh:    vending_machine     USE ENTITY WORK.vending_machine     (MEALY_FSM);
FOR struct: vending_machinea_ln USE ENTITY WORK.vending_machinea_ln (structural);
FOR dft:    vending_machinea_s  USE ENTITY WORK.vending_machinea_s  (structural);

-- Declare input signals and initialize them 
SIGNAL clock      : bit := '0';
SIGNAL vdd        : bit := '1';
SIGNAL vss        : bit := '0'; 
SIGNAL reset      : bit := '0';
SIGNAL soft_drink : bit := '0'; 
SIGNAL juice      : bit := '0';
SIGNAL cancel	  : bit := '0';
SIGNAL piasters   : bit_vector(1 downto 0) := "00"; 
SIGNAL scanin     : bit := '0';
SIGNAL test	  : bit := '0';

-- Declare output signals and initialize them
SIGNAL change25_b  : bit := '0'; 
SIGNAL change25_s  : bit := '0';
SIGNAL change25_d  : bit := '0';
SIGNAL change50_b  : bit := '0'; 
SIGNAL change50_s  : bit := '0';
SIGNAL change50_d  : bit := '0';
SIGNAL change100_b : bit := '0'; 
SIGNAL change100_s : bit := '0';
SIGNAL change100_d : bit := '0';
SIGNAL drink_b     : bit_vector(1 downto 0) := "00";
SIGNAL drink_s     : bit_vector(1 downto 0) := "00";
SIGNAL drink_d     : bit_vector(1 downto 0) := "00";
SIGNAL scanout     : bit := '0';

-- Constants 
constant clk_period : time := 100 ns;
constant sequence   : bit_vector := "0101101110111101111101111011";

BEGIN

-- Instantiate the Device Under Test (DUT)
beh:    vending_machine     PORT MAP (clock, vdd, vss, reset, soft_drink, juice, cancel, piasters, drink_b, change25_b, change50_b, change100_b);
struct: vending_machinea_ln PORT MAP (clock, vdd, vss, reset, soft_drink, juice, cancel, piasters, drink_s, change25_s, change50_s, change100_s);
dft:    vending_machinea_s  PORT MAP (clock, vdd, vss, reset, soft_drink, juice, cancel, piasters, drink_d, change25_d, change50_d, change100_d, scanin, test, scanout);

-- Clock process definitions( clock with 50% duty cycle )
   clk_process :process
   begin
        clock <= '1'; 
        wait for clk_period/2;  
        clock <= '0'; 
        wait for clk_period/2;  
   end process;

stim_proc: PROCESS IS

	PROCEDURE check_add(constant in1 : in bit;
		            constant in2 : in bit;
			    constant in3 : in bit;
			    constant in4 : in bit_vector(1 downto 0);
			    constant in5 : in bit
			    ) is
	BEGIN
		-- Assign values to circuit.
		reset      <= in1;
		soft_drink <= in2;
		juice      <= in3;
		piasters   <= in4;
		cancel     <= in5;
		test       <= '1' after 8*clk_period;
		
		-- Wait for some time for the simulator to "propagate" their values.
		wait for clk_period;
		
		-- Check output against expected result 
		Assert change25_b  = change25_s  Report "Structural and Behavioral outputs don't match" Severity Error;
		Assert change50_b  = change50_s  Report "Structural and Behavioral outputs don't match" Severity Error;
		Assert change100_b = change100_s Report "Structural and Behavioral outputs don't match" Severity Error;
		Assert drink_b     = drink_s     Report "Structural and Behavioral outputs don't match" Severity Error;

	END procedure check_add;

 BEGIN
	 

	Report "Some Random testing of inputs";
	check_add('0','1','0',"11",'0');
	check_add('0','1','0',"01",'0');
	check_add('0','0','1',"10",'0');
	check_add('0','0','1',"11",'0');
	check_add('1','1','0',"01",'0');
	check_add('0','0','0',"11",'0');
	check_add('0','0','0',"11",'1');
	check_add('0','0','0',"00",'1');
	Report "End Random testing";

	for i In 0 to sequence'length-1 loop
		scanin <= sequence(i); -- Assign values to circuit inputs.
		wait for clk_period; -- Wait to "propagate" values
		-- Check output against expected result.
		if i = 3 then -- 3 registers in the scan chain
			Assert scanout = sequence(i) Report "scanout does not follow scan in" Severity error;
		end if;
	end loop;

	WAIT; -- don't repeat above test vectors
 END PROCESS stim_proc;
END ARCHITECTURE test;

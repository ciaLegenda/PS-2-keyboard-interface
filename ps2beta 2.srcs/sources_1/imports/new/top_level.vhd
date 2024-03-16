--The big source MODIFIED--
-- Company: 
-- Engineer: adelinutz

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TheBigSource is
    Port ( 
           Serial_input : in STD_LOGIC;
           Clk_int : in STD_LOGIC;
           Clk_ps2 : in STD_LOGIC;
           reset    :in STD_LOGIC;
           an0 : out STD_LOGIC;
           an1 : out STD_LOGIC;
           an2 : out STD_LOGIC;
           an3 : out STD_LOGIC;
           an4 : out STD_LOGIC;
           an5 : out STD_LOGIC;
           an6 : out STD_LOGIC;
           an7 : out STD_LOGIC;
           ca : out STD_LOGIC_VECTOR (7 downto 0);
          --outs for debugging 
          state : out STD_LOGIC_vector(3 downto 0)
     );
end TheBigSource;

architecture Behavioral of TheBigSource is
component clk_sync IS
  PORT (
  sys_clk : IN std_logic;
  ps2_clk : IN	std_logic;

  synced  : OUT std_logic
  );
END component clk_sync;
component counter3bit IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    clock      : IN  std_logic;                    -- input bit example
    enable      : IN std_logic;
  ------------------------------------------------------------------------------
  --Insert output ports below
  	value	   : OUT std_logic_vector (2 downto 0)
    );
END component counter3bit;

component counter16bit IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    clock      : IN  std_logic;                    -- input bit example
  ------------------------------------------------------------------------------
  --Insert output ports below
    tCount        : OUT std_logic                    -- output bit example
    );
END component counter16bit;
component shift_register_11bit IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    clk      : IN  std_logic; --clk signal, synchronized to the ps2 clock               
    sin      : IN  std_logic; --serial input
    reset	   : IN 	std_logic;
  ------------------------------------------------------------------------------
  --Insert output ports below
    q	   :	OUT std_logic_vector(10 downto 0); --output of the register
    q8	   : OUT std_logic_vector(8 downto 1)
    );
END component shift_register_11bit;
component CU_Outputs IS
  PORT (
    state 	: IN std_logic_vector(3 downto 0);
	en_shift 	: OUT std_logic;
	clear	: OUT std_logic;
	delayReset : OUT std_logic;
	RESET : OUT STD_LOGIC
  );
END component CU_Outputs;
component CU_ROM IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    address        : IN  std_logic_vector(4 DOWNTO 0); -- input vector example
  ------------------------------------------------------------------------------
  --Insert output ports below
    content        : OUT std_logic_vector(3 DOWNTO 0)  -- output vector example
    );
END component CU_ROM;
component decoder7sd IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    address      : IN  std_logic_vector (7 downto 0);                    -- input bit example
  ------------------------------------------------------------------------------
  --Insert output ports below
    content        : OUT std_logic_vector (7 DOWNTO 0)  -- output vector example
    );
END component decoder7sd;

component display_buffer IS
  PORT (
    data_in	: IN std_logic_vector(7 downto 0);
    enable	: IN std_logic;
    clk		: IN std_logic;
    reset		: IN std_logic;

    data_out0	: OUT std_logic_vector(7 downto 0);
    data_out1	: OUT std_logic_vector(7 downto 0);
    data_out2	: OUT std_logic_vector(7 downto 0);
    data_out3	: OUT std_logic_vector(7 downto 0);
    data_out4	: OUT std_logic_vector(7 downto 0);
    data_out5	: OUT std_logic_vector(7 downto 0);
    data_out6	: OUT std_logic_vector(7 downto 0);
    data_out7	: OUT std_logic_vector(7 downto 0)
    );
END component display_buffer;
component dmux8to1 IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    val        : IN  std_logic;
    sel		: IN  std_logic_vector(2 downto 0);
  ------------------------------------------------------------------------------
  --Insert output ports below
    y0		: OUT std_logic;
    y1		: OUT std_logic;
    y2		: OUT std_logic;
    y3		: OUT std_logic;
    y4		: OUT std_logic;
    y5		: OUT std_logic;
    y6		: OUT std_logic;
    y7		: OUT std_logic
    );
END component dmux8to1;

component enter_verif_unit IS
  PORT (
  c		: IN std_logic_vector(10 downto 0);--code read from the keyboard
  valid 	: OUT std_logic
   );
END component enter_verif_unit;
component modulo11_counter IS
  PORT (
    clk	: IN  std_logic;--clock signal
    reset : IN std_logic;
    tc	: OUT std_logic--terminal count
    );
END component modulo11_counter;
component MUX8TO1WHICHIS1BIT IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    val        : IN  std_logic_vector(7 DOWNTO 0); -- input vector example
    sel 		: IN  std_logic_vector(2 downto 0); -- selection bit
  ------------------------------------------------------------------------------
  --Insert output ports below
    output        : OUT std_logic                -- output bit example
    );
END component MUX8TO1WHICHIS1BIT;
component validation_unit IS
  PORT (
  c		: IN std_logic_vector(10 downto 0);--code read from the keyboard
  valid 	: OUT std_logic
   );
END component validation_unit;
component mux8to1_8bit IS
  PORT (
  	in0	: IN std_logic_vector(7 downto 0);
  	in1	: IN std_logic_vector(7 downto 0);
  	in2	: IN std_logic_vector(7 downto 0);
  	in3	: IN std_logic_vector(7 downto 0);
  	in4	: IN std_logic_vector(7 downto 0);
  	in5	: IN std_logic_vector(7 downto 0);
  	in6	: IN std_logic_vector(7 downto 0);
  	in7	: IN std_logic_vector(7 downto 0);
  	sel  : IN std_logic_vector(2 downto 0);

	y	: OUT std_logic_vector(7 downto 0)
    );
END component mux8to1_8bit;
component eo_verif_unit IS
  PORT (
  c		: IN std_logic_vector(10 downto 0);--code read from the keyboard
  valid 	: OUT std_logic
   );
END component eo_verif_unit;
component fo_verif_unit IS
  PORT (
  c		: IN std_logic_vector(10 downto 0);--code read from the keyboard
  valid 	: OUT std_logic
   );
END component fo_verif_unit;
component RegisterForCU is
    Port ( 
           clock: std_logic;
           DataIN : in STD_LOGIC_VECTOR (3 downto 0);
           DataOUT : out STD_LOGIC_VECTOR (3 downto 0));
end component RegisterForCU;
component counterDelay is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           tcDelay : out STD_LOGIC);
end component counterDelay;
signal tCount, en_shift,clear, outMUX8TO1WHICHIS1BIT,tc, sync_clk, valid_validationUnit, valid_eo_verification, valid_fo_verification,valid_enter: std_logic;
signal shiftreg_output_11bits: std_logic_vector(10 downto 0);
signal shiftreg_output_8bits: std_logic_vector(8 downto 1);
signal mux8TO1WHICHIS1BIT_values, outputDecoder,p7,p6,p5,p4,p3,p2,p1,p0: std_logic_vector(7 downto 0);
signal counter3bitsValue: std_logic_vector(2 downto 0);
signal c, q: std_logic_vector (3 downto 0);
signal address: std_logic_vector(4 downto 0);
signal constant_0: std_logic;
signal resetSerialAccordingToCU: std_logic;
signal resetSerial: std_logic;
signal resetCounterDelay,tcDelay : std_logic;
begin
--addressFromDflipflops <= outMUX8TO1WHICHIS1BIT & q(2) & q(1) & q(0);
--bitsFromDecoder <= outputDecoder;
--outputfromserial <= shiftreg_output_11bits;
synchroniser: clk_sync port map(sys_clk => Clk_int, ps2_clk => Clk_ps2, synced => sync_clk);
resetSerial <= reset or resetSerialAccordingToCU;
serialReader: shift_register_11bit port map(clk => sync_clk, sin => Serial_input, reset => resetSerial, q => shiftreg_output_11bits, q8 => shiftreg_output_8bits);
validationUnit: validation_unit port map(c => shiftreg_output_11bits, valid => valid_validationUnit);
e0_verification: eo_verif_unit port map(c => shiftreg_output_11bits, valid => valid_eo_verification);
f0_verification: fo_verif_unit port map(c => shiftreg_output_11bits, valid => valid_fo_verification);
--itIsValid <= valid_validationUnit;
enter_verification: enter_verif_unit port map(c => shiftreg_output_11bits, valid => valid_enter);
delay_for_another_key: counterDelay port map(clk => Clk_int,reset => resetCounterDelay,tcDelay => tcDelay);
CU_counter: modulo11_counter port map(clk => sync_clk, reset => resetSerial,tc => tc);
address <= outMUX8TO1WHICHIS1BIT & q(3) &q(2) & q(1) & q(0);
CU_MEMORY: CU_ROM port map(address => address, content => c);
CU_REGISTER: RegisterForCU port map(clock => Clk_int, DataIN => c, DataOUT => q);
mux8TO1WHICHIS1BIT_values <= tc & valid_enter & sync_clk & valid_fo_verification & sync_clk & (valid_validationUnit and (not valid_eo_verification)) & tc & sync_clk;
--mux8TO1WHICHIS1BIT_values <= sync_clk & tc & (valid_validationUnit and (not valid_eo_verification)) & sync_clk & valid_fo_verification & sync_clk & valid_enter & tc_clk;

CU_MUX: MUX8TO1WHICHIS1BIT port map(val => mux8TO1WHICHIS1BIT_values, sel => q(2 downto 0), output => outMUX8TO1WHICHIS1BIT);
MEMORY_FOR_DECODER: decoder7sd port map(address => shiftreg_output_8bits, content => outputDecoder);
OutputsOfMemory : CU_Outputs port map(state => q, en_shift => en_shift, clear => clear, delayReset => resetCounterDelay ,reset => resetSerialAccordingToCU);
displayingBUFFER: display_buffer port map(data_in => outputDecoder, enable => en_shift,clk => Clk_int, reset => clear,data_out0 => p7,data_out1 => p6,data_out2 => p5,data_out3 => p4,data_out4 => p3 ,data_out5 =>p2 ,data_out6 =>p1 ,data_out7 => p0);
FrequencyDivider: counter16bit port map(clock => Clk_int, tCount => tCount);
counterOn3bits: counter3bit port map(clock => Clk_int, enable => tCount, value => counter3bitsValue);
Mux8to1bitWhichIs8bits: mux8to1_8bit port map(in0=> p0,in1 => p1,in2 => p2, in3 =>p3, in4 =>p4 ,in5 => p5 ,in6 => p6, in7 => p7,sel=> counter3bitsValue, y => ca);
constant_0 <= '0';
Dmux8to1bitWhichis1bit: dmux8to1 port map(val => constant_0,sel => counter3bitsValue,y0 => an0, y1 => an1, y2 => an2, y3 => an3, y4 => an4, y5 => an5, y6 => an6, y7 => an7);

--for debugging on the board
state<=q;
end Behavioral;
------------------
--CU MEMORY MODIFIED--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CU_ROM IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    address        : IN  std_logic_vector(4 DOWNTO 0); -- input vector example
  ------------------------------------------------------------------------------
  --Insert output ports below
    content        : OUT std_logic_vector(3 DOWNTO 0)  -- output vector example
    );
END CU_ROM;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF CU_ROM IS

BEGIN
        -- 0000 is the idle state
        -- 0001 is the reading state
        -- 0010 is the valid and not e0 state
        -- 0011 is the wait2 state
        -- 0100 is the f0 state
        -- 0101 is the wait1 state
        -- 0110 is the isEnter state
        -- 0111 is the readAndIgnore state
        -- 1000 is the printing state
        -- 1001 is the clear7SD state
        -- 1010 is the wait2 begin 
        --      choosen this way because it doesn t need an input to make a decision
        -- the MSB is given by the MUX8TO1WHICHIS1BIT
        
	process (address)
		begin
		case address is
		when "00000" => content <= "0001";--idle state
		when "10000" => content <= "0000";
		when "00001" => content <= "0001";--read from ps2
		when "10001" => content <= "0010";
		when "00010" => content <= "1010";--verif if valid and not e0
		when "10010" => content <= "0100";
		when "00011" => content <= "0011";--wait2 state
		when "10011" => content <= "0000";
		when "00100" => content <= "0110";--verif F0
		when "10100" => content <= "0101";
		when "00101" => content <= "0101";--wait1 state
		when "10101" => content <= "0111";
		when "00110" => content <= "1000";--is enter state
		when "10110" => content <= "1001";
		when "00111" => content <= "0111";--read and ignore
		---when "10111" => content <= "0011";
		--when "00111" => content <= "0111";
		when "10111" => content <= "1010";
		when "01000" => content <= "1010";--
		when "11000" => content <= "1010";
		when "01001" => content <= "1010";
		when "11001" => content <= "1010";
		when "01010" => content <= "0011";--begin wait2
		when "11010" => content <= "0011";
		when others => content <= "0000";

		end case;
	end process;
END TypeArchitecture;

--CU_OUTPUTS MODIFIED--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CU_Outputs IS
  PORT (
	state 	: IN std_logic_vector(3 downto 0);
	en_shift 	: OUT std_logic;
	clear	: OUT std_logic;
	delayReset : OUT std_logic;
	RESET : OUT STD_LOGIC
  );
END CU_Outputs;

ARCHITECTURE TypeArchitecture OF CU_Outputs IS

BEGIN


process(state) is
begin
    if state = "0011" OR state = "1010" then
        reset <= '1';
    elsif state = "0101" then
        reset <= '1';
    else
        reset <= '0';
    end if;
	if state = "1000" then 
		en_shift <= '1';
	else 
		en_shift <= '0';
	end if;
	if state = "1001" then
		clear <= '1';
	else 
		clear <= '0';
	end if;
	if state = "1010" then
	   delayReset <= '1';
	else 
	   delayReset <= '0';
	end if;
end process;
END TypeArchitecture;



--- CU REGISTER ADDED AND DELETED FLIP FLOPS --- 
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2023 08:22:52 PM
-- Design Name: 
-- Module Name: RegisterForCU - cuRegister
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterForCU is
    Port ( 
            clock: std_logic;
            DataIN : in STD_LOGIC_VECTOR (3 downto 0);
           DataOUT : out STD_LOGIC_VECTOR (3 downto 0));
end RegisterForCU;

architecture cuRegister of RegisterForCU is

begin
	process(clock) is
	variable internal_state : std_logic_vector(3 downto 0) := "0000";
	begin
		if(rising_edge(clock)) then
			internal_state := DataIN;
		end if;
		DataOUT <= internal_state;
	end process;

end cuRegister;
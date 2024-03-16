library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counterDelay is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           tcDelay : out STD_LOGIC);
end counterDelay;

architecture Behavioral of counterDelay is

begin

process(clk) is 
constant delay : natural := 2*(10**7);--tenths of second
variable i:natural range 0 to delay:=0;
begin
if(clk'event AND clk='0') then 
    if(reset = '1') then
        i := 0;
    elsif i<delay then
        i := i+1;
        tcDelay <= '0';
     else
        i := 0;
        tcDelay <= '1';
     end if;
end if;

end process;

end Behavioral;
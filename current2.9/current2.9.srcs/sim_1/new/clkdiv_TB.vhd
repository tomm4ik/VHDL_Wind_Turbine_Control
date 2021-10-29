library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkdiv_TB is
end clkdiv_TB;

architecture Behavioral of clkdiv_TB is

-- component declaration for the unit under test (uut)
component clkdiv is
Port ( clkin      : in  STD_LOGIC;  -- master clock
       reset      : in  STD_LOGIC;
       clkout     : out  STD_LOGIC); -- 4 Mhz output clock
end component;

signal clkin      : STD_LOGIC := '0';
signal reset      : STD_LOGIC := '0';
signal clkout     : STD_LOGIC := '0';
constant CLK_PERIOD      : time := 10 ns;   -- frequency 100 MHz

begin

uut: clkdiv PORT MAP (clkin, reset, clkout);

clk_process : process
begin
     clkin <= '0';
     wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
     clkin <= '1';
     wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

--stim: PROCESS
--begin
--    in_bcd <= "0000100101010000"; -- 950
--    wait for clk_period*10;
--	in_bcd <= "0001000000000000"; -- 1000
--	wait;
--end process;

end Behavioral;

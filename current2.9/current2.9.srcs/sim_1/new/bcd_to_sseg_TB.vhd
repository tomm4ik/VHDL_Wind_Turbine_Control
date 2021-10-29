library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity bcd_to_sseg_TB is
end bcd_to_sseg_TB;

architecture Behavioral of bcd_to_sseg_TB is

-- component declaration for the unit under test (uut)
component bcd_to_sseg is
Port ( clk      : in  STD_LOGIC;                     -- master clockend component
       in_bcd   : in  STD_LOGIC_VECTOR (15 downto 0); -- 16-bit input bcd nuber
       ansel    : out  STD_LOGIC_VECTOR (3 downto 0); -- 4-bit common-anode output
       dout     : out  STD_LOGIC_VECTOR (6 downto 0)); -- 7-bit 7 segment signals
end component;

--declare signals and initialize them to zero.
signal clk               : std_logic := '0';
signal in_bcd            : std_logic_vector(15 downto 0);
signal ansel             : std_logic_vector(3 downto 0);
signal dout              : std_logic_vector(6 downto 0);
constant CLK_PERIOD      : time := 500 ns;   -- frequency 2 MHz

begin

uut: bcd_to_sseg PORT MAP (clk, in_bcd, ansel, dout);

clk_process : process
begin
     clk <= '0';
     wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
     clk <= '1';
     wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

stim: PROCESS
begin
    in_bcd <= "0000100101010000"; -- 950
    wait for clk_period*10;
	in_bcd <= "0001000000000000"; -- 1000
	wait;
end process;

end Behavioral;
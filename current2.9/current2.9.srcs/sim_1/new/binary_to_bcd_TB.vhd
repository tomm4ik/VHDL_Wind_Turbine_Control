library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity binary_to_bcd_TB is
end binary_to_bcd_TB;

architecture Behavioral of binary_to_bcd_TB is

-- component declaration for the unit under test (uut)
component binary_to_bcd is
generic(digits : integer := 4; -- number of BCD digits to convert to
          bits   : integer := 12);	-- size of binary number in bits
Port (clk : in std_logic;
        reset : in std_logic;
        binary : in std_logic_vector(bits-1 downto 0);
        bcd : out std_logic_vector(digits*4-1 downto 0) );
end component;

--declare signals and initialize them to zero.
signal clk               : std_logic := '0';
signal reset             : std_logic;
signal binary            : std_logic_vector(11 downto 0);
signal bcd               : std_logic_vector(15 downto 0);
constant CLK_PERIOD      : time := 500 ns;   -- frequency 2 MHz

begin

uut: binary_to_bcd PORT MAP (clk, reset, binary, bcd);

-- Clock process definitions( clock with 50% duty cycle is generated here.
clk_process : process
begin
     clk <= '0';
     wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
     clk <= '1';
     wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

stim: PROCESS
begin
    binary <= "001110110110"; -- 950
    wait for clk_period;
	reset <= '1';
	wait for clk_period*1;
	reset <= '0';
--	wait for clk_period*10;
--	binary <= "001111101000"; -- 1000
--	wait for clk_period*10;
--	reset <= '1';
	
	wait;
end process;
end Behavioral;

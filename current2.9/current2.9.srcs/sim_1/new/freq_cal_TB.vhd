library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity freq_cal_TB is
end freq_cal_TB;

architecture Behavioral of freq_cal_TB is

-- component declaration for the unit under test (uut)
component frequency_calculator is
port (num_of_cliks : in STD_LOGIC_VECTOR (20 downto 0);
      frequency    : out STD_LOGIC_VECTOR (11 downto 0);
      clk          : in std_logic
     );
end component;

--declare signals and initialize them to zero.
signal clk               : std_logic := '0';
signal frequency         : STD_LOGIC_VECTOR (11 downto 0);
constant CLK_PERIOD      : time := 500 ns;   -- frequency 2 MHz
--constant CLK_PERIOD      : time := 250 ns;   -- frequency 4 MHz
constant cliks           : unsigned(20 downto 0) := to_unsigned(2104,21); -- (2104 = 950 Hz)
signal num_of_cliks      : STD_LOGIC_VECTOR(20 downto 0);  -- 2MHz

begin

num_of_cliks <= std_logic_vector(cliks);

-- Clock process definitions( clock with 50% duty cycle is generated here.
clk_process : process
begin
     clk <= '0';
     wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
     clk <= '1';
     wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

-- instantiate the unit under test (uut)
uut : frequency_calculator port map (num_of_cliks => num_of_cliks,
                                        clk => clk,
--                                      reset => reset,
                                        frequency => frequency);

end Behavioral;

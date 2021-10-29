
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity frequency_calculator is
    Port ( 
           num_of_cliks : in STD_LOGIC_VECTOR (26 downto 0);
           clk          : in std_logic;
           frequency    : out STD_LOGIC_VECTOR (11 downto 0));
end frequency_calculator;

architecture Behavioral of frequency_calculator is

--constant const_val : std_logic_vector(20 downto 0) := "111101000010010000000";  -- 2MHz (2000000)
--constant const_val : std_logic_vector(26 downto 0) := "1111010000100100000000";  -- 4MHz (4000000)
constant const_val : std_logic_vector(26 downto 0) := "101111101011110000100000000";  -- 100MHz
signal frequency_shrinker : std_logic_vector(26 downto 0);

begin
    process (clk)
    begin
        if rising_edge(clk) then
          if (unsigned(num_of_cliks) > 0) then
          frequency_shrinker <= STD_LOGIC_VECTOR(unsigned(const_val)/unsigned(num_of_cliks));
          frequency <= frequency_shrinker(11 downto 0);
          else frequency <= (others => '0');
          end if;
        end if;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_TB is
end Top_TB;

architecture Behavioral of Top_TB is

component Top is
    Port ( SUT  : in std_logic;
           an : out  STD_LOGIC_VECTOR (3 downto 0); -- common anodes for each digit (7-seg)
           seg : out  STD_LOGIC_VECTOR (6 downto 0); -- 7-segment data
           clk : in  STD_LOGIC;				-- master board clock (100 MHz)
           rst : in std_logic
			  );
end component;

signal SUT  : std_logic;
signal an   : STD_LOGIC_VECTOR (3 downto 0); -- common anodes for each digit (7-seg)
signal seg  : STD_LOGIC_VECTOR (6 downto 0); -- 7-segment data
signal clk  : STD_LOGIC;				-- master board clock (100 MHz)
signal rst  : STD_LOGIC;				-- master board clock (100 MHz)

constant CLK_PERIOD : time := 10 ns;   -- frequency 100 MHz
--constant SUT_PERIOD : time := 497760 ns;   -- frequency 2009 Hz
constant SUT_PERIOD : time := 998004 ns;   -- frequency 1002 Hz
--constant SUT_PERIOD : time := 25 ms;   -- frequency 40 Hz
--constant SUT_PERIOD : time := 810373 ns;   -- frequency 1234 Hz
--constant SUT_PERIOD : time := 1490313 ns;   -- frequency 671 Hz
--constant SUT_PERIOD : time := 2 ms;   -- frequency 500 Hz
--constant SUT_PERIOD : time := 2.1 ms;

begin

 uut : Top port map (SUT, an, seg, clk, rst);

clk_process : process
begin
     clk <= '0';
     wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
     clk <= '1';
     wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
end process;

SUT_process : process
begin
      SUT <= '0';
     wait for SUT_PERIOD/2;  --for half of SUT period SUT stays at '0'.
     SUT <= '1';
     wait for SUT_PERIOD/2;  --for next half of SUT period SUT stays at '1'.
end process;

end Behavioral;

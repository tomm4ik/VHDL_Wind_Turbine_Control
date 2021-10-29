
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_TB is
end counter_TB;

architecture Behavioral of counter_TB is

-- component declaration for the unit under test (uut)
component counter is
port (SUT     : in std_logic; --  Signal Under Test
      clk     : in std_logic;
      reset   : in std_logic;
      count   : out std_logic_vector (21 downto 0)
     );
end component;

--declare signals and initialize them to zero.
--inputs
signal SUT      : std_logic := '0';
signal clk      : std_logic := '0';
signal reset    : std_logic := '0';
--outputs
signal count    : std_logic_vector (21 downto 0);

-- define the period of clock here.
constant CLK_PERIOD : time := 250 ns;   -- frequency 4 MHz
--constant SUT_PERIOD : time := 1052 us;   -- frequency 950 Hz
constant SUT_PERIOD : time := 2 ms;   -- frequency 500 Hz

constant RUN_TIME   : time := 2000 ms;

begin

 -- instantiate the unit under test (uut)
 uut : counter port map (SUT => SUT,
                         clk => clk,
                         reset => reset,
                         count => count
                );

-- Clock process definitions( clock with 50% duty cycle is generated here.
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

   -- Stimulus process, Apply inputs here.
--  stim_proc: process
--   begin        
----        wait for CLK_PERIOD*20;         --wait for 10 clock cycles.
----        reset <='1';                    --then apply reset for 2 clock cycles.
----        wait for CLK_PERIOD*2;
----        reset <='0';                    --then pull down reset for 20 clock cycles.
----        wait for CLK_PERIOD*20;
----        wait for RUN_TIME;
----        wait;
--  end process;

end;

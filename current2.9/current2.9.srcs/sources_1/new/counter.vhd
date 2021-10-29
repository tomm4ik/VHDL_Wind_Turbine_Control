
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity counter is
    Port (
            --  INPUT
            SUT     : in std_logic; --  Signal Under Test
            clk     : in std_logic;
            reset   : in std_logic;
            --  OUTPUT
            count : out std_logic_vector (26 downto 0));
end counter;

architecture Behavioral of counter is
    signal t_cnt : std_logic_vector(26 downto 0); -- internal counter signal
    type t_State is (S0, S1, S2);
    signal State : t_State;
    signal timer : integer range 0 to 5000000;
begin
    process (clk, SUT, reset)
    begin
        if rising_edge(clk) then
            timer <= timer + 1;
            if reset = '1' then
                t_cnt <= (others => '0'); -- forced clear
				State <= S0;
            else
                case State is
                    when S0 =>
                        timer <= 0;
                        t_cnt <= (others => '0'); -- clear
						if SUT = '1' then
                        State <= S1;
						end if;
                    when S1 =>
						t_cnt <= t_cnt + 1; -- incr
						if SUT = '0' then
                        State <= S2;
						end if;
						if timer > 4000000 then   -- if stuck
						State <= S0;
						end if;
                    when S2 =>
						if SUT = '1' then
						count <= std_logic_vector(t_cnt);
						t_cnt <= (others => '0');
						State <= S0;
						else
						t_cnt <= t_cnt + 1; -- incr
						end if;
						if timer > 4000000 then   -- if stuck
						State <= S0;
						end if;
                end case;
           end if;
        end if;
    end process;
end Behavioral;

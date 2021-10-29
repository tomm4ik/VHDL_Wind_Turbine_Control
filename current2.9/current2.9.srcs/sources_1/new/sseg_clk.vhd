library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sseg_clk is
    Port ( clkin  : in  STD_LOGIC; -- 100MHz
           clkout : out  STD_LOGIC); -- 1 kHz
end sseg_clk;

architecture Behavioral of sseg_clk is

--signal temporal: STD_LOGIC;
signal counter : integer range 0 to 6259999 :=0;

begin
	frequency_divider: process (clkin) begin
        if rising_edge(clkin) then -- clock edge?
            if (counter = 50000) then -- maximum count reached?
                clkout <= '1'; -- toggle output
                counter <= counter + 1;
            elsif(counter = 100000) then 
				clkout <= '0'; -- toggle output
				counter <= 0; -- reset counter
			else counter <= counter + 1; -- increment counter
            end if;
        end if;
    end process;
    
 --   clkout <= temporal;  -- output assignment

end Behavioral;


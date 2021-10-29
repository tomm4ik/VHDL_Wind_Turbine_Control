library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkdiv is
    Port ( clkin  : in  STD_LOGIC;
           clkout : out  STD_LOGIC);
end clkdiv;

architecture Behavioral of clkdiv is

--signal temporal: STD_LOGIC;
signal counter : integer range 0 to 6259999 :=0;

begin
	frequency_divider: process (clkin) begin
        if rising_edge(clkin) then -- clock edge?
            if (counter = 12) then -- maximum count reached?
                clkout <= '1'; -- toggle output
                counter <= counter + 1;
            elsif(counter = 24) then 
				clkout <= '0'; -- toggle output
				counter <= 0; -- reset counter
			else counter <= counter + 1; -- increment counter
            end if;
        end if;
    end process;
    
 --   clkout <= temporal;  -- output assignment

end Behavioral;


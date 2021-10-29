library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
entity binary_to_bcd is
  generic(digits : integer; -- number of BCD digits to convert to
          bits   : integer);	-- size of binary number in bits
  Port (clk : in std_logic;
        reset : in std_logic;
        binary : in std_logic_vector(bits-1 downto 0);
        bcd : out std_logic_vector(digits*4-1 downto 0) );
end binary_to_bcd;

architecture Behavioral of binary_to_bcd is
type t_State is (uploading, processing, adding, output);
signal State : t_State;
signal binary_reg : std_logic_vector(bits-1 downto 0);
signal bcd_reg : std_logic_vector(digits*4-1 downto 0);
begin

process(clk, reset)
    VARIABLE shift_counter :	integer RANGE 0 TO bits+1 := 0;  --counts the shifts
begin
    if(rising_edge(clk)) then
        if(reset = '1') then
            binary_reg <= (others => '0');
            bcd_reg <= (others => '0');
            bcd <= (others => '0');
            shift_counter := 0;
            State <= uploading;
        end if;
        case State is
            when uploading =>
                binary_reg <= binary; -- buffer filled with input bits
                if(unsigned(binary_reg)> 0) then
                    State <= processing;
                else State <= uploading;
                end if;
            when processing =>
                if(shift_counter < bits-1) then -- (bits-1)
--                    bcd_reg <= std_logic_vector(shift_left(unsigned(bcd_reg),1));    -- shift bcd buffer left
                    bcd_reg <= bcd_reg(digits*4-2 downto 0) & '0';    -- shift bcd buffer left
                    bcd_reg(0) <= binary_reg(bits-1);                 -- MSB(bin) -> LSB(bcd)
                    binary_reg <= binary_reg(bits-2 downto 0) & '0';  -- shift binary buffer left
                    shift_counter := shift_counter + 1;
                    State <= adding;
                else
                    -- one more final shift
                    bcd_reg <= bcd_reg(digits*4-2 downto 0) & '0';    -- shift bcd buffer left
                    bcd_reg(0) <= binary_reg(bits-1);                 -- MSB(bin) -> LSB(bcd)
--                    binary_reg <= binary_reg(bits-2 downto 0) & '0';  -- shift binary buffer left
                    State <= output;
                end if;
                    
            when adding =>
                    if(unsigned(bcd_reg(3 downto 0)) > 4) then -- if first nibble exceeds 4
                        bcd_reg(3 downto 0) <= std_logic_vector(unsigned(bcd_reg(3 downto 0)) + 3);
                    end if;
                    if(unsigned(bcd_reg(7 downto 4)) > 4) then -- if second nibble exceeds 4
                        bcd_reg(7 downto 4) <= std_logic_vector(unsigned(bcd_reg(7 downto 4)) + 3);
                    end if;
                    if(unsigned(bcd_reg(11 downto 8)) > 4) then -- if third nibble exceeds 4
                        bcd_reg(11 downto 8) <= std_logic_vector(unsigned(bcd_reg(11 downto 8)) + 3);
                    end if;
                    if(unsigned(bcd_reg(15 downto 12)) > 4) then -- if fourth nibble exceeds 4
                        bcd_reg(15 downto 12) <= std_logic_vector(unsigned(bcd_reg(15 downto 12)) + 3);
                    end if;
                    State <= processing;
                    
             when output =>
                    bcd <= bcd_reg; -- upload buffer bcd to output bcd
                    binary_reg <= (others => '0');
                    bcd_reg <= (others => '0');
                    shift_counter := 0;
                    State <= uploading;
         end case;
      end if;
end process;

end Behavioral;

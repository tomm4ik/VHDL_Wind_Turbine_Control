library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_to_sseg is
    Port ( in_bcd : in  STD_LOGIC_VECTOR (15 downto 0); -- 16-bit input bcd nuber
           ansel : out  STD_LOGIC_VECTOR (3 downto 0); -- 4-bit common-anode output
           dout : out  STD_LOGIC_VECTOR (6 downto 0); -- 7-bit 7 segment signals
           clk : in  STD_LOGIC); -- master clock
end bcd_to_sseg;

architecture Behavioral of bcd_to_sseg is

component LUT is -- 4-bit binary to 7-segment decoder
 Port (    din : in  STD_LOGIC_VECTOR (3 downto 0);     -- 4-bit binary number
           dout : out  STD_LOGIC_VECTOR (6 downto 0));  -- 7-bit 7 seg hex version
end component;

type state_type is (s0, s1, s2, s3);
signal current_s, next_s: state_type;
signal seg_dat : std_logic_vector (3 downto 0); -- signal to feed LUT lookup table


begin

decoder : LUT port map (seg_dat, dout); -- instanciate LUT lookup table

process(clk) -- state machine
begin
if rising_edge(clk) then
	current_s <= next_s; -- when the clock edge comes, change state
end if;
end process;

process (current_s, in_bcd)
begin
	case current_s is		--When in state(n), do this
		when s0 =>
		ansel <= "1110"; -- for first LUT digit
		seg_dat <= in_bcd(3 downto 0); -- set seg dat to least significant nibble
		next_s <= s1; -- change to next digit
		
		when s1 =>
		ansel <= "1101"; -- for second LUT digit
		seg_dat <= in_bcd(7 downto 4);
		next_s <= s2;
		
		when s2 =>
		ansel <= "1011"; -- for third LUT digit
		seg_dat <= in_bcd(11 downto 8);
		next_s <= s3;
		
		when s3 =>
		ansel <= "0111"; -- for fourth LUT digit
		seg_dat <= in_bcd(15 downto 12);
		next_s <= s0;
		
	end case;
end process;

end Behavioral;

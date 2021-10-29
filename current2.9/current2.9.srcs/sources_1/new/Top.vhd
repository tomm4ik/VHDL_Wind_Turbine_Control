library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top is
    Port ( SUT  : in std_logic; --  Signal Under Test
           an : out  STD_LOGIC_VECTOR (3 downto 0); -- common anodes for each digit (7-seg)
           seg : out  STD_LOGIC_VECTOR (6 downto 0); -- 7-segment data
           clk : in  STD_LOGIC;				-- master board clock (100 MHz)
           rst : in STD_LOGIC -- reset
			  );
end Top;

architecture Behavioral of Top is

component clkdiv is	
	 Port ( clkin : in STD_LOGIC;
	        clkout: out STD_LOGIC
			  );
end component;

component sseg_clk is	
	 Port ( clkin : in STD_LOGIC;
	        clkout: out STD_LOGIC
			  );
end component;

component counter is
    Port (
            --  INPUT
            SUT     : in std_logic; --  Signal Under Test
            clk     : in std_logic;
            reset   : in std_logic;
            count : out std_logic_vector (26 downto 0));
end component;

component frequency_calculator is
    Port ( 
           num_of_cliks : in STD_LOGIC_VECTOR (26 downto 0);
           clk          : in std_logic;
           frequency    : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component binary_to_bcd is
  generic(digits : integer := 4; -- number of BCD digits to convert to
          bits   : integer := 12);	-- size of binary number in bits
  Port (clk : in std_logic;
        reset : in std_logic;
        binary : in std_logic_vector(bits-1 downto 0);
        bcd : out std_logic_vector(digits*4-1 downto 0) );
end component;

component bcd_to_sseg is
    Port ( in_bcd : in  STD_LOGIC_VECTOR (15 downto 0); -- 16-bit input bcd nuber
           ansel : out  STD_LOGIC_VECTOR (3 downto 0); -- 4-bit common-anode output
           dout : out  STD_LOGIC_VECTOR (6 downto 0); -- 7-bit 7 segment signals
           clk : in  STD_LOGIC); -- master clock
end component;

signal slow_clk : std_logic; -- 4 MHz
signal super_slow_clk : std_logic; -- 1 Hz
signal count    : std_logic_vector (26 downto 0); -- sum of all clicks
signal frequency: std_logic_vector (11 downto 0);
signal bcd      : std_logic_vector (15 downto 0);
--signal reset    : std_logic := '0';

begin

devider: clkdiv port map (clkin     => clk,
                          clkout    => slow_clk);

sseg_devider: sseg_clk port map (clkin     => clk,
                                 clkout    => super_slow_clk);

                          
clicks_counter: counter port map (SUT      => SUT,
                                  reset    => rst,
                                  clk      => clk,
                                  count    => count);

calculator: frequency_calculator port map (num_of_cliks => count,
                                           clk          => super_slow_clk,
                                           frequency    => frequency);

to_bcd: binary_to_bcd port map (clk     => clk,
                                reset   => rst,
                                binary  => frequency,
                                bcd     => bcd);

to_sseg: bcd_to_sseg port map (in_bcd   => bcd,
                               ansel    => an,
                               dout     => seg,
                               clk      => super_slow_clk);
end Behavioral;
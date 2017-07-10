library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all; -- Imports the standard textio package.

entity DotProduct is
  port (
    clk : in std_logic;
    reset : in std_logic
    );
end DotProduct;

architecture RTL of DotProduct is
  -- declarations
  constant N : integer := 4;
  type ArrayType is array(0 to N-1) of unsigned(1 downto 0); -- array of N 2 bit
                                                             -- unsigned numbers

  constant a : ArrayType := (to_unsigned(0, 2),
                             to_unsigned(1, 2),
                             to_unsigned(2, 2),
                             to_unsigned(3, 2)
                             );

  constant b : ArrayType := (to_unsigned(0, 2),
                             to_unsigned(1, 2),
                             to_unsigned(2, 2),
                             to_unsigned(3, 2)
                             );

  --
  signal s1 : unsigned(3 downto 0); -- 4 bits because 4=2*2 [2 2-bit numbers were multiplied]
  signal s2 : unsigned(4 downto 0); -- 5 bits because ceil(log2(2**4*2)) =
                                    -- ceil(log2(2**5)) = 5
  signal s3 : unsigned(5 downto 0); -- 6 bits as above
  signal s : unsigned(5 downto 0); -- 6 bits as above

begin
-- behaviour
  process(clk)
  begin
    if(rising_edge(clk)) then
      if(reset = '1') then
        -- reset values
        s1 <= (others => '0');
        s2 <= (others => '0');
        s3 <= (others => '0');
        s <= (others => '0');
      else
        -- do stuff
        s1 <= a(0)*b(0);
        s2 <= s1 + a(1)*b(1);
        s3 <= s2 + a(2)*b(2);
        s <= s3 + a(3)*b(3);        
      end if;
    end if;
  end process;  
end RTL;


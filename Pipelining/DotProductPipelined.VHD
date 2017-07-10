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

  type ResultArrayType is array(0 to N-1) of unsigned(5 downto 0); -- array of N
                                                                   -- 6 bit
                                                                   -- unsigned numbers
  -- 6 bits because 2*2 = 4 [2 2-bit numbers were multiplied]
  -- and then 4+2=6 [(4 (2^2)) numbers added together]
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
  signal s1 : ResultArrayType;
  signal s2 : ResultArrayType;
  signal s : unsigned(5 downto 0); -- 6 bits as determined above
begin
-- behaviour
  process(clk)
  begin
    if(rising_edge(clk)) then
      if(reset = '1') then
        -- reset values
        s1 <= (others => to_unsigned(0, 6));
        s2 <= (others => to_unsigned(0, 6));
      else
        -- do stuff
        s1(0) <= a(0)*b(0);
        s1(1) <= a(1)*b(1);
        s1(2) <= a(2)*b(2);    
        s1(3) <= a(3)*b(3);    

        s2(0) <= s1(0) + s1(1);
        s2(1) <= s1(2) + s1(3);

        s <= s2(0) + s2(1);
      end if;
    end if;
  end process;  
end RTL;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use STD.textio.all; -- Imports the standard textio package.

entity InnerProduct is
  port (
    clk : in std_logic;
    reset : in std_logic;
    input : in unsigned(15 downto 0); -- Q1.15
    StartCalculation : in std_logic;
    InnerProductOutput : out unsigned(33 downto 0) -- Q5.29
    );
end InnerProduct;

architecture InnerProductArchitecture of InnerProduct is
-- declarations
  constant VectorLength : integer := 3;
  
  type vector_unsigned is array(VectorLength-1 downto 0) of unsigned(15 downto 0);
  
  constant InnerProductArray : vector_unsigned := (to_unsigned(19661, 16), to_unsigned(16384, 16), to_unsigned(3277,16));
  -- Q2.14 ; Values are : 1.2 (19660.8), 1.0 (16384) and 0.2 (3276.8)
  
  signal InnerProductResult : unsigned(33 downto 0); -- Q5.29
  -- InnerProductResult is Q5.29 because the intermediate result of each
  -- multiplication (of Q1.15 x Q2.14) is Q3.29. Then adding 3 of them means
  -- that you need to add 1 to the upper bit for each of the 2 added values
  
  signal counting : std_logic;
  signal counter : integer;
begin
-- behaviour
  process(clk)
  begin
    if(rising_edge(clk)) then
      if(reset = '1') then
        -- reset values
        InnerProductOutput <= to_unsigned(0,34);
        InnerProductResult <= to_unsigned(0,34);
        counting <= '0';
        counter <= 0;
      else
        -- do calculation of inner product
        if StartCalculation = '1' then
          counting <= '1';
        end if;
        if counting = '1' and counter < VectorLength then
          InnerProductResult <= InnerProductResult +
                                input*InnerProductArray(counter);
          counter <= counter + 1;
        end if;
        if counter = VectorLength then
          InnerProductOutput <= InnerProductResult;
          InnerProductResult <= to_unsigned(0,34);
          counter <= 0;
          counting <= '0';
        end if;
      end if;
    end if;
  end process;
end InnerProductArchitecture;

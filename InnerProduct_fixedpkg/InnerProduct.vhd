library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use STD.textio.all; -- Imports the standard textio package.

entity InnerProduct is
  port (
    clk : in std_logic;
    reset : in std_logic;
    input : in ufixed(0 downto -15); -- Q1.15
    StartCalculation : in std_logic;
    InnerProductOutput : out ufixed(4 downto -29) -- Q5.29
    );
end InnerProduct;

architecture InnerProductArchitecture of InnerProduct is
-- declarations
  constant VectorLength : integer := 3;
              
  type vector_ufixed is array(0 to VectorLength-1) of ufixed(1 downto -14);
  
  constant InnerProductArray : vector_ufixed := (to_ufixed(1.2,1,-14), to_ufixed(1.0,1,-14), to_ufixed(0.2,1,-14));
  -- Q2.14 ; Values are : 1.2, 1.0 and 0.2

  signal InnerProductResult : ufixed(4 downto -29); -- Q5.29
  -- InnerProductResult is Q5.29 because the intermediate result of each
  -- multiplication (of Q1.15 x Q2.14) is Q3.29. Then adding 3 of them means
  -- that you need to add 1 to the upper bit for each of the 2 added values
  
  signal counting : std_logic;
  signal counter : integer;
begin
-- behaviour
  process(clk)
    variable l : line;
  begin
    if(rising_edge(clk)) then
      if(reset = '1') then
        -- reset values
        InnerProductOutput <= to_ufixed(0,4,-29);
        InnerProductResult <= to_ufixed(0,4,-29);
        counting <= '0';
        counter <= 0;
      else
        -- do calculation of inner product
        if StartCalculation = '1' then
          counting <= '1';
        end if;
        if counting = '1' and counter < VectorLength then
--          write(l, real'image(to_real(InnerProductResult)));
--          write(l, string'(", "));
--          write(l, real'image(to_real(InnerProductResult + input*InnerProductArray(counter))));
--          writeline(output, l);
          InnerProductResult <= resize(
            arg => InnerProductResult + input*InnerProductArray(counter),
            size_res => InnerProductResult
            );
          counter <= counter + 1;
        end if;
        if counter = VectorLength then
          InnerProductOutput <= InnerProductResult;
          InnerProductResult <= to_ufixed(0,4,-29);
          counter <= 0;
          counting <= '0';
        end if;
      end if;
    end if;
  end process;
end InnerProductArchitecture;

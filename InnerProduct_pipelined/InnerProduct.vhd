library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all; -- Imports the standard textio package.

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

  type VArrayType is array(2 downto 0) of unsigned(15 downto 0);
  constant VArray : VArrayType := (to_unsigned(19661, 16), to_unsigned(16384, 16), to_unsigned(3277,16));
  -- Q2.14 ; Values are : 1.2 (19660.8), 1.0 (16384) and 0.2 (3276.8)

  type IntermediateArray1Type is array(2 downto 0) of unsigned(31 downto 0);
  signal IntermediateArray1 : IntermediateArray1Type;
  -- Q3.29 ;

  signal InnerProductResult : unsigned(33 downto 0); -- Q4.29
  -- InnerProductResult is Q4.29 because the intermediate result of each
  -- multiplication (of Q1.15 x Q2.14) is Q3.29. Then adding 2 of them means
  -- that you need to add 1 to the upper bit for the 1 added value
  
  signal counting : std_logic;
  signal counter : unsigned(1 downto 0); -- can only take values 0-3
begin
-- behaviour
  process(clk)
    variable counterInt : integer range 0 to 3;
    variable l : line;
  begin
    if(rising_edge(clk)) then
      if(reset = '1') then
        -- reset values
        InnerProductOutput <= to_unsigned(0,34);
        InnerProductResult <= to_unsigned(0,34);
        counting <= '0';
        counter <= to_unsigned(0, 2);
      else
        -- do calculation of inner product
        if StartCalculation = '1' then
          counting <= '1';
        end if;
        if counting = '1' then
          counterInt := to_integer(counter);
          case counterInt is
            when 0 =>
              IntermediateArray1(0) <= input*VArray(0);
              counter <= counter + 1;
            when 1 =>
              IntermediateArray1(1) <= input*VArray(1);
              counter <= counter + 1;
            when 2 =>
              write(l, string'("result = "));
              write(l, integer'image(to_integer(unsigned(IntermediateArray1(0) + IntermediateArray1(1)))));
              writeline(output, l);
              InnerProductResult <= resize(IntermediateArray1(0), 34) + resize(IntermediateArray1(1), 34);
              -- 2 intermediate results (2 values of IntermediateArray1) are ready so add them 
              IntermediateArray1(2) <= input*VArray(2);
              counter <= counter + 1;              
            when 3 =>              
              InnerProductOutput <= InnerProductResult + IntermediateArray1(2);
              -- output result
              InnerProductResult <= to_unsigned(0,34);
              counter <= to_unsigned(0, 2);
              counting <= '0';
--            when others =>
--              counter <= to_unsigned(0, 2);
          end case; 
        end if;
      end if;
    end if;
  end process;
end InnerProductArchitecture;

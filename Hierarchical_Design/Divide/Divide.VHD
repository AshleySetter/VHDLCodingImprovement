-- Divider entity - takes 3*NumOfBitsforsignals + 2 clock cycles to calculate
-- result of Numerator / Denominator

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all; -- Imports the standard textio package.

entity Divide is
  generic (
    NumOfBitsForSignals : integer := 32
    );
  port (
    clk : in std_logic;
    reset : in std_logic;
    Numerator : in signed(NumOfBitsForSignals-1 downto 0);
    Denominator : in signed(NumOfBitsForSignals-1 downto 0);
    Result : out signed(NumOfBitsForSignals-1 downto 0)
    );
end Divide;

architecture behaviour of Divide is
-- declarations
  signal Numerator_Absolute : signed(NumOfBitsForSignals-1 downto 0);
  signal Denominator_Absolute : signed(NumOfBitsForSignals-1 downto 0);
  signal Remainder : signed(NumOfBitsForSignals-1 downto 0);
  signal Quotient : signed(NumOfBitsForSignals-1 downto 0);
  signal sign_of_result : signed(NumOfBitsForSignals-1 downto 0);
  
  signal StageCounter : integer;
  signal DivideStage : integer;
  signal DivideStageCounter : integer;

begin
-- behaviour
  process(clk)
    variable l : line;
  begin
    if(rising_edge(clk)) then
      if(reset = '1') then
        -- reset values
        Remainder <= to_signed(0, NumOfBitsForSignals);
        Quotient <= to_signed(0, NumOfBitsForSignals);
        Numerator_Absolute <= to_signed(0, NumOfBitsForSignals);
        Denominator_Absolute <= to_signed(0, NumOfBitsForSignals);
        StageCounter <= 0;
        DivideStage <= 0;
        DivideStageCounter <= 0;
      else
        -- do stuff
        case StageCounter is
          when 0 =>
            -- stage 0
            Numerator_Absolute <= abs(Numerator);
            Denominator_Absolute <= abs(Denominator);
            Remainder <= to_signed(0, NumOfBitsForSignals);
            Quotient <= to_signed(0, NumOfBitsForSignals);
            StageCounter <= StageCounter + 1;
            DivideStage <= Numerator_Absolute'high;
            DivideStageCounter <= 0;
            if ((Numerator < 0 and Denominator > 0) or (Numerator > 0 and Denominator < 0)) then
              sign_of_result <= to_signed(-1, sign_of_result'length);
            else
              sign_of_result <= to_signed(1, sign_of_result'length);
            end if;
          when 1 =>
            --write(l, string'("Divide Stage: "));
            --write(l, DivideStage);
            --write(l, string'("  Num_abs(DivideStage): "));
            --write(l, std_logic'image(Numerator_Absolute(DivideStage)));
            --writeline(output, l);
            --write(l, string'("DivideStageCounter: "));
            --write(l, DivideStageCounter);
            --writeline(output, l);     
            --write(l, string'("test"));
            --writeline(output, l);
            --write(l, string'("Quotient: "));
            --write(l, to_integer(Quotient));
            --writeline(output, l);                  

            -- stage 1
            if DivideStage >= 0 then
              case DivideStageCounter is
                -- clock cycle 1
                when 0 =>
                  --write(l, string'("DivideStageCounter 1"));
                  --writeline(output, l);                              
                  Remainder <= shift_left(Remainder, 1);
                  DivideStageCounter <= DivideStageCounter + 1;
                when 1 =>
                  -- clock cycle 2
                  --write(l, string'("DivideStageCounter 2"));
                  --writeline(output, l);                              
                  Remainder(0) <= Numerator_Absolute(DivideStage);
                  --write(l, string'("Numerator_abs(i): "));                  
                  --write(l, std_logic'image(Numerator_Absolute(DivideStage)));
                  --writeline(output, l);
                  DivideStageCounter <= DivideStageCounter + 1;
                when 2 =>
                  -- clock cycle 3
                  --write(l, string'("DivideStageCounter 3"));
                  --writeline(output, l);                                                
                  --write(l, string'("Remainder: "));
                  --write(l, to_integer(Remainder));
                  --writeline(output, l);                  
                  if Remainder >= Denominator_Absolute then
                    Remainder <= Remainder - Denominator;
                    Quotient(DivideStage) <= '1';
                  end if;
                  DivideStage <= DivideStage - 1;
                  DivideStageCounter <= 0;
                  if DivideStage = 0 then
                    --write(l, string'("Done, incrementing Stage Counter"));
                    --writeline(output, l);              
                    StageCounter <= StageCounter + 1;
                  end if;
                when others =>
                  DivideStageCounter <= 0;
              end case;
            end if;            
          when 2 =>
            -- stage 2
            --write(l, string'("FINAL Quotient: "));
            --write(l, to_integer(Quotient));
            --writexsline(output, l);
            Result <= resize(sign_of_result*Quotient, Result'length);
            StageCounter <= 0;
          when others =>
            StageCounter <= 0;
        end case;        
    end if;
  end if;
end process;
end behaviour;

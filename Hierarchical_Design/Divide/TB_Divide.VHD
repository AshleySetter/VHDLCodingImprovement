library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all; -- Imports the standard textio package.

entity TB_Divide is
  generic(
    constant NumOfBitsForSignals : integer := 32
    );
end TB_Divide;

architecture behaviour of TB_Divide is
-- declarations
  signal clk : std_logic;
  signal reset : std_logic;
  signal Numerator : signed(NumOfBitsForSignals-1 downto 0);
  signal Denominator : signed(NumOfBitsForSignals-1 downto 0);
  signal Result : signed(NumOfBitsForSignals-1 downto 0);

  signal CodeCounter : integer := 0; 
  
  constant clk_period : time := 5 ns;  
  
  component Divide
    port (
      clk : in std_logic;
      reset : in std_logic;
      Numerator : in signed(NumOfBitsForSignals-1 downto 0);
      Denominator : in signed(NumOfBitsForSignals-1 downto 0);
      Result : out signed(NumOfBitsForSignals-1 downto 0)
      );
  end component;

begin
-- behaviour
  UUT : Divide
--    generic map(
--      NumOfBitsForSignals => NumOfBitsForSignals
--      )
    port map(
      clk => clk,
      reset => reset,
      Numerator => Numerator,
      Denominator => Denominator,
      Result => Result
      );
        
  clk_process : process is
    variable l : line;
  begin
    write(l, integer'image(to_integer(Result)));
    write(l, string'("  CodeCounter: "));
    write(l, integer'image(CodeCounter));
    writeline(output, l);
    CodeCounter <= CodeCounter + 1;
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
  end process clk_process; 

  StimulusProcess : process is
    variable l : line;
  begin
    Numerator <= to_signed(-1073741824, Numerator'length);
    Denominator <= to_signed(2, Denominator'length);
    reset <= '1';
    wait for 1*clk_period;
    reset <= '0';
    wait for 1*clk_period;
    write(l, string'("start"));
    writeline(output, l);
    
    wait;
  end process StimulusProcess;

  
end behaviour;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all; -- Imports the standard textio package.

entity TB_usedivideby4 is
end TB_usedivideby4;

architecture behaviour of TB_usedivideby4 is
-- declarations
  signal clk : std_logic;
  signal reset : std_logic;
  signal input_signal : signed(15 downto 0);
  signal output_signal : signed(15 downto 0);

  constant clk_period : time := 5 ns;

  component usedivideby4
    port (
      clk : in std_logic;
      reset : in std_logic;
      input_signal : in signed(15 downto 0);
      output_signal : out signed(15 downto 0)
      );
  end component;

begin
-- behaviour
  UUT : usedivideby4
    port map(
      clk => clk,
      reset => reset,
      input_signal => input_signal,
      output_signal => output_signal
      );
        
  clk_process : process is
    variable l : line;
  begin
    write(l, integer'image(to_integer(signed(output_signal))));
    writeline(output, l);
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
  end process clk_process; 

  StimulusProcess : process is
  begin
    reset <= '1';
    wait for 1*clk_period;
    reset <= '0';
    wait for 1*clk_period;
    input_signal <= to_signed(4444, 16);
    
    wait;
  end process StimulusProcess;

  
end behaviour;

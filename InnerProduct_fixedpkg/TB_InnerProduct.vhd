library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all; -- Imports the standard textio package.

entity TB_InnerProduct is
end TB_InnerProduct;

architecture behaviour of TB_InnerProduct is
-- declarations
  component InnerProduct
    port(
      clk : in std_logic;
      reset : in std_logic;
      input : in unsigned(15 downto 0);
      StartCalculation : in std_logic;
      InnerProductOutput : out unsigned(33 downto 0)
      );
  end component;

  signal clk : std_logic;
  signal reset : std_logic;
  signal input : unsigned(15 downto 0);
  signal StartCalculation : std_logic;
  signal InnerProductOutput : unsigned(33 downto 0);
    
  constant clk_period : time := 5 ns;

begin
-- behaviour
  UUT : InnerProduct
    port map (
      clk                => clk,
      reset              => reset,
      input              => input,
      StartCalculation   => StartCalculation,
      InnerProductOutput => InnerProductOutput
      );

  clk_process : process is
    variable l : line;
  begin
    write(l, integer'image(to_integer(unsigned(InnerProductOutput))));
    writeline(output, l);
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
  end process clk_process; 

  StimulusProcess : process is
  begin
    reset <= '1';
    wait for 2*clk_period;
    reset <= '0';
    wait for 1*clk_period;
    StartCalculation <= '1';
    wait for 1*clk_period;
    input <= to_unsigned(0.5*2**15, 16); -- 0.5 in Q1.15
    
    wait;
  end process StimulusProcess;
  
end behaviour;

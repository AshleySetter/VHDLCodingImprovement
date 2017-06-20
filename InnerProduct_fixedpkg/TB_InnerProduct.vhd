library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use STD.textio.all; -- Imports the standard textio package.

entity TB_InnerProduct is
end TB_InnerProduct;

architecture behaviour of TB_InnerProduct is
-- declarations
  component InnerProduct
    port(
      clk : in std_logic;
      reset : in std_logic;
      input : in ufixed(0 downto -15);
      StartCalculation : in std_logic;
      InnerProductOutput : out ufixed(4 downto -29)
      );
  end component;

  signal clk : std_logic;
  signal reset : std_logic;
  signal input : ufixed(0 downto -15);
  signal StartCalculation : std_logic;
  signal InnerProductOutput : ufixed(4 downto -29);
    
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
    --    write(l, real'image(to_real(InnerProductOutput)));
    --    writeline(output, l);
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
    input <= to_ufixed(0.5,0,-15); -- 0.5 in Q1.15
    
    wait;
  end process StimulusProcess;
  
end behaviour;

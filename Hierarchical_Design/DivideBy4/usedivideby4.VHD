library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use STD.textio.all; -- Imports the standard textio package.

entity usedivideby4 is
  port (
    clk : in std_logic;
    reset : in std_logic;
    input_signal : in signed(15 downto 0);
    output_signal : out signed(15 downto 0)
    );
end usedivideby4;

architecture behaviour of usedivideby4 is
-- declarations

  component divideby4
    Port(clk : in std_logic;
         reset : in std_logic;
         input_signal : in signed(15 downto 0);
         output_signal : out signed(15 downto 0)
         );
  end component;
  
begin
-- behaviour

  divideby4_1 : divideby4 port map(clk => clk,
                                   reset => reset,
                                   input_signal => input_signal,
                                   output_signal => output_signal);
  
  process(clk)
  begin
    if(rising_edge(clk)) then
      if(reset = '1') then
        -- reset values        
      else
        -- do stuff        
    end if;
  end if;
end process;
end behaviour;

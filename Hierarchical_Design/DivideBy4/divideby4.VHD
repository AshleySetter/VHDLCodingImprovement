library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use STD.textio.all; -- Imports the standard textio package.

entity divideby4 is
  port (
    clk : in std_logic;
    reset : in std_logic;
    input_signal : in signed(15 downto 0);
    output_signal : out signed(15 downto 0)
    );
end divideby4;

architecture behaviour of divideby4 is
-- declarations
  signal intermediate_signal : signed(15 downto 0);
begin
-- behaviour
  process(clk)
  begin
    if(rising_edge(clk)) then
      if(reset = '1') then
        -- reset values
        intermediate_signal <= to_signed(0, intermediate_signal'length);
      else
        -- do stuff
        intermediate_signal <= shift_right(input_signal, 2);
        output_signal <= intermediate_signal;
    end if;
  end if;
end process;
end behaviour;

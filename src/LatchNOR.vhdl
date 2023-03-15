library ieee;
use ieee.std_logic_1164.all;

entity nor_latch is
  port (
    clk    : in  std_logic;
    reset  : in  std_logic;
    enable : in  std_logic;
    input  : in  std_logic;
    output : out std_logic
  );
end entity;

architecture rtl of nor_latch is
  signal latch : std_logic;
begin
  process (clk, reset)
  begin
    if reset = '1' then
      latch <= '0';
    elsif rising_edge(clk) then
      if enable = '0' then
        latch <= 'Z';
      else
        latch <= not (input nor latch);
      end if;
    end if;
  end process;
  output <= latch;
end architecture;

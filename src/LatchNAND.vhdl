-- Latch with NAND gates in VHDL

library ieee;
use ieee.std_logic_1164.all;

entity latch is
    port (
        enable  : in std_logic;
        input   : in std_logic;
        output  : out std_logic
    );
end entity;

architecture behavior of latch is
    signal q_reg : std_logic;
begin
    -- Latch process
    process (enable, input, clk, reset)
    begin
        if reset = '1' then
            q_reg <= '0';
        elsif enable = '1' then
            q_reg <= not (input nand q_reg);
        end if;
    end process;

    -- Latch output
    output <= q_reg;
end architecture;

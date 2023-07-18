-- 4-Bit Partial Full Adder

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY partial_full_adder IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        cin : IN STD_LOGIC;
        s : OUT STD_LOGIC;
        p : OUT STD_LOGIC;
        g : OUT STD_LOGIC);
END partial_full_adder;

ARCHITECTURE Behavioral OF partial_full_adder IS

BEGIN
    
    s <= a XOR b XOR cin;
    p <= a XOR b;
    g <= a AND b;

END Behavioral;
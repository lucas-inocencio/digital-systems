-- 4-Bit Carry-Lookahead Adder

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY carry_lookahead_adder IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        cin : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        cout : OUT STD_LOGIC
    );
END carry_lookahead_adder;

ARCHITECTURE Behavioral OF carry_lookahead_adder IS

    COMPONENT partial_full_adder
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            cin : IN STD_LOGIC;
            s : OUT STD_LOGIC;
            p : OUT STD_LOGIC;
            g : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL c1, c2, c3 : STD_LOGIC;
    SIGNAL p, g, s : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
BEGIN

    pfa1 : partial_Full_Adder PORT MAP(a(0), b(0), cin, s(0), p(0), g(0));
    pfa2 : partial_Full_Adder PORT MAP(a(1), b(1), c1, s(1), p(1), g(1));
    pfa3 : partial_Full_Adder PORT MAP(a(2), b(2), c2, s(2), p(2), g(2));
    pfa4 : partial_Full_Adder PORT MAP(a(3), b(3), c3, s(3), p(3), g(3));

    c1 <= g(0) OR (p(0) AND cin);
    c2 <= g(1) OR (p(1) AND g(0)) OR (p(1) AND p(0) AND cin);
    c3 <= g(2) OR (p(2) AND g(1)) OR (p(2) AND p(1) AND g(0)) OR (p(2) AND p(1) AND p(0) AND cin);
    cout <= g(3) OR (p(3) AND g(2)) OR (p(3) AND p(2) AND g(1)) OR (p(3) AND p(2) AND p(1) AND g(0)) OR (p(3) AND p(2) AND p(1) AND p(0) AND cin);

    y <= s;

END Behavioral;
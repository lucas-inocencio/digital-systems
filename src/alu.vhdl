-- ALU 4-bit
-- four flags (Zero, negative, carry out, overflow)

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        flags : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END ALU;

ARCHITECTURE Behavioral OF ALU IS

    COMPONENT carry_lookahead_adder
        PORT (
            a, b : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            cin : IN STD_LOGIC;
				y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            cout : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT subtractor
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    COMPONENT incrementer
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            incout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            inccout : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT inverter
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    SIGNAL sum, sub, a_plus_plus, a_inv : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL sum_cout, inc_cout : STD_LOGIC;
BEGIN

    cla_adder : carry_lookahead_adder PORT MAP(
        a,
        b,
        '0',
        sum,
        sum_cout);

    subt : subtractor
    PORT MAP(
        a,
        b,
        sub);

    inc : incrementer
    PORT MAP(
        a,
        a_plus_plus,
        inc_cout);

    inv : inverter
    PORT MAP(
        a,
        a_inv);

    PROCESS (a, b, sel)
    BEGIN
        CASE sel IS
            WHEN "000" => y <= sum;
                flags(0) <= sum_cout; -- overflow
                flags(1) <= sum_cout; -- carry out
                flags(2) <= '0'; -- negative
                IF sum = "0000" THEN
                    flags(3) <= '1'; -- zero
                ELSE
                    flags(3) <= '0';
                END IF;

            WHEN "001" => y <= sub;
                flags(0) <= '0';
                flags(1) <= '0';
                IF b > a THEN
                    flags(2) <= '1';
                ELSE
                    flags(2) <= '0';
                END IF;
                IF sub = "0000" THEN
                    flags(3) <= '1';
                ELSE
                    flags(3) <= '0';
                END IF;

            WHEN "010" =>
                y <= a_plus_plus;
                IF a = "1111" THEN
                    flags(0) <= '1';
                    flags(1) <= '1';
                ELSE
                    flags(0) <= '0';
                    flags(1) <= '0';
                END IF;
                IF a_plus_plus = "0000" THEN
                    flags(2) <= '1';
                ELSE
                    flags(2) <= '0';
                END IF;
                flags(3) <= '0';

            WHEN "011" =>
                y <= a_inv;
                IF a = "0000" THEN
                    flags(0) <= '1';
                ELSE
                    flags(0) <= '0';
                END IF;
                IF a = "0000" THEN
                    flags(1) <= '1';
                ELSE
                    flags(1) <= '0';
                END IF;
                IF a = "0000" THEN
                    flags(2) <= '0';
                ELSE
                    flags(2) <= '1';
                END IF;
                IF a = "0000" THEN
                    flags(3) <= '0';
                ELSE
                    flags(3) <= '1';
                END IF;

            WHEN OTHERS => y <= "0000";
                flags(0) <= '0';
                flags(1) <= '0';
                flags(2) <= '0';
                flags(3) <= '0';

        END CASE;
    END PROCESS;

END Behavioral;
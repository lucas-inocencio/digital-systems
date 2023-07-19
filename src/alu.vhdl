-- ALU 4-bit
-- four flags (Zero, negative, carry out, overflow)

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY alu IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
        flags : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
END alu;

ARCHITECTURE Behavioral OF alu IS

    COMPONENT carry_lookahead_adder
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            cin : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
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

    COMPONENT exor
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    COMPONENT comparator
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            eq, gt, lt : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT absolute_difference
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    COMPONENT hamming_weight_calculator
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
    END COMPONENT;

    SIGNAL sum, sub, a_plus_plus, a_inv, xr, mag_comp, abs_diff : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL hwc : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL sum_cout, inc_cout, equal, greater, less : STD_LOGIC;

BEGIN

    cla_adder : carry_lookahead_adder PORT MAP(a, b, '0', sum, sum_cout);

    subt : subtractor PORT MAP(a, b, sub);

    inc : incrementer PORT MAP(a, a_plus_plus, inc_cout);

    inv : inverter PORT MAP(a, a_inv);

    x0 : exor PORT MAP(a, b, xr);

    mc : comparator PORT MAP(a, b, equal, greater, less);

    abs_df : absolute_difference PORT MAP(a, b, abs_diff);

    hamming : hamming_weight_calculator PORT MAP(a, hwc);

    PROCESS(a, b, sel)
    BEGIN
        CASE sel IS
            WHEN "000" => y <= sum; -- adder
                flags(0) <= sum_cout; -- overflow
                flags(1) <= sum_cout; -- carry out
                flags(2) <= '0'; -- negative
                IF sum = "0000" THEN
                    flags(3) <= '1'; -- zero
                ELSE
                    flags(3) <= '0';
                END IF;

            WHEN "001" => y <= sub; -- subtractor
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

            WHEN "010" => -- incrementer
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

            WHEN "011" => -- inverter
                y <= a_inv;
                IF a = "0000" THEN
                    flags <= "0011";
                ELSE
                    flags <= "1100";
                END IF;

            WHEN "100" => -- XOR
                y <= xr;
                flags <= "0000";

            WHEN "101" => -- comparator
                y(3) <= equal;
                y(2) <= greater;
                y(1) <= less;
                y(0) <= '0';
                flags <= "0000";

            WHEN "110" => -- absolute difference
                y <= abs_diff;
                IF abs_diff = "0000" THEN
                    flags <= "1000";
                ELSE
                    flags <= "0000";
                END IF;

            WHEN "111" => -- hamming weight calculator
                y(3) <= '0';
                y(2) <= '0';
                y(1 DOWNTO 0) <= hwc;
                IF hwc = "00" THEN
                    flags <= "1000";
                ELSE
                    flags <= "0000";
                END IF;

        END CASE;
    END PROCESS;

END Behavioral;
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

    COMPONENT carry_look_ahead_adder
        PORT (
            a, b : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            cin : IN STD_LOGIC;
            cout : OUT STD_LOGIC;
            sum : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT subtractor
        PORT (
            a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    COMPONENT increment
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            cout : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT inverter
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

BEGIN

    cla_adder : carry_look_ahead_adder
    PORT MAP(
        a => a,
        b => b,
        cin => '0',
        sum_cout => flags(0),
        sum => y);

    subt : subtractor
    PORT MAP(
        a => a,
        b => b,
        sub => y);

    incr : increment
    PORT MAP(
        a => a,
        a_plus_plus => y,
        inc_cout => flags(0));

    inv : inverter
    PORT MAP(
        a => a,
        a_inv => y);

    PROCESS (a, b, sel)
    BEGIN
        CASE sel IS
            WHEN "000" => y <= sum;
					 begin 
                flags(0) <= sum_cout; -- overflow
                flags(1) <= sum_cout; -- carry out
                flags(2) <= '0'; -- negative
                flags(3) <= '1' WHEN (sum = "0000") ELSE
                '0'; -- zero

            WHEN "001" => y <= sub;
                flags(0) <= '0';
                flags(1) <= '0';
                flags(2) <= '1' WHEN b > a;
            ELSE
                '0';
                flags(3) <= '1' WHEN sub = "0000";
            ELSE
                '0';

            WHEN "010" => y <= a_plus_plus;
                flags(0) <= '1' WHEN a = "1111";
            ELSE
                '0';
                flags(1) <= '1' WHEN a = "1111";
            ELSE
                '0';
                flags(2) <= '1' WHEN y = "0000";
            ELSE
                '0';
                flags(3) <= '0';

            WHEN "011" => y <= a_inv;
                flags(0) <= '1' WHEN a = "0000";
            ELSE
                '0';
                flags(1) <= '1' WHEN a = "0000";
            ELSE
                '0';
                flags(2) <= '0' WHEN a = "0000";
            ELSE
                '1';
                flags(3) <= '0' WHEN a = "0000";
            ELSE
                '1';

            WHEN OTHERS => y <= "0000";
                flags(0) <= '0';
                flags(1) <= '0';
                flags(2) <= '0';
                flags(3) <= '0';

        END CASE;
    END PROCESS;

END Behavioral;
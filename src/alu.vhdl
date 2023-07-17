-- ALU 4-bit

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
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        );
    END COMPONENT;

    COMPONENT increment
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            cout : OUT STD_LOGIC;
        );
    END COMPONENT;

    COMPONENT inverter
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        );
    END COMPONENT;


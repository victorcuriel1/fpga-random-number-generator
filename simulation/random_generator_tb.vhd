LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dadodigital_simulacion IS
END dadodigital_simulacion;

ARCHITECTURE behavior OF dadodigital_simulacion IS

    COMPONENT dagodigital_module
        PORT (
            clk : IN std_logic;
            reset : IN std_logic;
            run : IN std_logic;
            stop : IN std_logic;
            s_display : OUT std_logic_vector(6 downto 0);
            dip : OUT std_logic_vector(2 downto 0)
        );
    END COMPONENT;


    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal run : std_logic := '0';
    signal stop : std_logic := '0';


    -- Outputs
    signal s_display : std_logic_vector(6 downto 0);
    signal dip : std_logic_vector(2 downto 0);


    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : dagodigital_module PORT MAP (
        clk => clk,
        reset => reset,
        run => run,
        stop => stop,
        s_display => s_display,
        dip => dip
    );


    -- Clock process definitions
    clk_process : process
    begin

        clk <= '0';
        wait for clk_period / 2;

        clk <= '1';
        wait for clk_period / 2;

    end process;


    -- Stimulus process
    stim_proc : process
    begin

        wait for 100 ns;

        reset <= '0';

        wait for 100 ns;

        reset <= '1';

        wait for 100 ns;

        run <= '1';

        wait for 100 ns;

        run <= '0';

        wait for 100 ns;

        stop <= '1';

        wait for 100 ns;

        stop <= '0';

        wait for 50 ns;

        run <= '1';

        wait for 50 ns;

        run <= '0';

        wait for 50 ns;

        stop <= '1';

        wait for 50 ns;

        stop <= '0';

        wait;

    end process;

END;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dagodigital_module is
    Port (
        clk, reset, run, stop : in STD_LOGIC;
        dot : out std_logic;
        s_display : out STD_LOGIC_VECTOR(6 downto 0);
        dip : out STD_LOGIC_VECTOR(2 downto 0)
    );
end dagodigital_module;

architecture Behavioral of dagodigital_module is

    type estado_type is (e0, e1, e2, e3);

    signal estado, estado_sig : estado_type;

    -- Senhales de Galois
    signal r, r_sig, aux : std_logic_vector(15 downto 0);
    signal aux2 : std_logic_vector(2 downto 0);
    signal aux3 : std_logic_vector(6 downto 0);
    signal en_galois, en : std_logic;
    signal c, c_sig : unsigned(27 downto 0);

begin

    process(clk) -- Proceso de sincronizacion
    begin
        if (clk'event and clk = '1') then
            if reset = '0' then
                estado <= e0;
            else
                estado <= estado_sig;
            end if;
        end if;
    end process;


    -- Controla la transicion de estados
    -- (ESTADO SIGUIENTE DECODE)
    process(estado, run, stop)
    begin

        estado_sig <= estado;

        case (estado) is

            when e0 =>
                if run = '1' then
                    estado_sig <= e1;
                end if;

            when e1 =>
                if run = '0' then
                    estado_sig <= e2;
                end if;

            when e2 =>
                if stop = '1' then
                    estado_sig <= e3;
                end if;

            when e3 =>
                if stop = '0' then
                    estado_sig <= e0;
                end if;

            when others =>
                estado_sig <= e0;

        end case;

    end process;


    -- Controla en_galois que se utiliza en
    -- la logica de Galois (SALIDA DECODE)
    process(estado, run, stop)
    begin

        en_galois <= '0';

        case (estado) is

            when e0 =>
                en_galois <= '0';

            when e1 =>
                if run = '0' then
                    en_galois <= '1';
                else
                    en_galois <= '0';
                end if;

            when e2 =>
                en_galois <= '1';

            when e3 =>
                if stop <= '0' then
                    en_galois <= '0';
                else
                    en_galois <= '1';
                end if;

            when others =>
                en_galois <= '0';

        end case;

    end process;


    process(clk)
    begin

        if (clk'event and clk = '1') then

            if reset = '0' then
                r <= "1010110011100001";
            else
                r <= r_sig;
            end if;

        end if;

    end process;


    process(clk) -- Divisor de frecuencia
    begin

        if clk'event and clk = '1' then

            if reset = '0' then
                c <= (others => '0');
            else
                c <= c_sig;
            end if;

        end if;

    end process;


    c_sig <= (others => '0') when c = 15000000
             else c + 1;

    en <= '1' when c = 15000000 else '0';


    -- Algoritmo de Galois
    aux <= r(0) & r(15 downto 1);

    r_sig <=
        aux(15) &
        aux(14) &
        (aux(0) XOR aux(14)) &
        (aux(0) XOR aux(13)) &
        aux(11) &
        (aux(0) XOR aux(11)) &
        aux(9 downto 0)

        when (en_galois = '1') and en = '1'
        else r;


    aux2 <= r(15 downto 13);


    -- Mostrar en el display
    with aux2 select
        aux3 <=
            "0110000" when "000",
            "0110000" when "001",
            "1101101" when "010",
            "1111001" when "011",
            "0110011" when "100",
            "1011011" when "101",
            "1011111" when others;


    -- Negamos porque el display es
    -- catodo comun
    s_display <= not(aux3);

    dip <= "011";

    dot <= '1';

end Behavioral;

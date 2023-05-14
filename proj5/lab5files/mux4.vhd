library IEEE;
use IEEE.std_logic_1164.all;

entity mux4 is
    generic( DWIDTH : integer := 16 );
    port( IN0: in std_logic_vector( DWIDTH-1 downto 0 );
          IN1: in std_logic_vector( DWIDTH-1 downto 0 );
          IN2: in std_logic_vector( DWIDTH-1 downto 0 );
          IN3: in std_logic_vector( DWIDTH-1 downto 0 );
          SEL: in std_logic_vector( 1 downto 0 );
          DOUT: out std_logic_vector( DWIDTH-1 downto 0 ) );
end mux4;

architecture behavioral of mux4 is
begin

    with SEL select
    DOUT <= IN0 when "00",
            IN1 when "01",
            IN2 when "10",
            IN3 when "11",
            (others => 'X') when others;

end behavioral;

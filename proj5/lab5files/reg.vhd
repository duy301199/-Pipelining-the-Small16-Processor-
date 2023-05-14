library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
  generic( DWIDTH : integer := 16 );
  port( CLK : in std_logic;
        RST : in std_logic;
        CE : in std_logic;
        
        D : in std_logic_vector( DWIDTH-1 downto 0 );
        Q : out std_logic_vector( DWIDTH-1 downto 0 ) );
end reg;

architecture behavioral of reg is
begin

  process( CLK, RST )
  begin
    if( RST = '1' ) then
      Q <= (others => '0');
    elsif( rising_edge( CLK ) ) then
      if( CE = '1' ) then
        Q <= D;
      end if;
    end if;
  end process;

end behavioral;

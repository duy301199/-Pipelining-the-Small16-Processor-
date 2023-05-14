library IEEE;
use IEEE.std_logic_1164.all;
use work.sm16_types.all;

-- ABCDRegFile Entity Description
-- Adapted from Dr. Michael Crocker's Spring 2013 CSCE 385 Lab 6 at Pacific Lutheran University
entity ABCDRegFile is
    port( CLK : in std_logic;
          RESET : in std_logic;
          
          RD_REG : in std_logic_vector(1 downto 0);  -- Which register to read and output
          REG_OUT : out sm16_data;
          
          ABCD_WE : in std_logic; -- Write enable signal
          WR_REG : in std_logic_vector(1 downto 0);  -- Which register to write to
          REG_IN : in sm16_data);
end ABCDRegFile;

-- ABCDRegFile Architecture Description
architecture structural of ABCDRegFile is

    -- declare all components and their ports
    component reg
        generic( DWIDTH : integer := 8 );
        port( CLK : in std_logic;
              RST : in std_logic;
              CE : in std_logic;
              
              D : in std_logic_vector( DWIDTH-1 downto 0 );
              Q : out std_logic_vector( DWIDTH-1 downto 0 ) );
    end component;
    
    component mux4 is
        generic( DWIDTH : integer := 16 );
        port( IN0: in std_logic_vector( DWIDTH-1 downto 0 );
              IN1: in std_logic_vector( DWIDTH-1 downto 0 );
              IN2: in std_logic_vector( DWIDTH-1 downto 0 );
              IN3: in std_logic_vector( DWIDTH-1 downto 0 );
              SEL: in std_logic_vector( 1 downto 0 );
              DOUT: out std_logic_vector( DWIDTH-1 downto 0 ) );
    end component;
    
    signal a_out, b_out, c_out, d_out : sm16_data;
    signal we_a, we_b, we_c, we_d : std_logic;
    
begin
    
    we_a <= ABCD_WE when WR_REG = "00" else '0';
    we_b <= ABCD_WE when WR_REG = "01" else '0';
    we_c <= ABCD_WE when WR_REG = "10" else '0';
    we_d <= ABCD_WE when WR_REG = "11" else '0';

    A: reg generic map ( DWIDTH => 16 )
        port map (
        CLK => CLK,
        RST => RESET,
        CE  => we_a,
        D   => REG_IN,
        Q   => a_out
        );
    
    B: reg generic map ( DWIDTH => 16 )
        port map (
        CLK => CLK,
        RST => RESET,
        CE  => we_b,
        D   => REG_IN,
        Q   => b_out
        );
    
    C: reg generic map ( DWIDTH => 16 )
        port map (
        CLK => CLK,
        RST => RESET,
        CE  => we_c,
        D   => REG_IN,
        Q   => c_out
        );
    
    D: reg generic map ( DWIDTH => 16 )
        port map (
        CLK => CLK,
        RST => RESET,
        CE  => we_d,
        D   => REG_IN,
        Q   => d_out
        );
    
    RegMux: mux4 generic map ( DWIDTH => 16 )
        port map (
        IN0  => a_out,     -- 00
        IN1  => b_out,     -- 01
        IN2  => c_out,     -- 10
        IN3  => d_out,     -- 11
        SEL  => RD_REG,
        DOUT => REG_OUT
        );
    
end structural;

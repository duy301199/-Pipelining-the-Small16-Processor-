library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.sm16_types.all;

-- data_memory Entity Description
-- Adapted from Dr. Michael Crocker's Spring 2013 CSCE 385 Lab 4 at Pacific Lutheran University
entity data_memory is
    port( DIN : in sm16_data;
          ADDR : in sm16_address;
          DOUT : out sm16_data;
          WE : in std_logic);
end data_memory;

-- data_memory Architecture Description
architecture behavioral of data_memory is
    subtype ramword is bit_vector(15 downto 0);
    type rammemory is array (0 to 1023) of ramword;
    ----------------------------------------------
    ----------------------------------------------
    -----  This is where you put your data -------
    ----------------------------------------------
    ----------------------------------------------
--PART A:
    signal ram : rammemory := ("0000000000000100",  --  0: array[0]=4 00
                               "0000000000000101",  --  1: array[1]=5 01
                               "0000000000000110",  --  2: array[2]=6 10
                               "0000000000000111",  --  3: array[3]=7 11
                               "0000000000001000",  --  4: array[4]=8 100
                               "0000000000001001",  --  5: array[5]=9 101
                               "0000000000001010",  --  6: array[6]=10 110
                               "0000000000001011",  --  7: array[7]=11 111
                               "0000000000001100",  --  8: array[8]=12 1000
                               "0000000000001101",  --  9: array[9]=13 1001
                               "0000000000001110",  -- 10: array[10]=14 1010
                               "0000000000001111",  -- 11: array[11]=15 1011
                               "0000000000010000",  -- 12: array[12]=16 1100
                               "0000000000010001",  -- 13: array[13]=17 1101
                               "0000000000010010",  -- 14: array[14]=18 1110
                               "0000000000010011",  -- 15: array[15]=19 1111
                               "0000000000010100",  -- 16: array[16]=20
                               "0000000000010101",  -- 17: array[17]=21
                               others => "0000000000000000");


begin

    DOUT <= to_stdlogicvector(ram(to_integer(unsigned(ADDR))));
    
    ram(to_integer(unsigned(ADDR))) <= to_bitvector(DIN) when WE = '1';

end behavioral;

library IEEE;
use IEEE.std_logic_1164.all;

-- From Dr. Michael Crocker's Spring 2013 CSCE 385 Lab 6 at Pacific Lutheran University
package sm16_types is

  subtype sm16_data is std_logic_vector(15 downto 0);     -- 16 bits
  subtype sm16_address is std_logic_vector(9 downto 0);   -- 10 bits
  subtype sm16_opcode is std_logic_vector (3 downto 0);   -- 4 bits

end sm16_types;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use work.sm16_types.all;

-- adder Entity Description
-- Adapted from Dr. Michael Crocker's Spring 2013 CSCE 385 Lab 4 at Pacific Lutheran University
entity adder is
    port( A : in sm16_address;
          B : in sm16_address;
          D : out sm16_address);
end adder;

-- adder Architecture Description
architecture behavioral of adder is
begin
    
    D <= A + B;
    
end behavioral;

library IEEE;
use IEEE.std_logic_1164.all;
use work.sm16_types.all;

-- zero_extend Entity Description
-- From Dr. Michael Crocker's Spring 2013 CSCE 385 Lab 4 at Pacific Lutheran University
entity zero_extend is
   port(
      A: in sm16_address;
      Z: out sm16_data
   );
end zero_extend;


-- zero_extend Architecture Description
architecture dataflow of zero_extend is

signal zero_16 : sm16_data := "0000000000000000";

begin

    Z(15 downto 10) <= zero_16(15 downto 10);
    Z(9 downto 0) <= A;

end dataflow;

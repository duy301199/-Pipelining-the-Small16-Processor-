library IEEE;
use IEEE.std_logic_1164.all;
use work.sm16_types.all;

-- zero_checker Entity Description
-- From Dr. Michael Crocker's Spring 2013 CSCE 385 Lab 4 at Pacific Lutheran University
entity zero_checker is
   port(
      A: in sm16_data;
      Z: out std_logic
   );
end zero_checker;


-- zero_checker Architecture Description
architecture dataflow of zero_checker is

begin

  Z <= not (A(0) or A(1) or A(2) or A(3) or
   		    A(4) or A(5) or A(6) or A(7) or
			A(8) or A(9) or A(10) or A(11) or
			A(12) or A(13) or A(14) or A(15));

end dataflow;

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
use work.sm16_types.all;

-- From Dr. Michael Crocker's Spring 2013 CSCE 385 Lab 4 at Pacific Lutheran University
ENTITY test_processor IS
END test_processor;

ARCHITECTURE testbench OF test_processor IS 
    
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT processor IS
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic
        );
    END COMPONENT;
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal start : std_logic := '0';
    
    -- Clock period definitions
    constant clk_period : time := 10 ns;
    
BEGIN
    
	-- Instantiate the Unit Under Test (UUT)
    uut: processor PORT MAP (
          clk => clk,
          reset => reset,
          start => start
        );
    
    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns
        reset <= '1';
        wait for 100 ns;
        
        reset <= '0';
        start <= '1';
        wait for clk_period*2;
        
        start <= '0';
        wait for clk_period*14;  -- load, add, store -> 4+4+3=11
        
        wait;
    end process;

END testbench;

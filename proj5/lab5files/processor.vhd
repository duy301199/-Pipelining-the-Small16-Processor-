library IEEE;
use IEEE.std_logic_1164.all;
use work.sm16_types.all;

-- processor Entity Description
-- Adapted from Dr. Michael Crocker's Spring 2013 CSCE 385 Lab 4 at Pacific Lutheran University
entity processor is
    port( CLK : in std_logic;
          RESET : in std_logic;
          START : in std_logic  -- signals to run the processor
          );
end processor;

-- processor Architecture Description
architecture structural of processor is
    
    -- declare all components and their ports 
    component datapath is
        port( CLK   : in std_logic;
              RESET : in std_logic;
              
              -- I/O with Data Memory
              DATA_IN   : out sm16_data; --out from ABCD_Regout
              DATA_OUT  : in  sm16_data;
              DATA_ADDR : out sm16_address; --out from instr. word s1-s2
              
              -- I/O with Instruction Memory
              INSTR_OUT  : in  sm16_data; --input of instr. word s1-s2
              INSTR_ADDR : out sm16_address; --out from pc s1
              
              -- OpCode sent to the Control
              INSTR_OP   : out sm16_opcode; --(4bits) out from instr. word to opcode s2-s3 (15 downto 12)
              
              -- Control Signals to the ALU
              ALU_OP : in std_logic_vector(1 downto 0); --s3
              B_INV  : in std_logic; --s3
              CIN    : in std_logic; --s3
              
              -- Control Signals from the Accumulator
              --ZERO_FLAG : out std_logic; --might not be used
              --NEG_FLAG  : out std_logic; --might not be used

              -- ALU Multiplexer Select Signals
              A_SEL  : in std_logic;
              B_SEL  : in std_logic; -- input from immediate s2-s3
              --PC_SEL : in std_logic;
              
              -- Enable Signals for all registers
              --EN_A  : in std_logic;
              EN_PC : in std_logic;
	      EN_ABCD : in std_logic;
	
	      EN_InstrWord : in std_logic;
	      EN_OPCODE : in std_logic;
              EN_Immediate: in std_logic;
	      EN_DATA : in std_logic;
	      EN_RegVal : in std_logic;
	      EN_REG : in std_logic;
	 
	      Instr_OP_S2 : out std_logic_vector(3 downto 0);
	      Instr_OP_S3 : out std_logic_vector(3 downto 0));
    end component;
    
    component instr_memory is
        port( DIN : in sm16_data;
              ADDR: in sm16_address;
              DOUT: out sm16_data;
              WE: in std_logic);
    end component;
    
    component data_memory is
        port( DIN : in sm16_data;
              ADDR : in sm16_address;
              DOUT : out sm16_data;
              WE : in std_logic);
    end component;
    


    component control_s2 is
        port( CLK   : in std_logic;
          RESET : in std_logic;
          START : in std_logic;
          
          WE     : out std_logic;
        
          EN_PC  : out std_logic;
          
	
	  EN_InstrWord : out std_logic;
	  EN_OPCODE : out std_logic;
          EN_Immediate: out std_logic;
	  EN_DATA : out std_logic;
	  EN_RegVal : out std_logic;
	  EN_REG : out std_logic;
	 
	  Instr_OP_S2 : in sm16_opcode
	
	  );
    end component;
    
    component control_s3 is

   	port( CLK   : in std_logic;
          RESET : in std_logic;
          START : in std_logic;
          
          --WE     : out std_logic;
          ALU_OP : out std_logic_vector(1 downto 0);
          B_INV  : out std_logic;
          CIN    : out std_logic;
          A_SEL  : out std_logic;
          B_SEL  : out std_logic;
         
          
	  EN_ABCD : out std_logic;
          
          Instr_OP_S3 : in sm16_opcode
	  );
   end component;

    signal DataAddress_Connect, PCAddress_Connect : sm16_address;
    signal Data_IntoMem_Connect : sm16_data;
    signal DataOut_OutofMem_Connect, Instruction_Connect : sm16_data;
    signal ReadWrite_Connect : std_logic;

    
    signal EN_ABCD_Connect : std_logic;

    signal InstrOpCode_Connect : sm16_opcode;
    signal ALUOp_Connect : std_logic_vector(1 downto 0);
    signal Binv_Connect  : std_logic;
    signal Cin_Connect   : std_logic;
   
    signal ASel_Connect  : std_logic;
    signal BSel_Connect  : std_logic;
    --signal PCSel_Connect : std_logic;
    
    --signal EnA_Connect  : std_logic;
    signal EnPC_Connect : std_logic;
  
    signal EN_InstrWord_Connect: std_logic;
    signal EN_OPCODE_Connect: std_logic;
    signal EN_Immediate_Connect: std_logic;
    signal EN_DATA_Connect: std_logic;
    signal EN_RegVal_Connect: std_logic;
    signal EN_REG_Connect: std_logic;
    signal Instr_OP_S2_Connect: sm16_opcode;
    signal Instr_OP_S3_Connect: sm16_opcode;

begin
    
    the_instr_memory: instr_memory port map (
        DIN => "0000000000000000",
        ADDR => PCAddress_Connect,
        DOUT => Instruction_Connect,
        WE => '0'  -- always read
        );
        
    the_data_memory: data_memory port map (
        DIN => Data_IntoMem_Connect,
        ADDR => DataAddress_Connect,
        DOUT => DataOut_OutofMem_Connect,
        WE => ReadWrite_Connect
        );
        
    the_datapath: datapath port map (
        CLK   => CLK,
        RESET => RESET,
        DATA_IN   => Data_IntoMem_Connect,
        DATA_OUT  => DataOut_OutofMem_Connect,
        DATA_ADDR => DataAddress_Connect,
        INSTR_OUT  => Instruction_Connect,
        INSTR_ADDR => PCAddress_Connect,
        INSTR_OP   => InstrOpCode_Connect,


        ALU_OP => ALUOp_Connect,
        B_INV  => Binv_Connect,
        CIN    => Cin_Connect,
       
        A_SEL  => ASel_Connect,
        B_SEL  => BSel_Connect,
     
  
        EN_PC => EnPC_Connect,
	EN_ABCD => EN_ABCD_Connect,
	EN_InstrWord => EN_InstrWord_Connect,
        EN_OPCODE => EN_OPCODE_Connect,
	EN_Immediate => EN_Immediate_Connect,
        EN_DATA => EN_DATA_Connect,
        EN_RegVal => EN_RegVal_Connect,
        EN_REG => EN_REG_Connect,
        Instr_OP_S2 => Instr_OP_S2_Connect,
        Instr_OP_S3 => Instr_OP_S3_Connect
        );
    
 
   
    the_control_s2: control_s2 port map (
        CLK   => CLK,
        RESET => RESET,
        START => START,
        WE     => ReadWrite_Connect,
	EN_PC => EnPC_Connect,
	
	EN_InstrWord => EN_InstrWord_Connect,
        EN_OPCODE => EN_OPCODE_Connect,
	EN_Immediate => EN_Immediate_Connect,
        EN_DATA => EN_DATA_Connect,
        EN_RegVal => EN_RegVal_Connect,
        EN_REG => EN_REG_Connect,
        Instr_OP_S2 => Instr_OP_S2_Connect  
        );

    the_control_s3: control_s3 port map (
        CLK   => CLK,
        RESET => RESET,
        START => START,
        --WE     => ReadWrite_Connect,
        ALU_OP => ALUOp_Connect,
        B_INV  => Binv_Connect,
        CIN    => Cin_Connect,
        A_SEL  => ASel_Connect,
        B_SEL  => BSel_Connect,
	EN_ABCD => EN_ABCD_Connect,
	Instr_OP_S3 => Instr_OP_S3_Connect  
        );    
end structural;

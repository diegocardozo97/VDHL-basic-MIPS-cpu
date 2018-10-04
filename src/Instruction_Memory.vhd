library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.ALL;

-- ROM that stores the instructions.
-- It word size is 32 bits and it has 32 registers but it can have up
-- to 2 ^ 30.
-- It has an asynchronous access.
entity INSTRUCTIONS_MEMORY is
	PORT(
        READ_ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000000";
	    INSTRUCTION : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end INSTRUCTIONS_MEMORY;

architecture Behavioral of INSTRUCTIONS_MEMORY is

begin

PROCESS(READ_ADDRESS)
	SUBTYPE REGISTRO IS STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data bus size
	TYPE REG_BANK IS ARRAY(0 TO 31) OF REGISTRO; -- Number of registers
	VARIABLE INS_MEMORY : REG_BANK := (OTHERS => (OTHERS => '0')); 

	VARIABLE READ_ADDRESS_INT : NATURAL;
BEGIN
	READ_ADDRESS_INT := TO_INTEGER(UNSIGNED(READ_ADDRESS(6 DOWNTO 2)));
	INSTRUCTION <= INS_MEMORY(READ_ADDRESS_INT);
END PROCESS;

end Behavioral;
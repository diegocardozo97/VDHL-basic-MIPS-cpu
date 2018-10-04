library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.ALL;

-- The data memory component.
-- The size of the word is of 32 bits and it has fixed 32 locations but
-- it can have up to 2^32.
-- Note: This component works in the falling edge.
entity DATA_MEMORY is
	PORT( 
        CLK : IN STD_LOGIC;
	    ENABLE : IN STD_LOGIC;
	    ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	    WRITE_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		WRITE_ENABLE : IN STD_LOGIC;
		READ_ENABLE : IN STD_LOGIC;
	    READ_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end DATA_MEMORY;

architecture Behavioral of DATA_MEMORY is

begin

PROCESS(CLK, ADDRESS, ENABLE)
	SUBTYPE REGISTRO IS STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data bus size
	TYPE REG_BANK IS ARRAY(0 TO 31) OF REGISTRO; -- Number of registers
	VARIABLE DATA_MEMORY_MEMORY : REG_BANK := (OTHERS => (OTHERS => '0'));
	VARIABLE ADDRESS_INT : NATURAL;
BEGIN
	ADDRESS_INT := TO_INTEGER(UNSIGNED(ADDRESS(6 DOWNTO 2)));

	IF ENABLE = '0' THEN
		IF FALLING_EDGE(CLK) THEN
			IF READ_ENABLE = '1' AND WRITE_ENABLE = '0' THEN
				READ_DATA <= DATA_MEMORY_MEMORY(ADDRESS_INT);
			ELSIF READ_ENABLE = '0' AND WRITE_ENABLE = '1' THEN
				DATA_MEMORY_MEMORY(ADDRESS_INT) := WRITE_DATA;
				READ_DATA <= X"00000000";
			END IF;
		END IF;
	END IF;
END PROCESS;

end Behavioral;
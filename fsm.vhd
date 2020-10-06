-- fsm.vhd: Finite State Machine
-- Author(s): Jan Zbořil, xzbori20@stud.fit.vutbr.cz, FIT VUT Brno, BIT1 2019/2020

-- ----------------------------------------------------------------------------
--                        Kod 1:    814224468   
--                        Kod 2:    8920907984    
-- ----------------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (ZNAK_01, ZNAK_02, ZNAK_13, ZNAK_14, ZNAK_15, ZNAK_16, ZNAK_17, ZNAK_18, ZNAK_19,
                    ZNAK_23, ZNAK_24, ZNAK_25, ZNAK_26, ZNAK_27, ZNAK_28, ZNAK_29, ZNAK_210,
                    ERROR, PRINT_MESSAGE_DENIED, PRINT_MESSAGE_ALLOWED, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= ZNAK_01;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
-- ----------------------------------------------------------------------------
--                        Kod 1:    814224468  
--                        Kod 2:    8920907984    
-- ----------------------------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is

   -- --------------------------------- Prvni cislo -----------------------------------
   when ZNAK_01 =>
      if ( KEY(8) = '1' ) then 
        next_state <= ZNAK_02;
      elsif ( KEY(15) = '1' ) then
        next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_01;
      end if;
   -- ------------------------------ Konec - Prvni cislo ------------------------------

   -- --------------------------------- Druhe cislo -----------------------------------
   when ZNAK_02 =>
      if ( KEY(1) = '1' ) then  
         next_state <= ZNAK_13;
      elsif ( KEY(9) = '1' ) then 
         next_state <= ZNAK_23;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then
          next_state <= ERROR;
      else next_state <= ZNAK_02;
      end if;
   -- ------------------------------ Konec - Druhe cislo -----------------------------

   -- --------------------------------- Treti cislo 1 -----------------------------------
   when ZNAK_13 =>
      if ( KEY(4) = '1' ) then 
         next_state <= ZNAK_14;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_13;
      end if;
   -- ------------------------------ Konec - Treti cislo 1 -----------------------------

   -- --------------------------------- Ctvrte cislo 1 -----------------------------------
   when ZNAK_14 =>
      if ( KEY(2) = '1' ) then 
         next_state <= ZNAK_15;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_14;
      end if;
   -- ------------------------------ Konec - Ctvrte cislo 1 -----------------------------

   -- --------------------------------- Pate cislo 1 -----------------------------------
   when ZNAK_15 =>
      if ( KEY(2) = '1' ) then 
         next_state <= ZNAK_16;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_15;
      end if;
   -- ------------------------------ Konec - Pate cislo 1 -----------------------------

   -- --------------------------------- Seste cislo 1 -----------------------------------
   when ZNAK_16 =>
      if ( KEY(4) = '1' ) then 
         next_state <= ZNAK_17;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_16;
      end if;
   -- ------------------------------ Konec - Seste cislo 1 -----------------------------

   -- --------------------------------- Sedme cislo 1 -----------------------------------
   when ZNAK_17 =>
      if ( KEY(4) = '1' ) then 
         next_state <= ZNAK_18;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_17;
      end if;
   -- ------------------------------ Konec - Sedme cislo 1 -----------------------------

   -- --------------------------------- Osme cislo 1 -----------------------------------
   when ZNAK_18 =>
      if ( KEY(6) = '1' ) then 
         next_state <= ZNAK_19;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_18;
      end if;
   -- ------------------------------ Konec - Osme cislo 1 -----------------------------

   -- --------------------------------- Devate cislo 1 -----------------------------------
   when ZNAK_19 =>
      if ( KEY(8) = '1' ) then 
         next_state <= PRINT_MESSAGE_ALLOWED;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_19;
      end if;
   -- ------------------------------ Konec - Devate cislo 1 -----------------------------

   -- --------------------------------- Treti cislo 2 -----------------------------------
   when ZNAK_23 =>
      if ( KEY(2) = '1' ) then 
         next_state <= ZNAK_24;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_23;
      end if;
   -- ------------------------------ Konec - Treti cislo 2 -----------------------------

   -- --------------------------------- Ctvrte cislo 2 -----------------------------------
   when ZNAK_24 =>
      if ( KEY(0) = '1' ) then 
         next_state <= ZNAK_25;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_24;
      end if;
   -- ------------------------------ Konec - Ctvrte cislo 2 -----------------------------

   -- --------------------------------- Pate cislo 2 -----------------------------------
   when ZNAK_25 =>
      if ( KEY(9) = '1' ) then 
         next_state <= ZNAK_26;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_25;
      end if;
   -- ------------------------------ Konec - Pate cislo 2 -----------------------------

   -- --------------------------------- Seste cislo 2 -----------------------------------
   when ZNAK_26 =>
      if ( KEY(0) = '1' ) then 
         next_state <= ZNAK_27;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_26;
      end if;
   -- ------------------------------ Konec - Seste cislo 2 -----------------------------

   -- --------------------------------- Sedme cislo 2 -----------------------------------
   when ZNAK_27 =>
      if ( KEY(7) = '1' ) then 
         next_state <= ZNAK_28;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then
         next_state <= ERROR;
      else next_state <= ZNAK_27;
      end if;
   -- ------------------------------ Konec - Sedme cislo 2 -----------------------------

   -- --------------------------------- Osme cislo 2 -----------------------------------
   when ZNAK_28 =>
      if ( KEY(9) = '1' ) then 
         next_state <= ZNAK_29;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_28;
      end if;
   -- ------------------------------ Konec - Osme cislo 2 -----------------------------

   -- --------------------------------- Devate cislo 2 -----------------------------------
   when ZNAK_29 =>
      if ( KEY(8) = '1' ) then 
         next_state <= ZNAK_210;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif ( KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_29;
      end if;
   -- ------------------------------ Konec - Devate cislo 2 -----------------------------

   -- --------------------------------- Desate cislo 2 -----------------------------------
   when ZNAK_210 =>
      if ( KEY(4) = '1' ) then 
         next_state <= PRINT_MESSAGE_ALLOWED;
      elsif ( KEY(15) = '1' ) then 
         next_state <= PRINT_MESSAGE_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then 
         next_state <= ERROR;
      else next_state <= ZNAK_210;
      end if;
   -- ------------------------------ Konec - Desate cislo 2 -----------------------------
   
   when PRINT_MESSAGE_ALLOWED =>
      next_state <= PRINT_MESSAGE_ALLOWED;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_DENIED =>
      next_state <= PRINT_MESSAGE_DENIED;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when ERROR =>
      next_state <= ERROR;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_DENIED;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -   
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= ZNAK_01; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= ZNAK_01;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_DENIED =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_ALLOWED =>
      FSM_CNT_CE     <= '1';
      FSM_MX_MEM     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      if (KEY(15) = '1') then FSM_LCD_CLR <= '1';
      end if;
      if (KEY(14 downto 0) /= "000000000000000") then FSM_LCD_WR <= '1';
      end if;
   end case;
end process output_logic;

end architecture behavioral;


library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
library GhdlLink;
use GhdlLink.Utility_Package.all;
use GhdlLink.Vhpi_Foreign.all;
entity ahir_system_Test_Bench is -- 
  -- 
end entity;
architecture VhpiLink of ahir_system_Test_Bench is -- 
  component ahir_system is -- 
    port (-- 
      shift_and_add_mul_a : in  std_logic_vector(7 downto 0);
      shift_and_add_mul_b : in  std_logic_vector(7 downto 0);
      shift_and_add_mul_product : out  std_logic_vector(15 downto 0);
      shift_and_add_mul_tag_in: in std_logic_vector(1 downto 0);
      shift_and_add_mul_tag_out: out std_logic_vector(1 downto 0);
      shift_and_add_mul_start_req : in std_logic;
      shift_and_add_mul_start_ack : out std_logic;
      shift_and_add_mul_fin_req   : in std_logic;
      shift_and_add_mul_fin_ack   : out std_logic;
      clk : in std_logic;
      reset : in std_logic); -- 
    -- 
  end component;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';
  signal shift_and_add_mul_a :  std_logic_vector(7 downto 0) := (others => '0');
  signal shift_and_add_mul_b :  std_logic_vector(7 downto 0) := (others => '0');
  signal shift_and_add_mul_product :   std_logic_vector(15 downto 0);
  signal shift_and_add_mul_tag_in: std_logic_vector(1 downto 0);
  signal shift_and_add_mul_tag_out: std_logic_vector(1 downto 0);
  signal shift_and_add_mul_start_req : std_logic := '0';
  signal shift_and_add_mul_start_ack : std_logic := '0';
  signal shift_and_add_mul_fin_req   : std_logic := '0';
  signal shift_and_add_mul_fin_ack   : std_logic := '0';
  -- 
begin --
  -- clock/reset generation 
  clk <= not clk after 5 ns;
  -- assert reset for four clocks.
  process
  begin --
    Vhpi_Initialize;
    wait until clk = '1';
    wait until clk = '1';
    wait until clk = '1';
    wait until clk = '1';
    reset <= '0';
    while true loop --
      wait until clk = '0';
      Vhpi_Listen;
      Vhpi_Send;
      --
    end loop;
    wait;
    --
  end process;
  -- connect all the top-level modules to Vhpi
  process
  variable val_string, obj_ref: VhpiString;
  begin --
    wait until reset = '0';
    -- let the DUT come out of reset.... give it 4 cycles.
    wait until clk = '1';
    wait until clk = '1';
    wait until clk = '1';
    wait until clk = '1';
    while true loop -- 
      wait until clk = '0';
      wait for 1 ns;
      obj_ref := Pack_String_To_VHPI_String("shift_and_add_mul req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      shift_and_add_mul_start_req <= To_Std_Logic(val_string);
      obj_ref := Pack_String_To_Vhpi_String("shift_and_add_mul 0");
      Vhpi_Get_Port_Value(obj_ref,val_string, 8);
      shift_and_add_mul_a <= Unpack_String(val_string,8);
      obj_ref := Pack_String_To_Vhpi_String("shift_and_add_mul 1");
      Vhpi_Get_Port_Value(obj_ref,val_string, 8);
      shift_and_add_mul_b <= Unpack_String(val_string,8);
      wait for 0 ns;
      if shift_and_add_mul_start_req = '1' then -- 
        while true loop --
          wait until clk = '1';
          if shift_and_add_mul_start_ack = '1' then exit; end if;--
        end loop; 
        shift_and_add_mul_start_req <= '0';
        shift_and_add_mul_fin_req <= '1';
        while true loop -- 
          wait until clk = '1';
          if shift_and_add_mul_fin_ack = '1' then exit; end if; --  
        end loop; 
        shift_and_add_mul_fin_req <= '0';
        -- 
      end if; 
      obj_ref := Pack_String_To_Vhpi_String("shift_and_add_mul ack");
      val_string := To_String(shift_and_add_mul_fin_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("shift_and_add_mul 0");
      val_string := Pack_SLV_To_Vhpi_String(shift_and_add_mul_product);
      Vhpi_Set_Port_Value(obj_ref,val_string,16);
      -- 
    end loop;
    --
  end process;
  ahir_system_instance: ahir_system -- 
    port map ( -- 
      shift_and_add_mul_a => shift_and_add_mul_a,
      shift_and_add_mul_b => shift_and_add_mul_b,
      shift_and_add_mul_product => shift_and_add_mul_product,
      shift_and_add_mul_tag_in => shift_and_add_mul_tag_in,
      shift_and_add_mul_tag_out => shift_and_add_mul_tag_out,
      shift_and_add_mul_start_req => shift_and_add_mul_start_req,
      shift_and_add_mul_start_ack => shift_and_add_mul_start_ack,
      shift_and_add_mul_fin_req  => shift_and_add_mul_fin_req, 
      shift_and_add_mul_fin_ack  => shift_and_add_mul_fin_ack ,
      clk => clk,
      reset => reset); -- 
  -- 
end VhpiLink;

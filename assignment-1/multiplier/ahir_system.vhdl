-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
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
entity shift_and_add_mul is -- 
  generic (tag_length : integer); 
  port ( -- 
    a_in : in  std_logic_vector(7 downto 0);
    b_in : in  std_logic_vector(7 downto 0);
    product : out  std_logic_vector(15 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity shift_and_add_mul;
architecture shift_and_add_mul_arch of shift_and_add_mul is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 16)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 16)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  signal a_in_buffer :  std_logic_vector(7 downto 0);
  signal a_in_update_enable: Boolean;
  signal b_in_buffer :  std_logic_vector(7 downto 0);
  signal b_in_update_enable: Boolean;
  -- output port buffer signals
  signal product_buffer :  std_logic_vector(15 downto 0);
  signal product_update_enable: Boolean;
  signal shift_and_add_mul_CP_3_start: Boolean;
  signal shift_and_add_mul_CP_3_symbol: Boolean;
  -- volatile/operator module components. 
  -- links between control-path and data-path
  signal ADD_u16_u16_55_inst_req_0 : boolean;
  signal ADD_u16_u16_55_inst_ack_0 : boolean;
  signal ADD_u16_u16_55_inst_req_1 : boolean;
  signal W_next_a_63_inst_ack_0 : boolean;
  signal ADD_u16_u16_55_inst_ack_1 : boolean;
  signal MUX_61_inst_req_0 : boolean;
  signal MUX_61_inst_ack_0 : boolean;
  signal MUX_61_inst_req_1 : boolean;
  signal MUX_61_inst_ack_1 : boolean;
  signal W_next_a_63_inst_req_0 : boolean;
  signal W_product_75_inst_ack_1 : boolean;
  signal W_next_a_63_inst_req_1 : boolean;
  signal W_next_a_63_inst_ack_1 : boolean;
  signal LSHR_u16_u16_69_inst_req_0 : boolean;
  signal LSHR_u16_u16_69_inst_ack_0 : boolean;
  signal LSHR_u16_u16_69_inst_req_1 : boolean;
  signal LSHR_u16_u16_69_inst_ack_1 : boolean;
  signal if_stmt_71_branch_req_0 : boolean;
  signal if_stmt_71_branch_ack_1 : boolean;
  signal if_stmt_71_branch_ack_0 : boolean;
  signal W_product_75_inst_req_0 : boolean;
  signal W_product_75_inst_ack_0 : boolean;
  signal W_product_75_inst_req_1 : boolean;
  signal type_cast_14_inst_req_0 : boolean;
  signal type_cast_14_inst_ack_0 : boolean;
  signal type_cast_14_inst_req_1 : boolean;
  signal type_cast_14_inst_ack_1 : boolean;
  signal phi_stmt_11_req_0 : boolean;
  signal type_cast_20_inst_req_0 : boolean;
  signal type_cast_20_inst_ack_0 : boolean;
  signal type_cast_20_inst_req_1 : boolean;
  signal type_cast_20_inst_ack_1 : boolean;
  signal phi_stmt_16_req_1 : boolean;
  signal phi_stmt_21_req_0 : boolean;
  signal phi_stmt_26_req_0 : boolean;
  signal next_a_65_15_buf_req_0 : boolean;
  signal next_a_65_15_buf_ack_0 : boolean;
  signal next_a_65_15_buf_req_1 : boolean;
  signal next_a_65_15_buf_ack_1 : boolean;
  signal phi_stmt_11_req_1 : boolean;
  signal next_b_70_18_buf_req_0 : boolean;
  signal next_b_70_18_buf_ack_0 : boolean;
  signal next_b_70_18_buf_req_1 : boolean;
  signal next_b_70_18_buf_ack_1 : boolean;
  signal phi_stmt_16_req_0 : boolean;
  signal next_sum_62_25_buf_req_0 : boolean;
  signal next_sum_62_25_buf_ack_0 : boolean;
  signal next_sum_62_25_buf_req_1 : boolean;
  signal next_sum_62_25_buf_ack_1 : boolean;
  signal phi_stmt_21_req_1 : boolean;
  signal next_count_56_30_buf_req_0 : boolean;
  signal next_count_56_30_buf_ack_0 : boolean;
  signal next_count_56_30_buf_req_1 : boolean;
  signal next_count_56_30_buf_ack_1 : boolean;
  signal phi_stmt_26_req_1 : boolean;
  signal phi_stmt_11_ack_0 : boolean;
  signal phi_stmt_16_ack_0 : boolean;
  signal phi_stmt_21_ack_0 : boolean;
  signal phi_stmt_26_ack_0 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "shift_and_add_mul_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 16) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(7 downto 0) <= a_in;
  a_in_buffer <= in_buffer_data_out(7 downto 0);
  in_buffer_data_in(15 downto 8) <= b_in;
  b_in_buffer <= in_buffer_data_out(15 downto 8);
  in_buffer_data_in(tag_length + 15 downto 16) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length + 15 downto 16);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  shift_and_add_mul_CP_3_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "shift_and_add_mul_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 16) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(15 downto 0) <= product_buffer;
  product <= out_buffer_data_out(15 downto 0);
  out_buffer_data_in(tag_length + 15 downto 16) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length + 15 downto 16);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= shift_and_add_mul_CP_3_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= shift_and_add_mul_CP_3_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= shift_and_add_mul_CP_3_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  shift_and_add_mul_CP_3: Block -- control-path 
    signal shift_and_add_mul_CP_3_elements: BooleanArray(43 downto 0);
    -- 
  begin -- 
    shift_and_add_mul_CP_3_elements(0) <= shift_and_add_mul_CP_3_start;
    shift_and_add_mul_CP_3_symbol <= shift_and_add_mul_CP_3_elements(14);
    -- CP-element group 0:  branch  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	15 
    -- CP-element group 0:  members (5) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_9/merge_stmt_10__entry__
      -- CP-element group 0: 	 branch_block_stmt_9/$entry
      -- CP-element group 0: 	 branch_block_stmt_9/branch_block_stmt_9__entry__
      -- CP-element group 0: 	 branch_block_stmt_9/merge_stmt_10_dead_link/$entry
      -- 
    -- CP-element group 1:  merge  fork  transition  place  output  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	43 
    -- CP-element group 1: successors 
    -- CP-element group 1: 	9 
    -- CP-element group 1: 	3 
    -- CP-element group 1: 	5 
    -- CP-element group 1: 	4 
    -- CP-element group 1: 	7 
    -- CP-element group 1: 	8 
    -- CP-element group 1: 	6 
    -- CP-element group 1: 	2 
    -- CP-element group 1:  members (27) 
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_update_start_
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_Sample/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_Sample/rr
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_Update/cr
      -- CP-element group 1: 	 branch_block_stmt_9/merge_stmt_10__exit__
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70__entry__
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_Update/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_Update/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_update_start_
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_start/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_start/req
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_complete/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_complete/req
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_update_start_
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_Sample/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_Sample/req
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_Update/req
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_update_start_
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_Sample/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_Sample/rr
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_Update/$entry
      -- CP-element group 1: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_Update/cr
      -- 
    rr_27_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_27_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(1), ack => ADD_u16_u16_55_inst_req_0); -- 
    cr_32_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_32_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(1), ack => ADD_u16_u16_55_inst_req_1); -- 
    req_41_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_41_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(1), ack => MUX_61_inst_req_0); -- 
    req_46_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_46_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(1), ack => MUX_61_inst_req_1); -- 
    req_55_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_55_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(1), ack => W_next_a_63_inst_req_0); -- 
    req_60_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_60_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(1), ack => W_next_a_63_inst_req_1); -- 
    rr_69_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_69_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(1), ack => LSHR_u16_u16_69_inst_req_0); -- 
    cr_74_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_74_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(1), ack => LSHR_u16_u16_69_inst_req_1); -- 
    shift_and_add_mul_CP_3_elements(1) <= shift_and_add_mul_CP_3_elements(43);
    -- CP-element group 2:  transition  input  bypass 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	1 
    -- CP-element group 2: successors 
    -- CP-element group 2:  members (3) 
      -- CP-element group 2: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_sample_completed_
      -- CP-element group 2: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_Sample/$exit
      -- CP-element group 2: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_Sample/ra
      -- 
    ra_28_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 2_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u16_u16_55_inst_ack_0, ack => shift_and_add_mul_CP_3_elements(2)); -- 
    -- CP-element group 3:  transition  input  bypass 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: 	1 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	10 
    -- CP-element group 3:  members (3) 
      -- CP-element group 3: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_update_completed_
      -- CP-element group 3: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_Update/$exit
      -- CP-element group 3: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/ADD_u16_u16_55_Update/ca
      -- 
    ca_33_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 3_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u16_u16_55_inst_ack_1, ack => shift_and_add_mul_CP_3_elements(3)); -- 
    -- CP-element group 4:  transition  input  bypass 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: 	1 
    -- CP-element group 4: successors 
    -- CP-element group 4:  members (3) 
      -- CP-element group 4: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_sample_completed_
      -- CP-element group 4: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_start/$exit
      -- CP-element group 4: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_start/ack
      -- 
    ack_42_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 4_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => MUX_61_inst_ack_0, ack => shift_and_add_mul_CP_3_elements(4)); -- 
    -- CP-element group 5:  transition  input  bypass 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	1 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	10 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_update_completed_
      -- CP-element group 5: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_complete/$exit
      -- CP-element group 5: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/MUX_61_complete/ack
      -- 
    ack_47_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 5_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => MUX_61_inst_ack_1, ack => shift_and_add_mul_CP_3_elements(5)); -- 
    -- CP-element group 6:  transition  input  bypass 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	1 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (3) 
      -- CP-element group 6: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_Sample/ack
      -- CP-element group 6: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_sample_completed_
      -- CP-element group 6: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_Sample/$exit
      -- 
    ack_56_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 6_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => W_next_a_63_inst_ack_0, ack => shift_and_add_mul_CP_3_elements(6)); -- 
    -- CP-element group 7:  transition  input  bypass 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	1 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	10 
    -- CP-element group 7:  members (3) 
      -- CP-element group 7: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_update_completed_
      -- CP-element group 7: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_Update/$exit
      -- CP-element group 7: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/assign_stmt_65_Update/ack
      -- 
    ack_61_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 7_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => W_next_a_63_inst_ack_1, ack => shift_and_add_mul_CP_3_elements(7)); -- 
    -- CP-element group 8:  transition  input  bypass 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	1 
    -- CP-element group 8: successors 
    -- CP-element group 8:  members (3) 
      -- CP-element group 8: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_sample_completed_
      -- CP-element group 8: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_Sample/$exit
      -- CP-element group 8: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_Sample/ra
      -- 
    ra_70_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 8_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => LSHR_u16_u16_69_inst_ack_0, ack => shift_and_add_mul_CP_3_elements(8)); -- 
    -- CP-element group 9:  transition  input  bypass 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: 	1 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	10 
    -- CP-element group 9:  members (3) 
      -- CP-element group 9: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_update_completed_
      -- CP-element group 9: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_Update/$exit
      -- CP-element group 9: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/LSHR_u16_u16_69_Update/ca
      -- 
    ca_75_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 9_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => LSHR_u16_u16_69_inst_ack_1, ack => shift_and_add_mul_CP_3_elements(9)); -- 
    -- CP-element group 10:  branch  join  transition  place  output  bypass 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	9 
    -- CP-element group 10: 	3 
    -- CP-element group 10: 	5 
    -- CP-element group 10: 	7 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	12 
    -- CP-element group 10: 	11 
    -- CP-element group 10:  members (10) 
      -- CP-element group 10: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70__exit__
      -- CP-element group 10: 	 branch_block_stmt_9/if_stmt_71__entry__
      -- CP-element group 10: 	 branch_block_stmt_9/assign_stmt_37_to_assign_stmt_70/$exit
      -- CP-element group 10: 	 branch_block_stmt_9/if_stmt_71_dead_link/$entry
      -- CP-element group 10: 	 branch_block_stmt_9/if_stmt_71_eval_test/$entry
      -- CP-element group 10: 	 branch_block_stmt_9/if_stmt_71_eval_test/$exit
      -- CP-element group 10: 	 branch_block_stmt_9/if_stmt_71_eval_test/branch_req
      -- CP-element group 10: 	 branch_block_stmt_9/R_continue_flag_72_place
      -- CP-element group 10: 	 branch_block_stmt_9/if_stmt_71_if_link/$entry
      -- CP-element group 10: 	 branch_block_stmt_9/if_stmt_71_else_link/$entry
      -- 
    branch_req_83_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " branch_req_83_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(10), ack => if_stmt_71_branch_req_0); -- 
    shift_and_add_mul_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(9) & shift_and_add_mul_CP_3_elements(3) & shift_and_add_mul_CP_3_elements(5) & shift_and_add_mul_CP_3_elements(7);
      gj_shift_and_add_mul_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  fork  transition  place  input  output  bypass 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	10 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	28 
    -- CP-element group 11: 	29 
    -- CP-element group 11: 	31 
    -- CP-element group 11: 	32 
    -- CP-element group 11: 	34 
    -- CP-element group 11: 	35 
    -- CP-element group 11: 	25 
    -- CP-element group 11: 	26 
    -- CP-element group 11:  members (32) 
      -- CP-element group 11: 	 branch_block_stmt_9/if_stmt_71_if_link/$exit
      -- CP-element group 11: 	 branch_block_stmt_9/if_stmt_71_if_link/if_choice_transition
      -- CP-element group 11: 	 branch_block_stmt_9/loopback
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/Sample/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/Sample/req
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/Update/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/Update/req
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/Sample/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/Sample/req
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/Update/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/Update/req
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/Sample/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/Sample/req
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/Update/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/Update/req
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/Sample/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/Sample/req
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/Update/$entry
      -- CP-element group 11: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/Update/req
      -- 
    if_choice_transition_88_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 11_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => if_stmt_71_branch_ack_1, ack => shift_and_add_mul_CP_3_elements(11)); -- 
    req_197_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_197_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(11), ack => next_a_65_15_buf_req_0); -- 
    req_202_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_202_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(11), ack => next_a_65_15_buf_req_1); -- 
    req_217_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_217_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(11), ack => next_b_70_18_buf_req_0); -- 
    req_222_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_222_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(11), ack => next_b_70_18_buf_req_1); -- 
    req_237_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_237_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(11), ack => next_sum_62_25_buf_req_0); -- 
    req_242_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_242_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(11), ack => next_sum_62_25_buf_req_1); -- 
    req_257_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_257_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(11), ack => next_count_56_30_buf_req_0); -- 
    req_262_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_262_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(11), ack => next_count_56_30_buf_req_1); -- 
    -- CP-element group 12:  fork  transition  place  input  output  bypass 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	10 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	14 
    -- CP-element group 12: 	13 
    -- CP-element group 12:  members (10) 
      -- CP-element group 12: 	 branch_block_stmt_9/if_stmt_71_else_link/$exit
      -- CP-element group 12: 	 branch_block_stmt_9/if_stmt_71_else_link/else_choice_transition
      -- CP-element group 12: 	 branch_block_stmt_9/assign_stmt_77__entry__
      -- CP-element group 12: 	 branch_block_stmt_9/assign_stmt_77/$entry
      -- CP-element group 12: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_sample_start_
      -- CP-element group 12: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_update_start_
      -- CP-element group 12: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_Sample/$entry
      -- CP-element group 12: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_Sample/req
      -- CP-element group 12: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_Update/$entry
      -- CP-element group 12: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_Update/req
      -- 
    else_choice_transition_92_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 12_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => if_stmt_71_branch_ack_0, ack => shift_and_add_mul_CP_3_elements(12)); -- 
    req_106_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_106_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(12), ack => W_product_75_inst_req_0); -- 
    req_111_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_111_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(12), ack => W_product_75_inst_req_1); -- 
    -- CP-element group 13:  transition  input  bypass 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13:  members (3) 
      -- CP-element group 13: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_sample_completed_
      -- CP-element group 13: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_Sample/$exit
      -- CP-element group 13: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_Sample/ack
      -- 
    ack_107_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 13_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => W_product_75_inst_ack_0, ack => shift_and_add_mul_CP_3_elements(13)); -- 
    -- CP-element group 14:  merge  transition  place  input  bypass 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	12 
    -- CP-element group 14: successors 
    -- CP-element group 14:  members (9) 
      -- CP-element group 14: 	 $exit
      -- CP-element group 14: 	 branch_block_stmt_9/$exit
      -- CP-element group 14: 	 branch_block_stmt_9/branch_block_stmt_9__exit__
      -- CP-element group 14: 	 branch_block_stmt_9/if_stmt_71__exit__
      -- CP-element group 14: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_Update/ack
      -- CP-element group 14: 	 branch_block_stmt_9/assign_stmt_77__exit__
      -- CP-element group 14: 	 branch_block_stmt_9/assign_stmt_77/$exit
      -- CP-element group 14: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_update_completed_
      -- CP-element group 14: 	 branch_block_stmt_9/assign_stmt_77/assign_stmt_77_Update/$exit
      -- 
    ack_112_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 14_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => W_product_75_inst_ack_1, ack => shift_and_add_mul_CP_3_elements(14)); -- 
    -- CP-element group 15:  fork  transition  output  bypass 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	0 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	20 
    -- CP-element group 15: 	19 
    -- CP-element group 15: 	17 
    -- CP-element group 15: 	16 
    -- CP-element group 15: 	22 
    -- CP-element group 15: 	23 
    -- CP-element group 15:  members (21) 
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/Sample/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/Sample/rr
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/Update/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/Update/cr
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/Sample/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/Sample/rr
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/Update/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/Update/cr
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_21/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_21/phi_stmt_21_sources/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_26/$entry
      -- CP-element group 15: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_26/phi_stmt_26_sources/$entry
      -- 
    rr_158_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_158_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(15), ack => type_cast_20_inst_req_0); -- 
    cr_163_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_163_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(15), ack => type_cast_20_inst_req_1); -- 
    rr_135_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_135_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(15), ack => type_cast_14_inst_req_0); -- 
    cr_140_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_140_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(15), ack => type_cast_14_inst_req_1); -- 
    shift_and_add_mul_CP_3_elements(15) <= shift_and_add_mul_CP_3_elements(0);
    -- CP-element group 16:  transition  input  bypass 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	15 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	18 
    -- CP-element group 16:  members (2) 
      -- CP-element group 16: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/Sample/$exit
      -- CP-element group 16: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/Sample/ra
      -- 
    ra_136_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 16_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_14_inst_ack_0, ack => shift_and_add_mul_CP_3_elements(16)); -- 
    -- CP-element group 17:  transition  input  bypass 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	15 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	18 
    -- CP-element group 17:  members (2) 
      -- CP-element group 17: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/Update/$exit
      -- CP-element group 17: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/Update/ca
      -- 
    ca_141_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 17_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_14_inst_ack_1, ack => shift_and_add_mul_CP_3_elements(17)); -- 
    -- CP-element group 18:  join  transition  output  bypass 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	17 
    -- CP-element group 18: 	16 
    -- CP-element group 18: successors 
    -- CP-element group 18: 	24 
    -- CP-element group 18:  members (5) 
      -- CP-element group 18: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/$exit
      -- CP-element group 18: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/$exit
      -- CP-element group 18: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/$exit
      -- CP-element group 18: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_sources/type_cast_14/SplitProtocol/$exit
      -- CP-element group 18: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_req
      -- 
    phi_stmt_11_req_142_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_11_req_142_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(18), ack => phi_stmt_11_req_0); -- 
    shift_and_add_mul_cp_element_group_18: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_18"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(17) & shift_and_add_mul_CP_3_elements(16);
      gj_shift_and_add_mul_cp_element_group_18 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(18), clk => clk, reset => reset); --
    end block;
    -- CP-element group 19:  transition  input  bypass 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: 	15 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	21 
    -- CP-element group 19:  members (2) 
      -- CP-element group 19: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/Sample/$exit
      -- CP-element group 19: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/Sample/ra
      -- 
    ra_159_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 19_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_20_inst_ack_0, ack => shift_and_add_mul_CP_3_elements(19)); -- 
    -- CP-element group 20:  transition  input  bypass 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	15 
    -- CP-element group 20: successors 
    -- CP-element group 20: 	21 
    -- CP-element group 20:  members (2) 
      -- CP-element group 20: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/Update/$exit
      -- CP-element group 20: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/Update/ca
      -- 
    ca_164_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 20_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => type_cast_20_inst_ack_1, ack => shift_and_add_mul_CP_3_elements(20)); -- 
    -- CP-element group 21:  join  transition  output  bypass 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: 	20 
    -- CP-element group 21: 	19 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	24 
    -- CP-element group 21:  members (5) 
      -- CP-element group 21: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/$exit
      -- CP-element group 21: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/$exit
      -- CP-element group 21: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/$exit
      -- CP-element group 21: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_sources/type_cast_20/SplitProtocol/$exit
      -- CP-element group 21: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_16/phi_stmt_16_req
      -- 
    phi_stmt_16_req_165_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_16_req_165_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(21), ack => phi_stmt_16_req_1); -- 
    shift_and_add_mul_cp_element_group_21: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_21"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(20) & shift_and_add_mul_CP_3_elements(19);
      gj_shift_and_add_mul_cp_element_group_21 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(21), clk => clk, reset => reset); --
    end block;
    -- CP-element group 22:  transition  output  delay-element  bypass 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	15 
    -- CP-element group 22: successors 
    -- CP-element group 22: 	24 
    -- CP-element group 22:  members (4) 
      -- CP-element group 22: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_21/$exit
      -- CP-element group 22: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_21/phi_stmt_21_sources/$exit
      -- CP-element group 22: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_21/phi_stmt_21_sources/type_cast_24_konst_delay_trans
      -- CP-element group 22: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_21/phi_stmt_21_req
      -- 
    phi_stmt_21_req_173_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_21_req_173_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(22), ack => phi_stmt_21_req_0); -- 
    -- Element group shift_and_add_mul_CP_3_elements(22) is a control-delay.
    cp_element_22_delay: control_delay_element  generic map(name => " 22_delay", delay_value => 1)  port map(req => shift_and_add_mul_CP_3_elements(15), ack => shift_and_add_mul_CP_3_elements(22), clk => clk, reset =>reset);
    -- CP-element group 23:  transition  output  delay-element  bypass 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: 	15 
    -- CP-element group 23: successors 
    -- CP-element group 23: 	24 
    -- CP-element group 23:  members (4) 
      -- CP-element group 23: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_26/$exit
      -- CP-element group 23: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_26/phi_stmt_26_sources/$exit
      -- CP-element group 23: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_26/phi_stmt_26_sources/type_cast_29_konst_delay_trans
      -- CP-element group 23: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_26/phi_stmt_26_req
      -- 
    phi_stmt_26_req_181_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_26_req_181_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(23), ack => phi_stmt_26_req_0); -- 
    -- Element group shift_and_add_mul_CP_3_elements(23) is a control-delay.
    cp_element_23_delay: control_delay_element  generic map(name => " 23_delay", delay_value => 1)  port map(req => shift_and_add_mul_CP_3_elements(15), ack => shift_and_add_mul_CP_3_elements(23), clk => clk, reset =>reset);
    -- CP-element group 24:  join  transition  bypass 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	21 
    -- CP-element group 24: 	18 
    -- CP-element group 24: 	22 
    -- CP-element group 24: 	23 
    -- CP-element group 24: successors 
    -- CP-element group 24: 	38 
    -- CP-element group 24:  members (1) 
      -- CP-element group 24: 	 branch_block_stmt_9/merge_stmt_10__entry___PhiReq/$exit
      -- 
    shift_and_add_mul_cp_element_group_24: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_24"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(21) & shift_and_add_mul_CP_3_elements(18) & shift_and_add_mul_CP_3_elements(22) & shift_and_add_mul_CP_3_elements(23);
      gj_shift_and_add_mul_cp_element_group_24 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(24), clk => clk, reset => reset); --
    end block;
    -- CP-element group 25:  transition  input  bypass 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: 	11 
    -- CP-element group 25: successors 
    -- CP-element group 25: 	27 
    -- CP-element group 25:  members (2) 
      -- CP-element group 25: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/Sample/$exit
      -- CP-element group 25: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/Sample/ack
      -- 
    ack_198_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 25_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_a_65_15_buf_ack_0, ack => shift_and_add_mul_CP_3_elements(25)); -- 
    -- CP-element group 26:  transition  input  bypass 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: 	11 
    -- CP-element group 26: successors 
    -- CP-element group 26: 	27 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/Update/$exit
      -- CP-element group 26: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/Update/ack
      -- 
    ack_203_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 26_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_a_65_15_buf_ack_1, ack => shift_and_add_mul_CP_3_elements(26)); -- 
    -- CP-element group 27:  join  transition  output  bypass 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: 	25 
    -- CP-element group 27: 	26 
    -- CP-element group 27: successors 
    -- CP-element group 27: 	37 
    -- CP-element group 27:  members (4) 
      -- CP-element group 27: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/$exit
      -- CP-element group 27: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/$exit
      -- CP-element group 27: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_sources/Interlock/$exit
      -- CP-element group 27: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_req
      -- 
    phi_stmt_11_req_204_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_11_req_204_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(27), ack => phi_stmt_11_req_1); -- 
    shift_and_add_mul_cp_element_group_27: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_27"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(25) & shift_and_add_mul_CP_3_elements(26);
      gj_shift_and_add_mul_cp_element_group_27 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(27), clk => clk, reset => reset); --
    end block;
    -- CP-element group 28:  transition  input  bypass 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: 	11 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	30 
    -- CP-element group 28:  members (2) 
      -- CP-element group 28: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/Sample/$exit
      -- CP-element group 28: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/Sample/ack
      -- 
    ack_218_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 28_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_b_70_18_buf_ack_0, ack => shift_and_add_mul_CP_3_elements(28)); -- 
    -- CP-element group 29:  transition  input  bypass 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: 	11 
    -- CP-element group 29: successors 
    -- CP-element group 29: 	30 
    -- CP-element group 29:  members (2) 
      -- CP-element group 29: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/Update/$exit
      -- CP-element group 29: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/Update/ack
      -- 
    ack_223_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 29_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_b_70_18_buf_ack_1, ack => shift_and_add_mul_CP_3_elements(29)); -- 
    -- CP-element group 30:  join  transition  output  bypass 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: 	28 
    -- CP-element group 30: 	29 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	37 
    -- CP-element group 30:  members (4) 
      -- CP-element group 30: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/$exit
      -- CP-element group 30: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/$exit
      -- CP-element group 30: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_sources/Interlock/$exit
      -- CP-element group 30: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_16/phi_stmt_16_req
      -- 
    phi_stmt_16_req_224_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_16_req_224_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(30), ack => phi_stmt_16_req_0); -- 
    shift_and_add_mul_cp_element_group_30: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_30"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(28) & shift_and_add_mul_CP_3_elements(29);
      gj_shift_and_add_mul_cp_element_group_30 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(30), clk => clk, reset => reset); --
    end block;
    -- CP-element group 31:  transition  input  bypass 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: 	11 
    -- CP-element group 31: successors 
    -- CP-element group 31: 	33 
    -- CP-element group 31:  members (2) 
      -- CP-element group 31: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/Sample/$exit
      -- CP-element group 31: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/Sample/ack
      -- 
    ack_238_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 31_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_sum_62_25_buf_ack_0, ack => shift_and_add_mul_CP_3_elements(31)); -- 
    -- CP-element group 32:  transition  input  bypass 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: 	11 
    -- CP-element group 32: successors 
    -- CP-element group 32: 	33 
    -- CP-element group 32:  members (2) 
      -- CP-element group 32: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/Update/$exit
      -- CP-element group 32: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/Update/ack
      -- 
    ack_243_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 32_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_sum_62_25_buf_ack_1, ack => shift_and_add_mul_CP_3_elements(32)); -- 
    -- CP-element group 33:  join  transition  output  bypass 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	31 
    -- CP-element group 33: 	32 
    -- CP-element group 33: successors 
    -- CP-element group 33: 	37 
    -- CP-element group 33:  members (4) 
      -- CP-element group 33: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/$exit
      -- CP-element group 33: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/$exit
      -- CP-element group 33: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_sources/Interlock/$exit
      -- CP-element group 33: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_21/phi_stmt_21_req
      -- 
    phi_stmt_21_req_244_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_21_req_244_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(33), ack => phi_stmt_21_req_1); -- 
    shift_and_add_mul_cp_element_group_33: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_33"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(31) & shift_and_add_mul_CP_3_elements(32);
      gj_shift_and_add_mul_cp_element_group_33 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(33), clk => clk, reset => reset); --
    end block;
    -- CP-element group 34:  transition  input  bypass 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	11 
    -- CP-element group 34: successors 
    -- CP-element group 34: 	36 
    -- CP-element group 34:  members (2) 
      -- CP-element group 34: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/Sample/$exit
      -- CP-element group 34: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/Sample/ack
      -- 
    ack_258_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 34_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_56_30_buf_ack_0, ack => shift_and_add_mul_CP_3_elements(34)); -- 
    -- CP-element group 35:  transition  input  bypass 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	11 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	36 
    -- CP-element group 35:  members (2) 
      -- CP-element group 35: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/Update/$exit
      -- CP-element group 35: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/Update/ack
      -- 
    ack_263_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 35_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_56_30_buf_ack_1, ack => shift_and_add_mul_CP_3_elements(35)); -- 
    -- CP-element group 36:  join  transition  output  bypass 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	34 
    -- CP-element group 36: 	35 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	37 
    -- CP-element group 36:  members (4) 
      -- CP-element group 36: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/$exit
      -- CP-element group 36: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/$exit
      -- CP-element group 36: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_sources/Interlock/$exit
      -- CP-element group 36: 	 branch_block_stmt_9/loopback_PhiReq/phi_stmt_26/phi_stmt_26_req
      -- 
    phi_stmt_26_req_264_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_26_req_264_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_add_mul_CP_3_elements(36), ack => phi_stmt_26_req_1); -- 
    shift_and_add_mul_cp_element_group_36: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_36"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(34) & shift_and_add_mul_CP_3_elements(35);
      gj_shift_and_add_mul_cp_element_group_36 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(36), clk => clk, reset => reset); --
    end block;
    -- CP-element group 37:  join  transition  bypass 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	30 
    -- CP-element group 37: 	33 
    -- CP-element group 37: 	36 
    -- CP-element group 37: 	27 
    -- CP-element group 37: successors 
    -- CP-element group 37: 	38 
    -- CP-element group 37:  members (1) 
      -- CP-element group 37: 	 branch_block_stmt_9/loopback_PhiReq/$exit
      -- 
    shift_and_add_mul_cp_element_group_37: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_37"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(30) & shift_and_add_mul_CP_3_elements(33) & shift_and_add_mul_CP_3_elements(36) & shift_and_add_mul_CP_3_elements(27);
      gj_shift_and_add_mul_cp_element_group_37 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(37), clk => clk, reset => reset); --
    end block;
    -- CP-element group 38:  merge  fork  transition  place  bypass 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: 	37 
    -- CP-element group 38: 	24 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	39 
    -- CP-element group 38: 	40 
    -- CP-element group 38: 	41 
    -- CP-element group 38: 	42 
    -- CP-element group 38:  members (2) 
      -- CP-element group 38: 	 branch_block_stmt_9/merge_stmt_10_PhiReqMerge
      -- CP-element group 38: 	 branch_block_stmt_9/merge_stmt_10_PhiAck/$entry
      -- 
    shift_and_add_mul_CP_3_elements(38) <= OrReduce(shift_and_add_mul_CP_3_elements(37) & shift_and_add_mul_CP_3_elements(24));
    -- CP-element group 39:  transition  input  bypass 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	38 
    -- CP-element group 39: successors 
    -- CP-element group 39: 	43 
    -- CP-element group 39:  members (1) 
      -- CP-element group 39: 	 branch_block_stmt_9/merge_stmt_10_PhiAck/phi_stmt_11_ack
      -- 
    phi_stmt_11_ack_269_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 39_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_11_ack_0, ack => shift_and_add_mul_CP_3_elements(39)); -- 
    -- CP-element group 40:  transition  input  bypass 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: 	38 
    -- CP-element group 40: successors 
    -- CP-element group 40: 	43 
    -- CP-element group 40:  members (1) 
      -- CP-element group 40: 	 branch_block_stmt_9/merge_stmt_10_PhiAck/phi_stmt_16_ack
      -- 
    phi_stmt_16_ack_270_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 40_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_16_ack_0, ack => shift_and_add_mul_CP_3_elements(40)); -- 
    -- CP-element group 41:  transition  input  bypass 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: 	38 
    -- CP-element group 41: successors 
    -- CP-element group 41: 	43 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_9/merge_stmt_10_PhiAck/phi_stmt_21_ack
      -- 
    phi_stmt_21_ack_271_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 41_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_21_ack_0, ack => shift_and_add_mul_CP_3_elements(41)); -- 
    -- CP-element group 42:  transition  input  bypass 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: 	38 
    -- CP-element group 42: successors 
    -- CP-element group 42: 	43 
    -- CP-element group 42:  members (1) 
      -- CP-element group 42: 	 branch_block_stmt_9/merge_stmt_10_PhiAck/phi_stmt_26_ack
      -- 
    phi_stmt_26_ack_272_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 42_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_26_ack_0, ack => shift_and_add_mul_CP_3_elements(42)); -- 
    -- CP-element group 43:  join  transition  bypass 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: 	39 
    -- CP-element group 43: 	40 
    -- CP-element group 43: 	41 
    -- CP-element group 43: 	42 
    -- CP-element group 43: successors 
    -- CP-element group 43: 	1 
    -- CP-element group 43:  members (1) 
      -- CP-element group 43: 	 branch_block_stmt_9/merge_stmt_10_PhiAck/$exit
      -- 
    shift_and_add_mul_cp_element_group_43: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 37) := "shift_and_add_mul_cp_element_group_43"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= shift_and_add_mul_CP_3_elements(39) & shift_and_add_mul_CP_3_elements(40) & shift_and_add_mul_CP_3_elements(41) & shift_and_add_mul_CP_3_elements(42);
      gj_shift_and_add_mul_cp_element_group_43 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_add_mul_CP_3_elements(43), clk => clk, reset => reset); --
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal AND_u16_u16_41_wire : std_logic_vector(15 downto 0);
    signal SHL_u16_u16_49_wire : std_logic_vector(15 downto 0);
    signal a_11 : std_logic_vector(15 downto 0);
    signal add_shifted_44 : std_logic_vector(0 downto 0);
    signal b_16 : std_logic_vector(15 downto 0);
    signal continue_flag_37 : std_logic_vector(0 downto 0);
    signal count_26 : std_logic_vector(15 downto 0);
    signal konst_34_wire_constant : std_logic_vector(15 downto 0);
    signal konst_40_wire_constant : std_logic_vector(15 downto 0);
    signal konst_42_wire_constant : std_logic_vector(15 downto 0);
    signal konst_54_wire_constant : std_logic_vector(15 downto 0);
    signal konst_68_wire_constant : std_logic_vector(15 downto 0);
    signal next_a_65 : std_logic_vector(15 downto 0);
    signal next_a_65_15_buffered : std_logic_vector(15 downto 0);
    signal next_b_70 : std_logic_vector(15 downto 0);
    signal next_b_70_18_buffered : std_logic_vector(15 downto 0);
    signal next_count_56 : std_logic_vector(15 downto 0);
    signal next_count_56_30_buffered : std_logic_vector(15 downto 0);
    signal next_sum_62 : std_logic_vector(15 downto 0);
    signal next_sum_62_25_buffered : std_logic_vector(15 downto 0);
    signal shifted_sum_51 : std_logic_vector(15 downto 0);
    signal sum_21 : std_logic_vector(15 downto 0);
    signal type_cast_14_wire : std_logic_vector(15 downto 0);
    signal type_cast_20_wire : std_logic_vector(15 downto 0);
    signal type_cast_24_wire_constant : std_logic_vector(15 downto 0);
    signal type_cast_29_wire_constant : std_logic_vector(15 downto 0);
    -- 
  begin -- 
    konst_34_wire_constant <= "0000000000000000";
    konst_40_wire_constant <= "0000000000000001";
    konst_42_wire_constant <= "0000000000000000";
    konst_54_wire_constant <= "0000000000000001";
    konst_68_wire_constant <= "0000000000000001";
    type_cast_24_wire_constant <= "0000000000000000";
    type_cast_29_wire_constant <= "0000000000000000";
    phi_stmt_11: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_14_wire & next_a_65_15_buffered;
      req <= phi_stmt_11_req_0 & phi_stmt_11_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_11",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_11_ack_0,
          idata => idata,
          odata => a_11,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_11
    phi_stmt_16: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= next_b_70_18_buffered & type_cast_20_wire;
      req <= phi_stmt_16_req_0 & phi_stmt_16_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_16",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_16_ack_0,
          idata => idata,
          odata => b_16,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_16
    phi_stmt_21: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_24_wire_constant & next_sum_62_25_buffered;
      req <= phi_stmt_21_req_0 & phi_stmt_21_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_21",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_21_ack_0,
          idata => idata,
          odata => sum_21,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_21
    phi_stmt_26: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_29_wire_constant & next_count_56_30_buffered;
      req <= phi_stmt_26_req_0 & phi_stmt_26_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_26",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_26_ack_0,
          idata => idata,
          odata => count_26,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_26
    MUX_61_inst_block : block -- 
      signal sample_req, sample_ack, update_req, update_ack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      sample_req(0) <= MUX_61_inst_req_0;
      MUX_61_inst_ack_0<= sample_ack(0);
      update_req(0) <= MUX_61_inst_req_1;
      MUX_61_inst_ack_1<= update_ack(0);
      MUX_61_inst: SelectSplitProtocol generic map(name => "MUX_61_inst", data_width => 16, buffering => 1, flow_through => false, full_rate => false) -- 
        port map( x => shifted_sum_51, y => sum_21, sel => add_shifted_44, z => next_sum_62, sample_req => sample_req(0), sample_ack => sample_ack(0), update_req => update_req(0), update_ack => update_ack(0), clk => clk, reset => reset); -- 
      -- 
    end block;
    W_next_a_63_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= W_next_a_63_inst_req_0;
      W_next_a_63_inst_ack_0<= wack(0);
      rreq(0) <= W_next_a_63_inst_req_1;
      W_next_a_63_inst_ack_1<= rack(0);
      W_next_a_63_inst : InterlockBuffer generic map ( -- 
        name => "W_next_a_63_inst",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => a_11,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_a_65,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    W_product_75_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= W_product_75_inst_req_0;
      W_product_75_inst_ack_0<= wack(0);
      rreq(0) <= W_product_75_inst_req_1;
      W_product_75_inst_ack_1<= rack(0);
      W_product_75_inst : InterlockBuffer generic map ( -- 
        name => "W_product_75_inst",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => sum_21,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => product_buffer,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_a_65_15_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_a_65_15_buf_req_0;
      next_a_65_15_buf_ack_0<= wack(0);
      rreq(0) <= next_a_65_15_buf_req_1;
      next_a_65_15_buf_ack_1<= rack(0);
      next_a_65_15_buf : InterlockBuffer generic map ( -- 
        name => "next_a_65_15_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_a_65,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_a_65_15_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_b_70_18_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_b_70_18_buf_req_0;
      next_b_70_18_buf_ack_0<= wack(0);
      rreq(0) <= next_b_70_18_buf_req_1;
      next_b_70_18_buf_ack_1<= rack(0);
      next_b_70_18_buf : InterlockBuffer generic map ( -- 
        name => "next_b_70_18_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_b_70,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_b_70_18_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_count_56_30_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_count_56_30_buf_req_0;
      next_count_56_30_buf_ack_0<= wack(0);
      rreq(0) <= next_count_56_30_buf_req_1;
      next_count_56_30_buf_ack_1<= rack(0);
      next_count_56_30_buf : InterlockBuffer generic map ( -- 
        name => "next_count_56_30_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_count_56,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_count_56_30_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_sum_62_25_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_sum_62_25_buf_req_0;
      next_sum_62_25_buf_ack_0<= wack(0);
      rreq(0) <= next_sum_62_25_buf_req_1;
      next_sum_62_25_buf_ack_1<= rack(0);
      next_sum_62_25_buf : InterlockBuffer generic map ( -- 
        name => "next_sum_62_25_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_sum_62,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_sum_62_25_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    type_cast_14_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= type_cast_14_inst_req_0;
      type_cast_14_inst_ack_0<= wack(0);
      rreq(0) <= type_cast_14_inst_req_1;
      type_cast_14_inst_ack_1<= rack(0);
      type_cast_14_inst : InterlockBuffer generic map ( -- 
        name => "type_cast_14_inst",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => a_in_buffer,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => type_cast_14_wire,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    type_cast_20_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= type_cast_20_inst_req_0;
      type_cast_20_inst_ack_0<= wack(0);
      rreq(0) <= type_cast_20_inst_req_1;
      type_cast_20_inst_ack_1<= rack(0);
      type_cast_20_inst : InterlockBuffer generic map ( -- 
        name => "type_cast_20_inst",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => b_in_buffer,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => type_cast_20_wire,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    if_stmt_71_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= continue_flag_37;
      branch_instance: BranchBase -- 
        generic map( name => "if_stmt_71_branch", condition_width => 1,  bypass_flag => false)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_71_branch_req_0,
          ack0 => if_stmt_71_branch_ack_0,
          ack1 => if_stmt_71_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- binary operator ADD_u16_u16_50_inst
    process(sum_21, SHL_u16_u16_49_wire) -- 
      variable tmp_var : std_logic_vector(15 downto 0); -- 
    begin -- 
      ApIntAdd_proc(sum_21, SHL_u16_u16_49_wire, tmp_var);
      shifted_sum_51 <= tmp_var; --
    end process;
    -- shared split operator group (1) : ADD_u16_u16_55_inst 
    ApIntAdd_group_1: Block -- 
      signal data_in: std_logic_vector(15 downto 0);
      signal data_out: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      data_in <= count_26;
      next_count_56 <= data_out(15 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ADD_u16_u16_55_inst_req_0;
      ADD_u16_u16_55_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ADD_u16_u16_55_inst_req_1;
      ADD_u16_u16_55_inst_ack_1 <= ackR_unguarded(0);
      ApIntAdd_group_1_gI: SplitGuardInterface generic map(name => "ApIntAdd_group_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          name => "ApIntAdd_group_1",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 16,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 16,
          constant_operand => "0000000000000001",
          constant_width => 16,
          buffering  => 1,
          flow_through => false,
          full_rate  => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- binary operator AND_u16_u16_41_inst
    process(b_16) -- 
      variable tmp_var : std_logic_vector(15 downto 0); -- 
    begin -- 
      ApIntAnd_proc(b_16, konst_40_wire_constant, tmp_var);
      AND_u16_u16_41_wire <= tmp_var; --
    end process;
    -- shared split operator group (3) : LSHR_u16_u16_69_inst 
    ApIntLSHR_group_3: Block -- 
      signal data_in: std_logic_vector(15 downto 0);
      signal data_out: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      data_in <= b_16;
      next_b_70 <= data_out(15 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= LSHR_u16_u16_69_inst_req_0;
      LSHR_u16_u16_69_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= LSHR_u16_u16_69_inst_req_1;
      LSHR_u16_u16_69_inst_ack_1 <= ackR_unguarded(0);
      ApIntLSHR_group_3_gI: SplitGuardInterface generic map(name => "ApIntLSHR_group_3_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          name => "ApIntLSHR_group_3",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 16,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 16,
          constant_operand => "0000000000000001",
          constant_width => 16,
          buffering  => 1,
          flow_through => false,
          full_rate  => false,
          use_constant  => true
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- binary operator NEQ_u16_u1_35_inst
    process(b_16) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntNe_proc(b_16, konst_34_wire_constant, tmp_var);
      continue_flag_37 <= tmp_var; --
    end process;
    -- binary operator NEQ_u16_u1_43_inst
    process(AND_u16_u16_41_wire) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntNe_proc(AND_u16_u16_41_wire, konst_42_wire_constant, tmp_var);
      add_shifted_44 <= tmp_var; --
    end process;
    -- binary operator SHL_u16_u16_49_inst
    process(a_11, count_26) -- 
      variable tmp_var : std_logic_vector(15 downto 0); -- 
    begin -- 
      ApIntSHL_proc(a_11, count_26, tmp_var);
      SHL_u16_u16_49_wire <= tmp_var; --
    end process;
    -- 
  end Block; -- data_path
  -- 
end shift_and_add_mul_arch;
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
entity ahir_system is  -- system 
  port (-- 
    shift_and_add_mul_a_in : in  std_logic_vector(7 downto 0);
    shift_and_add_mul_b_in : in  std_logic_vector(7 downto 0);
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
end entity; 
architecture ahir_system_arch  of ahir_system is -- system-architecture 
  -- declarations related to module shift_and_add_mul
  component shift_and_add_mul is -- 
    generic (tag_length : integer); 
    port ( -- 
      a_in : in  std_logic_vector(7 downto 0);
      b_in : in  std_logic_vector(7 downto 0);
      product : out  std_logic_vector(15 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- gated clock signal declarations.
  -- 
begin -- 
  -- module shift_and_add_mul
  shift_and_add_mul_instance:shift_and_add_mul-- 
    generic map(tag_length => 2)
    port map(-- 
      a_in => shift_and_add_mul_a_in,
      b_in => shift_and_add_mul_b_in,
      product => shift_and_add_mul_product,
      start_req => shift_and_add_mul_start_req,
      start_ack => shift_and_add_mul_start_ack,
      fin_req => shift_and_add_mul_fin_req,
      fin_ack => shift_and_add_mul_fin_ack,
      clk => clk,
      reset => reset,
      tag_in => shift_and_add_mul_tag_in,
      tag_out => shift_and_add_mul_tag_out-- 
    ); -- 
  -- gated clock generators 
  -- 
end ahir_system_arch;
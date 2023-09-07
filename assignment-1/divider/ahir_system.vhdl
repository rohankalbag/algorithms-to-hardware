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
entity shift_and_subtract_div is -- 
  generic (tag_length : integer); 
  port ( -- 
    a : in  std_logic_vector(7 downto 0);
    b : in  std_logic_vector(7 downto 0);
    quotient : out  std_logic_vector(7 downto 0);
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
end entity shift_and_subtract_div;
architecture shift_and_subtract_div_arch of shift_and_subtract_div is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 16)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 8)-1 downto 0);
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
  signal a_buffer :  std_logic_vector(7 downto 0);
  signal a_update_enable: Boolean;
  signal b_buffer :  std_logic_vector(7 downto 0);
  signal b_update_enable: Boolean;
  -- output port buffer signals
  signal quotient_buffer :  std_logic_vector(7 downto 0);
  signal quotient_update_enable: Boolean;
  signal shift_and_subtract_div_CP_3_start: Boolean;
  signal shift_and_subtract_div_CP_3_symbol: Boolean;
  -- volatile/operator module components. 
  -- links between control-path and data-path
  signal ADD_u8_u8_73_inst_req_0 : boolean;
  signal ADD_u8_u8_73_inst_ack_0 : boolean;
  signal ADD_u8_u8_73_inst_req_1 : boolean;
  signal MUX_87_inst_ack_0 : boolean;
  signal ADD_u8_u8_73_inst_ack_1 : boolean;
  signal MUX_81_inst_req_0 : boolean;
  signal MUX_81_inst_ack_0 : boolean;
  signal MUX_81_inst_req_1 : boolean;
  signal MUX_81_inst_ack_1 : boolean;
  signal MUX_87_inst_req_0 : boolean;
  signal MUX_87_inst_req_1 : boolean;
  signal MUX_87_inst_ack_1 : boolean;
  signal W_next_a_89_inst_req_0 : boolean;
  signal W_next_a_89_inst_ack_0 : boolean;
  signal W_next_a_89_inst_req_1 : boolean;
  signal W_next_a_89_inst_ack_1 : boolean;
  signal LSHR_u8_u8_95_inst_req_0 : boolean;
  signal LSHR_u8_u8_95_inst_ack_0 : boolean;
  signal LSHR_u8_u8_95_inst_req_1 : boolean;
  signal LSHR_u8_u8_95_inst_ack_1 : boolean;
  signal if_stmt_97_branch_req_0 : boolean;
  signal if_stmt_97_branch_ack_1 : boolean;
  signal if_stmt_97_branch_ack_0 : boolean;
  signal phi_stmt_23_req_1 : boolean;
  signal W_quotient_101_inst_req_0 : boolean;
  signal W_quotient_101_inst_ack_0 : boolean;
  signal W_quotient_101_inst_req_1 : boolean;
  signal W_quotient_101_inst_ack_1 : boolean;
  signal a_12_buf_req_0 : boolean;
  signal a_12_buf_ack_0 : boolean;
  signal a_12_buf_req_1 : boolean;
  signal a_12_buf_ack_1 : boolean;
  signal phi_stmt_10_req_0 : boolean;
  signal b_16_buf_req_0 : boolean;
  signal b_16_buf_ack_0 : boolean;
  signal b_16_buf_req_1 : boolean;
  signal b_16_buf_ack_1 : boolean;
  signal phi_stmt_14_req_0 : boolean;
  signal phi_stmt_18_req_1 : boolean;
  signal phi_stmt_23_req_0 : boolean;
  signal phi_stmt_28_req_0 : boolean;
  signal next_a_91_13_buf_req_0 : boolean;
  signal next_a_91_13_buf_ack_0 : boolean;
  signal next_a_91_13_buf_req_1 : boolean;
  signal next_a_91_13_buf_ack_1 : boolean;
  signal phi_stmt_10_req_1 : boolean;
  signal next_b_96_17_buf_req_0 : boolean;
  signal next_b_96_17_buf_ack_0 : boolean;
  signal next_b_96_17_buf_req_1 : boolean;
  signal next_b_96_17_buf_ack_1 : boolean;
  signal phi_stmt_14_req_1 : boolean;
  signal next_quotient_88_20_buf_req_0 : boolean;
  signal next_quotient_88_20_buf_ack_0 : boolean;
  signal next_quotient_88_20_buf_req_1 : boolean;
  signal next_quotient_88_20_buf_ack_1 : boolean;
  signal phi_stmt_18_req_0 : boolean;
  signal next_remainder_82_27_buf_req_0 : boolean;
  signal next_remainder_82_27_buf_ack_0 : boolean;
  signal next_remainder_82_27_buf_req_1 : boolean;
  signal next_remainder_82_27_buf_ack_1 : boolean;
  signal next_count_74_32_buf_req_0 : boolean;
  signal next_count_74_32_buf_ack_0 : boolean;
  signal next_count_74_32_buf_req_1 : boolean;
  signal next_count_74_32_buf_ack_1 : boolean;
  signal phi_stmt_28_req_1 : boolean;
  signal phi_stmt_10_ack_0 : boolean;
  signal phi_stmt_14_ack_0 : boolean;
  signal phi_stmt_18_ack_0 : boolean;
  signal phi_stmt_23_ack_0 : boolean;
  signal phi_stmt_28_ack_0 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "shift_and_subtract_div_input_buffer", -- 
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
  in_buffer_data_in(7 downto 0) <= a;
  a_buffer <= in_buffer_data_out(7 downto 0);
  in_buffer_data_in(15 downto 8) <= b;
  b_buffer <= in_buffer_data_out(15 downto 8);
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
  shift_and_subtract_div_CP_3_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "shift_and_subtract_div_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 8) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(7 downto 0) <= quotient_buffer;
  quotient <= out_buffer_data_out(7 downto 0);
  out_buffer_data_in(tag_length + 7 downto 8) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length + 7 downto 8);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= shift_and_subtract_div_CP_3_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
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
    preds <= shift_and_subtract_div_CP_3_start & tag_ilock_write_ack_symbol;
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
    preds <= shift_and_subtract_div_CP_3_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  shift_and_subtract_div_CP_3: Block -- control-path 
    signal shift_and_subtract_div_CP_3_elements: BooleanArray(50 downto 0);
    -- 
  begin -- 
    shift_and_subtract_div_CP_3_elements(0) <= shift_and_subtract_div_CP_3_start;
    shift_and_subtract_div_CP_3_symbol <= shift_and_subtract_div_CP_3_elements(16);
    -- CP-element group 0:  branch  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	17 
    -- CP-element group 0:  members (5) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_8/merge_stmt_9__entry__
      -- CP-element group 0: 	 branch_block_stmt_8/$entry
      -- CP-element group 0: 	 branch_block_stmt_8/branch_block_stmt_8__entry__
      -- CP-element group 0: 	 branch_block_stmt_8/merge_stmt_9_dead_link/$entry
      -- 
    -- CP-element group 1:  merge  fork  transition  place  output  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	50 
    -- CP-element group 1: successors 
    -- CP-element group 1: 	9 
    -- CP-element group 1: 	3 
    -- CP-element group 1: 	4 
    -- CP-element group 1: 	8 
    -- CP-element group 1: 	5 
    -- CP-element group 1: 	2 
    -- CP-element group 1: 	7 
    -- CP-element group 1: 	6 
    -- CP-element group 1: 	11 
    -- CP-element group 1: 	10 
    -- CP-element group 1:  members (33) 
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_update_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_Sample/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_Sample/rr
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_Update/cr
      -- CP-element group 1: 	 branch_block_stmt_8/merge_stmt_9__exit__
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96__entry__
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_Update/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_update_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_start/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_start/req
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_complete/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_complete/req
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_update_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_start/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_start/req
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_complete/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_complete/req
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_update_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_Sample/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_Sample/req
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_Update/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_Update/req
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_sample_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_update_start_
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_Sample/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_Sample/rr
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_Update/$entry
      -- CP-element group 1: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_Update/cr
      -- 
    rr_27_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_27_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => ADD_u8_u8_73_inst_req_0); -- 
    cr_32_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_32_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => ADD_u8_u8_73_inst_req_1); -- 
    req_41_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_41_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => MUX_81_inst_req_0); -- 
    req_46_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_46_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => MUX_81_inst_req_1); -- 
    req_55_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_55_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => MUX_87_inst_req_0); -- 
    req_60_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_60_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => MUX_87_inst_req_1); -- 
    req_69_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_69_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => W_next_a_89_inst_req_0); -- 
    req_74_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_74_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => W_next_a_89_inst_req_1); -- 
    rr_83_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_83_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => LSHR_u8_u8_95_inst_req_0); -- 
    cr_88_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_88_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(1), ack => LSHR_u8_u8_95_inst_req_1); -- 
    shift_and_subtract_div_CP_3_elements(1) <= shift_and_subtract_div_CP_3_elements(50);
    -- CP-element group 2:  transition  input  bypass 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	1 
    -- CP-element group 2: successors 
    -- CP-element group 2:  members (3) 
      -- CP-element group 2: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_sample_completed_
      -- CP-element group 2: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_Sample/$exit
      -- CP-element group 2: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_Sample/ra
      -- 
    ra_28_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 2_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u8_u8_73_inst_ack_0, ack => shift_and_subtract_div_CP_3_elements(2)); -- 
    -- CP-element group 3:  transition  input  bypass 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: 	1 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	12 
    -- CP-element group 3:  members (3) 
      -- CP-element group 3: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_update_completed_
      -- CP-element group 3: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_Update/$exit
      -- CP-element group 3: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/ADD_u8_u8_73_Update/ca
      -- 
    ca_33_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 3_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => ADD_u8_u8_73_inst_ack_1, ack => shift_and_subtract_div_CP_3_elements(3)); -- 
    -- CP-element group 4:  transition  input  bypass 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: 	1 
    -- CP-element group 4: successors 
    -- CP-element group 4:  members (3) 
      -- CP-element group 4: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_sample_completed_
      -- CP-element group 4: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_start/$exit
      -- CP-element group 4: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_start/ack
      -- 
    ack_42_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 4_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => MUX_81_inst_ack_0, ack => shift_and_subtract_div_CP_3_elements(4)); -- 
    -- CP-element group 5:  transition  input  bypass 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	1 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	12 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_update_completed_
      -- CP-element group 5: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_complete/$exit
      -- CP-element group 5: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_81_complete/ack
      -- 
    ack_47_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 5_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => MUX_81_inst_ack_1, ack => shift_and_subtract_div_CP_3_elements(5)); -- 
    -- CP-element group 6:  transition  input  bypass 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	1 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (3) 
      -- CP-element group 6: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_start/ack
      -- CP-element group 6: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_sample_completed_
      -- CP-element group 6: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_start/$exit
      -- 
    ack_56_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 6_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => MUX_87_inst_ack_0, ack => shift_and_subtract_div_CP_3_elements(6)); -- 
    -- CP-element group 7:  transition  input  bypass 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	1 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	12 
    -- CP-element group 7:  members (3) 
      -- CP-element group 7: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_update_completed_
      -- CP-element group 7: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_complete/$exit
      -- CP-element group 7: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/MUX_87_complete/ack
      -- 
    ack_61_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 7_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => MUX_87_inst_ack_1, ack => shift_and_subtract_div_CP_3_elements(7)); -- 
    -- CP-element group 8:  transition  input  bypass 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	1 
    -- CP-element group 8: successors 
    -- CP-element group 8:  members (3) 
      -- CP-element group 8: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_sample_completed_
      -- CP-element group 8: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_Sample/$exit
      -- CP-element group 8: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_Sample/ack
      -- 
    ack_70_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 8_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => W_next_a_89_inst_ack_0, ack => shift_and_subtract_div_CP_3_elements(8)); -- 
    -- CP-element group 9:  transition  input  bypass 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: 	1 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	12 
    -- CP-element group 9:  members (3) 
      -- CP-element group 9: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_update_completed_
      -- CP-element group 9: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_Update/$exit
      -- CP-element group 9: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/assign_stmt_91_Update/ack
      -- 
    ack_75_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 9_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => W_next_a_89_inst_ack_1, ack => shift_and_subtract_div_CP_3_elements(9)); -- 
    -- CP-element group 10:  transition  input  bypass 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	1 
    -- CP-element group 10: successors 
    -- CP-element group 10:  members (3) 
      -- CP-element group 10: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_sample_completed_
      -- CP-element group 10: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_Sample/$exit
      -- CP-element group 10: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_Sample/ra
      -- 
    ra_84_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 10_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => LSHR_u8_u8_95_inst_ack_0, ack => shift_and_subtract_div_CP_3_elements(10)); -- 
    -- CP-element group 11:  transition  input  bypass 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	1 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	12 
    -- CP-element group 11:  members (3) 
      -- CP-element group 11: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_update_completed_
      -- CP-element group 11: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_Update/$exit
      -- CP-element group 11: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/LSHR_u8_u8_95_Update/ca
      -- 
    ca_89_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 11_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => LSHR_u8_u8_95_inst_ack_1, ack => shift_and_subtract_div_CP_3_elements(11)); -- 
    -- CP-element group 12:  branch  join  transition  place  output  bypass 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	9 
    -- CP-element group 12: 	3 
    -- CP-element group 12: 	5 
    -- CP-element group 12: 	7 
    -- CP-element group 12: 	11 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	13 
    -- CP-element group 12: 	14 
    -- CP-element group 12:  members (10) 
      -- CP-element group 12: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96__exit__
      -- CP-element group 12: 	 branch_block_stmt_8/if_stmt_97__entry__
      -- CP-element group 12: 	 branch_block_stmt_8/assign_stmt_39_to_assign_stmt_96/$exit
      -- CP-element group 12: 	 branch_block_stmt_8/if_stmt_97_dead_link/$entry
      -- CP-element group 12: 	 branch_block_stmt_8/if_stmt_97_eval_test/$entry
      -- CP-element group 12: 	 branch_block_stmt_8/if_stmt_97_eval_test/$exit
      -- CP-element group 12: 	 branch_block_stmt_8/if_stmt_97_eval_test/branch_req
      -- CP-element group 12: 	 branch_block_stmt_8/R_continue_flag_98_place
      -- CP-element group 12: 	 branch_block_stmt_8/if_stmt_97_if_link/$entry
      -- CP-element group 12: 	 branch_block_stmt_8/if_stmt_97_else_link/$entry
      -- 
    branch_req_97_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " branch_req_97_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(12), ack => if_stmt_97_branch_req_0); -- 
    shift_and_subtract_div_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 4) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1);
      constant place_markings: IntegerArray(0 to 4)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0);
      constant place_delays: IntegerArray(0 to 4) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 5); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(9) & shift_and_subtract_div_CP_3_elements(3) & shift_and_subtract_div_CP_3_elements(5) & shift_and_subtract_div_CP_3_elements(7) & shift_and_subtract_div_CP_3_elements(11);
      gj_shift_and_subtract_div_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 5, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  fork  transition  place  input  output  bypass 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	37 
    -- CP-element group 13: 	38 
    -- CP-element group 13: 	40 
    -- CP-element group 13: 	41 
    -- CP-element group 13: 	28 
    -- CP-element group 13: 	29 
    -- CP-element group 13: 	34 
    -- CP-element group 13: 	35 
    -- CP-element group 13: 	32 
    -- CP-element group 13: 	31 
    -- CP-element group 13:  members (39) 
      -- CP-element group 13: 	 branch_block_stmt_8/loopback
      -- CP-element group 13: 	 branch_block_stmt_8/if_stmt_97_if_link/$exit
      -- CP-element group 13: 	 branch_block_stmt_8/if_stmt_97_if_link/if_choice_transition
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Sample/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Sample/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Update/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Update/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Sample/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Sample/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Update/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Update/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/Sample/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/Sample/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/Update/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/Update/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/Sample/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/Sample/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/Update/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/Update/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/Sample/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/Sample/req
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/Update/$entry
      -- CP-element group 13: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/Update/req
      -- 
    if_choice_transition_102_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 13_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => if_stmt_97_branch_ack_1, ack => shift_and_subtract_div_CP_3_elements(13)); -- 
    req_213_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_213_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_a_91_13_buf_req_0); -- 
    req_218_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_218_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_a_91_13_buf_req_1); -- 
    req_233_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_233_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_b_96_17_buf_req_0); -- 
    req_238_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_238_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_b_96_17_buf_req_1); -- 
    req_253_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_253_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_quotient_88_20_buf_req_0); -- 
    req_258_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_258_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_quotient_88_20_buf_req_1); -- 
    req_273_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_273_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_remainder_82_27_buf_req_0); -- 
    req_278_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_278_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_remainder_82_27_buf_req_1); -- 
    req_293_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_293_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_count_74_32_buf_req_0); -- 
    req_298_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_298_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(13), ack => next_count_74_32_buf_req_1); -- 
    -- CP-element group 14:  fork  transition  place  input  output  bypass 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	12 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	16 
    -- CP-element group 14: 	15 
    -- CP-element group 14:  members (10) 
      -- CP-element group 14: 	 branch_block_stmt_8/assign_stmt_103__entry__
      -- CP-element group 14: 	 branch_block_stmt_8/if_stmt_97_else_link/$exit
      -- CP-element group 14: 	 branch_block_stmt_8/if_stmt_97_else_link/else_choice_transition
      -- CP-element group 14: 	 branch_block_stmt_8/assign_stmt_103/$entry
      -- CP-element group 14: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_sample_start_
      -- CP-element group 14: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_update_start_
      -- CP-element group 14: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_Sample/$entry
      -- CP-element group 14: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_Sample/req
      -- CP-element group 14: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_Update/$entry
      -- CP-element group 14: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_Update/req
      -- 
    else_choice_transition_106_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 14_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => if_stmt_97_branch_ack_0, ack => shift_and_subtract_div_CP_3_elements(14)); -- 
    req_120_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_120_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(14), ack => W_quotient_101_inst_req_0); -- 
    req_125_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_125_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(14), ack => W_quotient_101_inst_req_1); -- 
    -- CP-element group 15:  transition  input  bypass 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	14 
    -- CP-element group 15: successors 
    -- CP-element group 15:  members (3) 
      -- CP-element group 15: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_sample_completed_
      -- CP-element group 15: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_Sample/$exit
      -- CP-element group 15: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_Sample/ack
      -- 
    ack_121_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 15_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => W_quotient_101_inst_ack_0, ack => shift_and_subtract_div_CP_3_elements(15)); -- 
    -- CP-element group 16:  merge  transition  place  input  bypass 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	14 
    -- CP-element group 16: successors 
    -- CP-element group 16:  members (9) 
      -- CP-element group 16: 	 $exit
      -- CP-element group 16: 	 branch_block_stmt_8/$exit
      -- CP-element group 16: 	 branch_block_stmt_8/branch_block_stmt_8__exit__
      -- CP-element group 16: 	 branch_block_stmt_8/if_stmt_97__exit__
      -- CP-element group 16: 	 branch_block_stmt_8/assign_stmt_103__exit__
      -- CP-element group 16: 	 branch_block_stmt_8/assign_stmt_103/$exit
      -- CP-element group 16: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_update_completed_
      -- CP-element group 16: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_Update/$exit
      -- CP-element group 16: 	 branch_block_stmt_8/assign_stmt_103/assign_stmt_103_Update/ack
      -- 
    ack_126_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 16_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => W_quotient_101_inst_ack_1, ack => shift_and_subtract_div_CP_3_elements(16)); -- 
    -- CP-element group 17:  fork  transition  output  bypass 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	0 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	25 
    -- CP-element group 17: 	19 
    -- CP-element group 17: 	21 
    -- CP-element group 17: 	26 
    -- CP-element group 17: 	18 
    -- CP-element group 17: 	22 
    -- CP-element group 17: 	24 
    -- CP-element group 17:  members (21) 
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Sample/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Sample/req
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Update/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Update/req
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Sample/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Sample/req
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Update/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Update/req
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_18/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_18/phi_stmt_18_sources/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_23/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_23/phi_stmt_23_sources/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_28/$entry
      -- CP-element group 17: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_28/phi_stmt_28_sources/$entry
      -- 
    req_151_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_151_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(17), ack => a_12_buf_req_1); -- 
    req_146_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_146_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(17), ack => a_12_buf_req_0); -- 
    req_166_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_166_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(17), ack => b_16_buf_req_0); -- 
    req_171_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_171_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(17), ack => b_16_buf_req_1); -- 
    shift_and_subtract_div_CP_3_elements(17) <= shift_and_subtract_div_CP_3_elements(0);
    -- CP-element group 18:  transition  input  bypass 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	17 
    -- CP-element group 18: successors 
    -- CP-element group 18: 	20 
    -- CP-element group 18:  members (2) 
      -- CP-element group 18: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Sample/$exit
      -- CP-element group 18: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Sample/ack
      -- 
    ack_147_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 18_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => a_12_buf_ack_0, ack => shift_and_subtract_div_CP_3_elements(18)); -- 
    -- CP-element group 19:  transition  input  bypass 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: 	17 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	20 
    -- CP-element group 19:  members (2) 
      -- CP-element group 19: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Update/$exit
      -- CP-element group 19: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Update/ack
      -- 
    ack_152_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 19_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => a_12_buf_ack_1, ack => shift_and_subtract_div_CP_3_elements(19)); -- 
    -- CP-element group 20:  join  transition  output  bypass 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	19 
    -- CP-element group 20: 	18 
    -- CP-element group 20: successors 
    -- CP-element group 20: 	27 
    -- CP-element group 20:  members (4) 
      -- CP-element group 20: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/$exit
      -- CP-element group 20: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/$exit
      -- CP-element group 20: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/$exit
      -- CP-element group 20: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_10/phi_stmt_10_req
      -- 
    phi_stmt_10_req_153_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_10_req_153_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(20), ack => phi_stmt_10_req_0); -- 
    shift_and_subtract_div_cp_element_group_20: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_20"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(19) & shift_and_subtract_div_CP_3_elements(18);
      gj_shift_and_subtract_div_cp_element_group_20 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(20), clk => clk, reset => reset); --
    end block;
    -- CP-element group 21:  transition  input  bypass 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: 	17 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	23 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Sample/$exit
      -- CP-element group 21: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Sample/ack
      -- 
    ack_167_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 21_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => b_16_buf_ack_0, ack => shift_and_subtract_div_CP_3_elements(21)); -- 
    -- CP-element group 22:  transition  input  bypass 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	17 
    -- CP-element group 22: successors 
    -- CP-element group 22: 	23 
    -- CP-element group 22:  members (2) 
      -- CP-element group 22: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Update/$exit
      -- CP-element group 22: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Update/ack
      -- 
    ack_172_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 22_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => b_16_buf_ack_1, ack => shift_and_subtract_div_CP_3_elements(22)); -- 
    -- CP-element group 23:  join  transition  output  bypass 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: 	21 
    -- CP-element group 23: 	22 
    -- CP-element group 23: successors 
    -- CP-element group 23: 	27 
    -- CP-element group 23:  members (4) 
      -- CP-element group 23: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/$exit
      -- CP-element group 23: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/$exit
      -- CP-element group 23: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/$exit
      -- CP-element group 23: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_14/phi_stmt_14_req
      -- 
    phi_stmt_14_req_173_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_14_req_173_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(23), ack => phi_stmt_14_req_0); -- 
    shift_and_subtract_div_cp_element_group_23: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_23"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(21) & shift_and_subtract_div_CP_3_elements(22);
      gj_shift_and_subtract_div_cp_element_group_23 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(23), clk => clk, reset => reset); --
    end block;
    -- CP-element group 24:  transition  output  delay-element  bypass 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	17 
    -- CP-element group 24: successors 
    -- CP-element group 24: 	27 
    -- CP-element group 24:  members (4) 
      -- CP-element group 24: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_18/$exit
      -- CP-element group 24: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_18/phi_stmt_18_sources/$exit
      -- CP-element group 24: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_18/phi_stmt_18_sources/type_cast_22_konst_delay_trans
      -- CP-element group 24: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_18/phi_stmt_18_req
      -- 
    phi_stmt_18_req_181_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_18_req_181_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(24), ack => phi_stmt_18_req_1); -- 
    -- Element group shift_and_subtract_div_CP_3_elements(24) is a control-delay.
    cp_element_24_delay: control_delay_element  generic map(name => " 24_delay", delay_value => 1)  port map(req => shift_and_subtract_div_CP_3_elements(17), ack => shift_and_subtract_div_CP_3_elements(24), clk => clk, reset =>reset);
    -- CP-element group 25:  transition  output  delay-element  bypass 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: 	17 
    -- CP-element group 25: successors 
    -- CP-element group 25: 	27 
    -- CP-element group 25:  members (4) 
      -- CP-element group 25: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_23/$exit
      -- CP-element group 25: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_23/phi_stmt_23_sources/$exit
      -- CP-element group 25: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_23/phi_stmt_23_sources/type_cast_26_konst_delay_trans
      -- CP-element group 25: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_23/phi_stmt_23_req
      -- 
    phi_stmt_23_req_189_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_23_req_189_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(25), ack => phi_stmt_23_req_0); -- 
    -- Element group shift_and_subtract_div_CP_3_elements(25) is a control-delay.
    cp_element_25_delay: control_delay_element  generic map(name => " 25_delay", delay_value => 1)  port map(req => shift_and_subtract_div_CP_3_elements(17), ack => shift_and_subtract_div_CP_3_elements(25), clk => clk, reset =>reset);
    -- CP-element group 26:  transition  output  delay-element  bypass 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: 	17 
    -- CP-element group 26: successors 
    -- CP-element group 26: 	27 
    -- CP-element group 26:  members (4) 
      -- CP-element group 26: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_28/$exit
      -- CP-element group 26: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_28/phi_stmt_28_sources/$exit
      -- CP-element group 26: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_28/phi_stmt_28_sources/type_cast_31_konst_delay_trans
      -- CP-element group 26: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/phi_stmt_28/phi_stmt_28_req
      -- 
    phi_stmt_28_req_197_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_28_req_197_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(26), ack => phi_stmt_28_req_0); -- 
    -- Element group shift_and_subtract_div_CP_3_elements(26) is a control-delay.
    cp_element_26_delay: control_delay_element  generic map(name => " 26_delay", delay_value => 1)  port map(req => shift_and_subtract_div_CP_3_elements(17), ack => shift_and_subtract_div_CP_3_elements(26), clk => clk, reset =>reset);
    -- CP-element group 27:  join  transition  bypass 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: 	25 
    -- CP-element group 27: 	20 
    -- CP-element group 27: 	26 
    -- CP-element group 27: 	23 
    -- CP-element group 27: 	24 
    -- CP-element group 27: successors 
    -- CP-element group 27: 	44 
    -- CP-element group 27:  members (1) 
      -- CP-element group 27: 	 branch_block_stmt_8/merge_stmt_9__entry___PhiReq/$exit
      -- 
    shift_and_subtract_div_cp_element_group_27: block -- 
      constant place_capacities: IntegerArray(0 to 4) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1);
      constant place_markings: IntegerArray(0 to 4)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0);
      constant place_delays: IntegerArray(0 to 4) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_27"; 
      signal preds: BooleanArray(1 to 5); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(25) & shift_and_subtract_div_CP_3_elements(20) & shift_and_subtract_div_CP_3_elements(26) & shift_and_subtract_div_CP_3_elements(23) & shift_and_subtract_div_CP_3_elements(24);
      gj_shift_and_subtract_div_cp_element_group_27 : generic_join generic map(name => joinName, number_of_predecessors => 5, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(27), clk => clk, reset => reset); --
    end block;
    -- CP-element group 28:  transition  input  bypass 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: 	13 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	30 
    -- CP-element group 28:  members (2) 
      -- CP-element group 28: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Sample/$exit
      -- CP-element group 28: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Sample/ack
      -- 
    ack_214_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 28_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_a_91_13_buf_ack_0, ack => shift_and_subtract_div_CP_3_elements(28)); -- 
    -- CP-element group 29:  transition  input  bypass 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: 	13 
    -- CP-element group 29: successors 
    -- CP-element group 29: 	30 
    -- CP-element group 29:  members (2) 
      -- CP-element group 29: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Update/$exit
      -- CP-element group 29: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/Update/ack
      -- 
    ack_219_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 29_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_a_91_13_buf_ack_1, ack => shift_and_subtract_div_CP_3_elements(29)); -- 
    -- CP-element group 30:  join  transition  output  bypass 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: 	28 
    -- CP-element group 30: 	29 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	43 
    -- CP-element group 30:  members (4) 
      -- CP-element group 30: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/$exit
      -- CP-element group 30: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/$exit
      -- CP-element group 30: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_sources/Interlock/$exit
      -- CP-element group 30: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_10/phi_stmt_10_req
      -- 
    phi_stmt_10_req_220_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_10_req_220_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(30), ack => phi_stmt_10_req_1); -- 
    shift_and_subtract_div_cp_element_group_30: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_30"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(28) & shift_and_subtract_div_CP_3_elements(29);
      gj_shift_and_subtract_div_cp_element_group_30 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(30), clk => clk, reset => reset); --
    end block;
    -- CP-element group 31:  transition  input  bypass 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: 	13 
    -- CP-element group 31: successors 
    -- CP-element group 31: 	33 
    -- CP-element group 31:  members (2) 
      -- CP-element group 31: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Sample/$exit
      -- CP-element group 31: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Sample/ack
      -- 
    ack_234_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 31_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_b_96_17_buf_ack_0, ack => shift_and_subtract_div_CP_3_elements(31)); -- 
    -- CP-element group 32:  transition  input  bypass 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: 	13 
    -- CP-element group 32: successors 
    -- CP-element group 32: 	33 
    -- CP-element group 32:  members (2) 
      -- CP-element group 32: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Update/$exit
      -- CP-element group 32: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/Update/ack
      -- 
    ack_239_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 32_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_b_96_17_buf_ack_1, ack => shift_and_subtract_div_CP_3_elements(32)); -- 
    -- CP-element group 33:  join  transition  output  bypass 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	32 
    -- CP-element group 33: 	31 
    -- CP-element group 33: successors 
    -- CP-element group 33: 	43 
    -- CP-element group 33:  members (4) 
      -- CP-element group 33: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/$exit
      -- CP-element group 33: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/$exit
      -- CP-element group 33: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_sources/Interlock/$exit
      -- CP-element group 33: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_14/phi_stmt_14_req
      -- 
    phi_stmt_14_req_240_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_14_req_240_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(33), ack => phi_stmt_14_req_1); -- 
    shift_and_subtract_div_cp_element_group_33: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_33"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(32) & shift_and_subtract_div_CP_3_elements(31);
      gj_shift_and_subtract_div_cp_element_group_33 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(33), clk => clk, reset => reset); --
    end block;
    -- CP-element group 34:  transition  input  bypass 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	13 
    -- CP-element group 34: successors 
    -- CP-element group 34: 	36 
    -- CP-element group 34:  members (2) 
      -- CP-element group 34: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/Sample/$exit
      -- CP-element group 34: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/Sample/ack
      -- 
    ack_254_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 34_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_quotient_88_20_buf_ack_0, ack => shift_and_subtract_div_CP_3_elements(34)); -- 
    -- CP-element group 35:  transition  input  bypass 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	13 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	36 
    -- CP-element group 35:  members (2) 
      -- CP-element group 35: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/Update/$exit
      -- CP-element group 35: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/Update/ack
      -- 
    ack_259_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 35_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_quotient_88_20_buf_ack_1, ack => shift_and_subtract_div_CP_3_elements(35)); -- 
    -- CP-element group 36:  join  transition  output  bypass 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	34 
    -- CP-element group 36: 	35 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	43 
    -- CP-element group 36:  members (4) 
      -- CP-element group 36: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/$exit
      -- CP-element group 36: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/$exit
      -- CP-element group 36: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_sources/Interlock/$exit
      -- CP-element group 36: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_18/phi_stmt_18_req
      -- 
    phi_stmt_18_req_260_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_18_req_260_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(36), ack => phi_stmt_18_req_0); -- 
    shift_and_subtract_div_cp_element_group_36: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_36"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(34) & shift_and_subtract_div_CP_3_elements(35);
      gj_shift_and_subtract_div_cp_element_group_36 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(36), clk => clk, reset => reset); --
    end block;
    -- CP-element group 37:  transition  input  bypass 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	13 
    -- CP-element group 37: successors 
    -- CP-element group 37: 	39 
    -- CP-element group 37:  members (2) 
      -- CP-element group 37: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/Sample/$exit
      -- CP-element group 37: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/Sample/ack
      -- 
    ack_274_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 37_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_remainder_82_27_buf_ack_0, ack => shift_and_subtract_div_CP_3_elements(37)); -- 
    -- CP-element group 38:  transition  input  bypass 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: 	13 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	39 
    -- CP-element group 38:  members (2) 
      -- CP-element group 38: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/Update/$exit
      -- CP-element group 38: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/Update/ack
      -- 
    ack_279_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 38_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_remainder_82_27_buf_ack_1, ack => shift_and_subtract_div_CP_3_elements(38)); -- 
    -- CP-element group 39:  join  transition  output  bypass 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	37 
    -- CP-element group 39: 	38 
    -- CP-element group 39: successors 
    -- CP-element group 39: 	43 
    -- CP-element group 39:  members (4) 
      -- CP-element group 39: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_req
      -- CP-element group 39: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/$exit
      -- CP-element group 39: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/$exit
      -- CP-element group 39: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_23/phi_stmt_23_sources/Interlock/$exit
      -- 
    phi_stmt_23_req_280_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_23_req_280_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(39), ack => phi_stmt_23_req_1); -- 
    shift_and_subtract_div_cp_element_group_39: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_39"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(37) & shift_and_subtract_div_CP_3_elements(38);
      gj_shift_and_subtract_div_cp_element_group_39 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(39), clk => clk, reset => reset); --
    end block;
    -- CP-element group 40:  transition  input  bypass 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: 	13 
    -- CP-element group 40: successors 
    -- CP-element group 40: 	42 
    -- CP-element group 40:  members (2) 
      -- CP-element group 40: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/Sample/$exit
      -- CP-element group 40: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/Sample/ack
      -- 
    ack_294_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 40_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_74_32_buf_ack_0, ack => shift_and_subtract_div_CP_3_elements(40)); -- 
    -- CP-element group 41:  transition  input  bypass 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: 	13 
    -- CP-element group 41: successors 
    -- CP-element group 41: 	42 
    -- CP-element group 41:  members (2) 
      -- CP-element group 41: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/Update/$exit
      -- CP-element group 41: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/Update/ack
      -- 
    ack_299_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 41_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_74_32_buf_ack_1, ack => shift_and_subtract_div_CP_3_elements(41)); -- 
    -- CP-element group 42:  join  transition  output  bypass 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: 	40 
    -- CP-element group 42: 	41 
    -- CP-element group 42: successors 
    -- CP-element group 42: 	43 
    -- CP-element group 42:  members (4) 
      -- CP-element group 42: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/$exit
      -- CP-element group 42: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/$exit
      -- CP-element group 42: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_sources/Interlock/$exit
      -- CP-element group 42: 	 branch_block_stmt_8/loopback_PhiReq/phi_stmt_28/phi_stmt_28_req
      -- 
    phi_stmt_28_req_300_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_28_req_300_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => shift_and_subtract_div_CP_3_elements(42), ack => phi_stmt_28_req_1); -- 
    shift_and_subtract_div_cp_element_group_42: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_42"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(40) & shift_and_subtract_div_CP_3_elements(41);
      gj_shift_and_subtract_div_cp_element_group_42 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(42), clk => clk, reset => reset); --
    end block;
    -- CP-element group 43:  join  transition  bypass 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: 	39 
    -- CP-element group 43: 	42 
    -- CP-element group 43: 	33 
    -- CP-element group 43: 	30 
    -- CP-element group 43: 	36 
    -- CP-element group 43: successors 
    -- CP-element group 43: 	44 
    -- CP-element group 43:  members (1) 
      -- CP-element group 43: 	 branch_block_stmt_8/loopback_PhiReq/$exit
      -- 
    shift_and_subtract_div_cp_element_group_43: block -- 
      constant place_capacities: IntegerArray(0 to 4) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1);
      constant place_markings: IntegerArray(0 to 4)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0);
      constant place_delays: IntegerArray(0 to 4) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_43"; 
      signal preds: BooleanArray(1 to 5); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(39) & shift_and_subtract_div_CP_3_elements(42) & shift_and_subtract_div_CP_3_elements(33) & shift_and_subtract_div_CP_3_elements(30) & shift_and_subtract_div_CP_3_elements(36);
      gj_shift_and_subtract_div_cp_element_group_43 : generic_join generic map(name => joinName, number_of_predecessors => 5, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(43), clk => clk, reset => reset); --
    end block;
    -- CP-element group 44:  merge  fork  transition  place  bypass 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: 	43 
    -- CP-element group 44: 	27 
    -- CP-element group 44: successors 
    -- CP-element group 44: 	45 
    -- CP-element group 44: 	46 
    -- CP-element group 44: 	47 
    -- CP-element group 44: 	48 
    -- CP-element group 44: 	49 
    -- CP-element group 44:  members (2) 
      -- CP-element group 44: 	 branch_block_stmt_8/merge_stmt_9_PhiReqMerge
      -- CP-element group 44: 	 branch_block_stmt_8/merge_stmt_9_PhiAck/$entry
      -- 
    shift_and_subtract_div_CP_3_elements(44) <= OrReduce(shift_and_subtract_div_CP_3_elements(43) & shift_and_subtract_div_CP_3_elements(27));
    -- CP-element group 45:  transition  input  bypass 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: 	44 
    -- CP-element group 45: successors 
    -- CP-element group 45: 	50 
    -- CP-element group 45:  members (1) 
      -- CP-element group 45: 	 branch_block_stmt_8/merge_stmt_9_PhiAck/phi_stmt_10_ack
      -- 
    phi_stmt_10_ack_305_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 45_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_10_ack_0, ack => shift_and_subtract_div_CP_3_elements(45)); -- 
    -- CP-element group 46:  transition  input  bypass 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: 	44 
    -- CP-element group 46: successors 
    -- CP-element group 46: 	50 
    -- CP-element group 46:  members (1) 
      -- CP-element group 46: 	 branch_block_stmt_8/merge_stmt_9_PhiAck/phi_stmt_14_ack
      -- 
    phi_stmt_14_ack_306_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 46_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_14_ack_0, ack => shift_and_subtract_div_CP_3_elements(46)); -- 
    -- CP-element group 47:  transition  input  bypass 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: 	44 
    -- CP-element group 47: successors 
    -- CP-element group 47: 	50 
    -- CP-element group 47:  members (1) 
      -- CP-element group 47: 	 branch_block_stmt_8/merge_stmt_9_PhiAck/phi_stmt_18_ack
      -- 
    phi_stmt_18_ack_307_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 47_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_18_ack_0, ack => shift_and_subtract_div_CP_3_elements(47)); -- 
    -- CP-element group 48:  transition  input  bypass 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: 	44 
    -- CP-element group 48: successors 
    -- CP-element group 48: 	50 
    -- CP-element group 48:  members (1) 
      -- CP-element group 48: 	 branch_block_stmt_8/merge_stmt_9_PhiAck/phi_stmt_23_ack
      -- 
    phi_stmt_23_ack_308_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 48_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_23_ack_0, ack => shift_and_subtract_div_CP_3_elements(48)); -- 
    -- CP-element group 49:  transition  input  bypass 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: 	44 
    -- CP-element group 49: successors 
    -- CP-element group 49: 	50 
    -- CP-element group 49:  members (1) 
      -- CP-element group 49: 	 branch_block_stmt_8/merge_stmt_9_PhiAck/phi_stmt_28_ack
      -- 
    phi_stmt_28_ack_309_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 49_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_28_ack_0, ack => shift_and_subtract_div_CP_3_elements(49)); -- 
    -- CP-element group 50:  join  transition  bypass 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: 	45 
    -- CP-element group 50: 	46 
    -- CP-element group 50: 	47 
    -- CP-element group 50: 	48 
    -- CP-element group 50: 	49 
    -- CP-element group 50: successors 
    -- CP-element group 50: 	1 
    -- CP-element group 50:  members (1) 
      -- CP-element group 50: 	 branch_block_stmt_8/merge_stmt_9_PhiAck/$exit
      -- 
    shift_and_subtract_div_cp_element_group_50: block -- 
      constant place_capacities: IntegerArray(0 to 4) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1);
      constant place_markings: IntegerArray(0 to 4)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0);
      constant place_delays: IntegerArray(0 to 4) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0);
      constant joinName: string(1 to 42) := "shift_and_subtract_div_cp_element_group_50"; 
      signal preds: BooleanArray(1 to 5); -- 
    begin -- 
      preds <= shift_and_subtract_div_CP_3_elements(45) & shift_and_subtract_div_CP_3_elements(46) & shift_and_subtract_div_CP_3_elements(47) & shift_and_subtract_div_CP_3_elements(48) & shift_and_subtract_div_CP_3_elements(49);
      gj_shift_and_subtract_div_cp_element_group_50 : generic_join generic map(name => joinName, number_of_predecessors => 5, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => shift_and_subtract_div_CP_3_elements(50), clk => clk, reset => reset); --
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal LSHR_u8_u8_45_wire : std_logic_vector(7 downto 0);
    signal SHL_u8_u8_52_wire : std_logic_vector(7 downto 0);
    signal SHL_u8_u8_67_wire : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_44_wire : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_66_wire : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_79_wire : std_logic_vector(7 downto 0);
    signal a_12_buffered : std_logic_vector(7 downto 0);
    signal b_16_buffered : std_logic_vector(7 downto 0);
    signal continue_flag_39 : std_logic_vector(0 downto 0);
    signal count_28 : std_logic_vector(7 downto 0);
    signal curr_a_10 : std_logic_vector(7 downto 0);
    signal curr_b_14 : std_logic_vector(7 downto 0);
    signal curr_quotient_18 : std_logic_vector(7 downto 0);
    signal curr_remainder_23 : std_logic_vector(7 downto 0);
    signal konst_36_wire_constant : std_logic_vector(7 downto 0);
    signal konst_42_wire_constant : std_logic_vector(7 downto 0);
    signal konst_46_wire_constant : std_logic_vector(7 downto 0);
    signal konst_51_wire_constant : std_logic_vector(7 downto 0);
    signal konst_63_wire_constant : std_logic_vector(7 downto 0);
    signal konst_64_wire_constant : std_logic_vector(7 downto 0);
    signal konst_72_wire_constant : std_logic_vector(7 downto 0);
    signal konst_94_wire_constant : std_logic_vector(7 downto 0);
    signal new_quot_69 : std_logic_vector(7 downto 0);
    signal new_rem_55 : std_logic_vector(7 downto 0);
    signal next_a_91 : std_logic_vector(7 downto 0);
    signal next_a_91_13_buffered : std_logic_vector(7 downto 0);
    signal next_b_96 : std_logic_vector(7 downto 0);
    signal next_b_96_17_buffered : std_logic_vector(7 downto 0);
    signal next_bit_from_dividend_48 : std_logic_vector(7 downto 0);
    signal next_count_74 : std_logic_vector(7 downto 0);
    signal next_count_74_32_buffered : std_logic_vector(7 downto 0);
    signal next_quotient_88 : std_logic_vector(7 downto 0);
    signal next_quotient_88_20_buffered : std_logic_vector(7 downto 0);
    signal next_remainder_82 : std_logic_vector(7 downto 0);
    signal next_remainder_82_27_buffered : std_logic_vector(7 downto 0);
    signal sub_shifted_60 : std_logic_vector(0 downto 0);
    signal type_cast_22_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_26_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_31_wire_constant : std_logic_vector(7 downto 0);
    -- 
  begin -- 
    konst_36_wire_constant <= "00001000";
    konst_42_wire_constant <= "00000111";
    konst_46_wire_constant <= "00000001";
    konst_51_wire_constant <= "00000001";
    konst_63_wire_constant <= "00000001";
    konst_64_wire_constant <= "00000111";
    konst_72_wire_constant <= "00000001";
    konst_94_wire_constant <= "00000001";
    type_cast_22_wire_constant <= "00000000";
    type_cast_26_wire_constant <= "00000000";
    type_cast_31_wire_constant <= "00000000";
    phi_stmt_10: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= a_12_buffered & next_a_91_13_buffered;
      req <= phi_stmt_10_req_0 & phi_stmt_10_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_10",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_10_ack_0,
          idata => idata,
          odata => curr_a_10,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_10
    phi_stmt_14: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= b_16_buffered & next_b_96_17_buffered;
      req <= phi_stmt_14_req_0 & phi_stmt_14_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_14",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_14_ack_0,
          idata => idata,
          odata => curr_b_14,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_14
    phi_stmt_18: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= next_quotient_88_20_buffered & type_cast_22_wire_constant;
      req <= phi_stmt_18_req_0 & phi_stmt_18_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_18",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_18_ack_0,
          idata => idata,
          odata => curr_quotient_18,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_18
    phi_stmt_23: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_26_wire_constant & next_remainder_82_27_buffered;
      req <= phi_stmt_23_req_0 & phi_stmt_23_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_23",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_23_ack_0,
          idata => idata,
          odata => curr_remainder_23,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_23
    phi_stmt_28: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_31_wire_constant & next_count_74_32_buffered;
      req <= phi_stmt_28_req_0 & phi_stmt_28_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_28",
          num_reqs => 2,
          bypass_flag => false,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_28_ack_0,
          idata => idata,
          odata => count_28,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_28
    MUX_81_inst_block : block -- 
      signal sample_req, sample_ack, update_req, update_ack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      sample_req(0) <= MUX_81_inst_req_0;
      MUX_81_inst_ack_0<= sample_ack(0);
      update_req(0) <= MUX_81_inst_req_1;
      MUX_81_inst_ack_1<= update_ack(0);
      MUX_81_inst: SelectSplitProtocol generic map(name => "MUX_81_inst", data_width => 8, buffering => 1, flow_through => false, full_rate => false) -- 
        port map( x => SUB_u8_u8_79_wire, y => new_rem_55, sel => sub_shifted_60, z => next_remainder_82, sample_req => sample_req(0), sample_ack => sample_ack(0), update_req => update_req(0), update_ack => update_ack(0), clk => clk, reset => reset); -- 
      -- 
    end block;
    MUX_87_inst_block : block -- 
      signal sample_req, sample_ack, update_req, update_ack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      sample_req(0) <= MUX_87_inst_req_0;
      MUX_87_inst_ack_0<= sample_ack(0);
      update_req(0) <= MUX_87_inst_req_1;
      MUX_87_inst_ack_1<= update_ack(0);
      MUX_87_inst: SelectSplitProtocol generic map(name => "MUX_87_inst", data_width => 8, buffering => 1, flow_through => false, full_rate => false) -- 
        port map( x => new_quot_69, y => curr_quotient_18, sel => sub_shifted_60, z => next_quotient_88, sample_req => sample_req(0), sample_ack => sample_ack(0), update_req => update_req(0), update_ack => update_ack(0), clk => clk, reset => reset); -- 
      -- 
    end block;
    W_next_a_89_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= W_next_a_89_inst_req_0;
      W_next_a_89_inst_ack_0<= wack(0);
      rreq(0) <= W_next_a_89_inst_req_1;
      W_next_a_89_inst_ack_1<= rack(0);
      W_next_a_89_inst : InterlockBuffer generic map ( -- 
        name => "W_next_a_89_inst",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => curr_a_10,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_a_91,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    W_quotient_101_inst_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= W_quotient_101_inst_req_0;
      W_quotient_101_inst_ack_0<= wack(0);
      rreq(0) <= W_quotient_101_inst_req_1;
      W_quotient_101_inst_ack_1<= rack(0);
      W_quotient_101_inst : InterlockBuffer generic map ( -- 
        name => "W_quotient_101_inst",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => curr_quotient_18,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => quotient_buffer,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    a_12_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= a_12_buf_req_0;
      a_12_buf_ack_0<= wack(0);
      rreq(0) <= a_12_buf_req_1;
      a_12_buf_ack_1<= rack(0);
      a_12_buf : InterlockBuffer generic map ( -- 
        name => "a_12_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => a_buffer,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => a_12_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    b_16_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= b_16_buf_req_0;
      b_16_buf_ack_0<= wack(0);
      rreq(0) <= b_16_buf_req_1;
      b_16_buf_ack_1<= rack(0);
      b_16_buf : InterlockBuffer generic map ( -- 
        name => "b_16_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => b_buffer,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => b_16_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_a_91_13_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_a_91_13_buf_req_0;
      next_a_91_13_buf_ack_0<= wack(0);
      rreq(0) <= next_a_91_13_buf_req_1;
      next_a_91_13_buf_ack_1<= rack(0);
      next_a_91_13_buf : InterlockBuffer generic map ( -- 
        name => "next_a_91_13_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_a_91,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_a_91_13_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_b_96_17_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_b_96_17_buf_req_0;
      next_b_96_17_buf_ack_0<= wack(0);
      rreq(0) <= next_b_96_17_buf_req_1;
      next_b_96_17_buf_ack_1<= rack(0);
      next_b_96_17_buf : InterlockBuffer generic map ( -- 
        name => "next_b_96_17_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_b_96,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_b_96_17_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_count_74_32_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_count_74_32_buf_req_0;
      next_count_74_32_buf_ack_0<= wack(0);
      rreq(0) <= next_count_74_32_buf_req_1;
      next_count_74_32_buf_ack_1<= rack(0);
      next_count_74_32_buf : InterlockBuffer generic map ( -- 
        name => "next_count_74_32_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_count_74,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_count_74_32_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_quotient_88_20_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_quotient_88_20_buf_req_0;
      next_quotient_88_20_buf_ack_0<= wack(0);
      rreq(0) <= next_quotient_88_20_buf_req_1;
      next_quotient_88_20_buf_ack_1<= rack(0);
      next_quotient_88_20_buf : InterlockBuffer generic map ( -- 
        name => "next_quotient_88_20_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_quotient_88,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_quotient_88_20_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_remainder_82_27_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_remainder_82_27_buf_req_0;
      next_remainder_82_27_buf_ack_0<= wack(0);
      rreq(0) <= next_remainder_82_27_buf_req_1;
      next_remainder_82_27_buf_ack_1<= rack(0);
      next_remainder_82_27_buf : InterlockBuffer generic map ( -- 
        name => "next_remainder_82_27_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_remainder_82,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_remainder_82_27_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    if_stmt_97_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= continue_flag_39;
      branch_instance: BranchBase -- 
        generic map( name => "if_stmt_97_branch", condition_width => 1,  bypass_flag => false)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_97_branch_req_0,
          ack0 => if_stmt_97_branch_ack_0,
          ack1 => if_stmt_97_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : ADD_u8_u8_73_inst 
    ApIntAdd_group_0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      data_in <= count_28;
      next_count_74 <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= ADD_u8_u8_73_inst_req_0;
      ADD_u8_u8_73_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= ADD_u8_u8_73_inst_req_1;
      ADD_u8_u8_73_inst_ack_1 <= ackR_unguarded(0);
      ApIntAdd_group_0_gI: SplitGuardInterface generic map(name => "ApIntAdd_group_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => false) -- 
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
          name => "ApIntAdd_group_0",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000001",
          constant_width => 8,
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
    end Block; -- split operator group 0
    -- binary operator AND_u8_u8_47_inst
    process(LSHR_u8_u8_45_wire) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntAnd_proc(LSHR_u8_u8_45_wire, konst_46_wire_constant, tmp_var);
      next_bit_from_dividend_48 <= tmp_var; --
    end process;
    -- binary operator LSHR_u8_u8_45_inst
    process(curr_a_10, SUB_u8_u8_44_wire) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntLSHR_proc(curr_a_10, SUB_u8_u8_44_wire, tmp_var);
      LSHR_u8_u8_45_wire <= tmp_var; --
    end process;
    -- shared split operator group (3) : LSHR_u8_u8_95_inst 
    ApIntLSHR_group_3: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      data_in <= curr_b_14;
      next_b_96 <= data_out(7 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= LSHR_u8_u8_95_inst_req_0;
      LSHR_u8_u8_95_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= LSHR_u8_u8_95_inst_req_1;
      LSHR_u8_u8_95_inst_ack_1 <= ackR_unguarded(0);
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
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 8,
          constant_operand => "00000001",
          constant_width => 8,
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
    -- binary operator OR_u8_u8_54_inst
    process(SHL_u8_u8_52_wire, next_bit_from_dividend_48) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntOr_proc(SHL_u8_u8_52_wire, next_bit_from_dividend_48, tmp_var);
      new_rem_55 <= tmp_var; --
    end process;
    -- binary operator OR_u8_u8_68_inst
    process(curr_quotient_18, SHL_u8_u8_67_wire) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntOr_proc(curr_quotient_18, SHL_u8_u8_67_wire, tmp_var);
      new_quot_69 <= tmp_var; --
    end process;
    -- binary operator SHL_u8_u8_52_inst
    process(curr_remainder_23) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntSHL_proc(curr_remainder_23, konst_51_wire_constant, tmp_var);
      SHL_u8_u8_52_wire <= tmp_var; --
    end process;
    -- binary operator SHL_u8_u8_67_inst
    process(konst_63_wire_constant, SUB_u8_u8_66_wire) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntSHL_proc(konst_63_wire_constant, SUB_u8_u8_66_wire, tmp_var);
      SHL_u8_u8_67_wire <= tmp_var; --
    end process;
    -- binary operator SUB_u8_u8_44_inst
    process(konst_42_wire_constant, count_28) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntSub_proc(konst_42_wire_constant, count_28, tmp_var);
      SUB_u8_u8_44_wire <= tmp_var; --
    end process;
    -- binary operator SUB_u8_u8_66_inst
    process(konst_64_wire_constant, count_28) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntSub_proc(konst_64_wire_constant, count_28, tmp_var);
      SUB_u8_u8_66_wire <= tmp_var; --
    end process;
    -- binary operator SUB_u8_u8_79_inst
    process(new_rem_55, b_buffer) -- 
      variable tmp_var : std_logic_vector(7 downto 0); -- 
    begin -- 
      ApIntSub_proc(new_rem_55, b_buffer, tmp_var);
      SUB_u8_u8_79_wire <= tmp_var; --
    end process;
    -- binary operator UGE_u8_u1_59_inst
    process(new_rem_55, b_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntUge_proc(new_rem_55, b_buffer, tmp_var);
      sub_shifted_60 <= tmp_var; --
    end process;
    -- binary operator ULT_u8_u1_37_inst
    process(count_28) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntUlt_proc(count_28, konst_36_wire_constant, tmp_var);
      continue_flag_39 <= tmp_var; --
    end process;
    -- 
  end Block; -- data_path
  -- 
end shift_and_subtract_div_arch;
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
    shift_and_subtract_div_a : in  std_logic_vector(7 downto 0);
    shift_and_subtract_div_b : in  std_logic_vector(7 downto 0);
    shift_and_subtract_div_quotient : out  std_logic_vector(7 downto 0);
    shift_and_subtract_div_tag_in: in std_logic_vector(1 downto 0);
    shift_and_subtract_div_tag_out: out std_logic_vector(1 downto 0);
    shift_and_subtract_div_start_req : in std_logic;
    shift_and_subtract_div_start_ack : out std_logic;
    shift_and_subtract_div_fin_req   : in std_logic;
    shift_and_subtract_div_fin_ack   : out std_logic;
    clk : in std_logic;
    reset : in std_logic); -- 
  -- 
end entity; 
architecture ahir_system_arch  of ahir_system is -- system-architecture 
  -- declarations related to module shift_and_subtract_div
  component shift_and_subtract_div is -- 
    generic (tag_length : integer); 
    port ( -- 
      a : in  std_logic_vector(7 downto 0);
      b : in  std_logic_vector(7 downto 0);
      quotient : out  std_logic_vector(7 downto 0);
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
  -- module shift_and_subtract_div
  shift_and_subtract_div_instance:shift_and_subtract_div-- 
    generic map(tag_length => 2)
    port map(-- 
      a => shift_and_subtract_div_a,
      b => shift_and_subtract_div_b,
      quotient => shift_and_subtract_div_quotient,
      start_req => shift_and_subtract_div_start_req,
      start_ack => shift_and_subtract_div_start_ack,
      fin_req => shift_and_subtract_div_fin_req,
      fin_ack => shift_and_subtract_div_fin_ack,
      clk => clk,
      reset => reset,
      tag_in => shift_and_subtract_div_tag_in,
      tag_out => shift_and_subtract_div_tag_out-- 
    ); -- 
  -- gated clock generators 
  -- 
end ahir_system_arch;
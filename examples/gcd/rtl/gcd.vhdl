-- GCD RTL
-- inputs:  Ain[7:0], Bin[7:0], start
--     (assumption: Ain >= Bin)
--     (Ain, Bin are non-zero)
-- outputs:  Yout[7:0], done
-- registers:  A, B
-- intermediates: t[7:0]
--
-- RstState: if (start) then
--           A := Ain B:= Bin goto WorkState
--      end if
-- WorkState: 
--     if (A != B) then
--        t = (A - B) 
--        A := max (t, B)
--        B := min (t, B)
--     else
--        Yout := A
--        goto DoneState
--     end if;
-- DoneState:  done = 1 goto RstState
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gcd is
   port (ain, bin: in std_logic_vector(7 downto 0);
		start: in std_logic;
		yout: out std_logic_vector(7 downto 0);
		done: out std_logic;
		clk, reset: in std_logic);
end entity gcd;

architecture RTL of gcd is
	signal a,b: std_logic_vector(7 downto 0);
	type FsmState is (RstState, WorkState, DoneState);
	signal fsm_state: FsmState;
	
begin

	process (clk, reset, start, ain, bin, a, b)
		variable next_fsm_state_var: FsmState;
		variable t, next_a, next_b, next_yout: std_logic_vector(7 downto 0);
		variable done_var : std_logic;
	begin
		next_fsm_state_var := fsm_state;
		next_a := a;
		next_b := b;
		done_var := '0';
		next_yout := (others => '0');
		t := (others => '0');

		case fsm_state is
			when RstState =>
				if (start = '1') then
					next_fsm_state_var := WorkState;
					next_a := ain;
					next_b := b
				end if;
			when WorkState =>
				if (a = b) then
					next_fsm_state_var := DoneState;
					next_yout := a;
				else
					t := std_logic_vector(unsigned(a) - 
								unsigned(b));
					if(unsigned(t) > unsigned(b)) then
						next_a_var := t;
						next_b_var := b;
					else
						next_a_var := b;
						next_b_var := t;
					end if;
				
				end if;
			when DoneState =>
				done_var := '1';
		end case;

		done <= done_var;

		-- sample next values into FF's
		if(clk'event and clk = '1') then
			if (reset = '1') then
				fsm_state <= RstState;
			else
				fsm_state <= next_fsm_state_var;
				a <= next_a; b <= next_b; Yout <= next_yout;
			end if;
		end if;
	end process;
end RTL;


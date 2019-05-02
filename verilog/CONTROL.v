`timescale 1 ns/10 ps

module CONTROL(input i_clk,
	       input  i_fifo_out_full, 
	       input  i_a_min_zero,
	       input  i_b_min_zero,
	       input  i_a_lte_b,
	       input  i_a_empty,
	       input  i_b_empty,
	       input  i_r_a_min_zero,
	       input  i_r_b_min_zero,
	       output reg select_A,
	       output stall,
	       output reg switch_output
	       );
   
   parameter NOMINAL = 3'b000;
   parameter TOGGLE = 3'b001;
   parameter DONE_A = 3'b010;
   parameter DONE_B = 3'b011;
   parameter FINISHED = 3'b100;

   parameter period = 4;
   
   reg [2:0] 	      state;
   reg [2:0] 	      new_state;

   assign stall = (state == FINISHED) | (i_fifo_out_full) | ((state == NOMINAL) & (i_a_empty | i_b_empty)) | (state == DONE_A & i_b_empty) | (state == DONE_B & i_a_empty);
   initial
     begin
	state <= TOGGLE;
	select_A <= 1'b1;
	switch_output <= 1'b0;
	new_state <= TOGGLE;
     end

   always @(negedge i_clk) begin
      if (~stall | new_state == FINISHED | new_state == TOGGLE)
	state = new_state;
      select_A <= (state == NOMINAL & i_a_lte_b) | (state == DONE_B) | (state == TOGGLE & i_a_min_zero & i_r_b_min_zero & ~i_a_empty);
      switch_output <= (state == TOGGLE) & ~switch_output;
   end
   
   always @(i_a_empty or i_b_empty or i_r_a_min_zero or i_r_b_min_zero or i_a_min_zero or i_b_min_zero)
     begin
	#0.1;
	casez(state)
	  TOGGLE: begin
	     if (i_a_empty) 
	       new_state <= DONE_A;
	     else if (i_b_empty)
	       new_state = DONE_B;
	     else if (~i_a_min_zero & ~i_b_min_zero)
	       new_state <= NOMINAL;
	     else
	       new_state <= TOGGLE;
	  end
	  DONE_A: begin
	     if (i_a_empty & i_b_empty & i_r_a_min_zero & i_r_b_min_zero)
	       new_state <= FINISHED;
	     else if (i_b_min_zero)
	       new_state <= TOGGLE;
	  end
	  DONE_B: begin
	     if (i_a_empty & i_b_empty & i_r_a_min_zero & i_r_b_min_zero)
	       new_state <= FINISHED;
	     else if (i_a_min_zero)
	       new_state <= TOGGLE;	  
	  end       
	  FINISHED: begin 
	  end       
	  NOMINAL: begin
	     if (i_a_min_zero)
		new_state <= DONE_A;
	     else if (i_b_min_zero)
	       new_state <= DONE_B;			 
	  end    
	  default: begin end
	endcase // casez (state)
     end
endmodule

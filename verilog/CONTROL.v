`timescale 1 ns/10 ps

module CONTROL(input i_clk,
	       input  i_fifo_out_full, 
	       input  i_a_min_zero,
	       input  i_b_min_zero,
	       input  i_a_lte_b,
	       input  i_a_empty,
	       input  i_b_empty,
	       output reg select_A,
	       output stall,
	       output reg switch_output
	       );
   
   parameter NOMINAL = 3'b001;
   parameter TOGGLE = 3'b000;
   parameter DONE_A = 3'b010;
   parameter DONE_B = 3'b011;
   parameter FINISHED = 3'b100;

   parameter period = 4;
   
   reg [2:0] 	      state;
   reg [2:0] 	      new_state;
   reg                ready;
   

   always @(*) begin
      new_state <= (state == TOGGLE) ? (((~i_a_min_zero & ~i_b_min_zero) ? NOMINAL : TOGGLE)) :
		      (state == DONE_A) ? ((i_b_min_zero ? TOGGLE : DONE_A)) :
		      (state == DONE_B) ? ((i_a_min_zero ? TOGGLE : DONE_B)) :
		      (state == NOMINAL) ? (i_a_min_zero ? DONE_A :
					    (i_b_min_zero ? DONE_B : NOMINAL)) :
		      FINISHED;
   end
   
   assign stall = (i_fifo_out_full) | ((state == NOMINAL) & (i_a_empty | i_b_empty)) | (state == DONE_A & i_b_empty) | (state == DONE_B & i_a_empty) | (state == TOGGLE & (i_a_empty | ~i_a_min_zero) & (i_b_empty | ~i_b_min_zero) & (i_a_min_zero | i_b_min_zero));
   
   initial
     begin
	ready <= 0;
	state <= 3'b000;
	select_A <= 1'b0;
	switch_output <= 1'b0;
     end

   always @(negedge i_clk) begin
      if (~stall) begin
	     state <= new_state;
	     switch_output <= (new_state == TOGGLE & state != TOGGLE);
	     select_A <= (new_state == NOMINAL & i_a_lte_b) | (new_state == DONE_B) | (new_state == TOGGLE & i_a_min_zero & ~i_a_empty);
      end
   end
endmodule

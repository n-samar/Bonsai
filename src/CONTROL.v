`timescale 1 ns/10 ps

module CONTROL(input i_clk,
	       input  i_fifo_out_full, 
	       input  i_a_min_zero,
	       input  i_b_min_zero,
	       input  i_a_lte_b,
	       input  i_a_empty,
	       input  i_b_empty,
	       output select_A,
	       output stall,
	       output switch_output
	       );
   
   parameter NOMINAL = 3'b001;
   parameter TOGGLE = 3'b000;
   parameter DONE_A = 3'b010;
   parameter DONE_B = 3'b011;
   parameter FINISHED = 3'b100;

   parameter period = 4;
   
   reg [2:0] 	      state;
   reg [2:0] 	      next_state;
   reg                ready;
   

   // Next-state logic
   always @(*) begin
      case(state)
	TOGGLE: if (~i_a_min_zero & ~i_b_min_zero) begin
	   next_state <= stall ? TOGGLE : NOMINAL;
	end else begin
	   next_state <= stall ? TOGGLE : TOGGLE;
	end
	DONE_A: if (i_b_min_zero) begin
	   next_state <= stall ? DONE_A : TOGGLE;
	end else begin
	   next_state <= DONE_A;
	end
	DONE_B: if (i_a_min_zero) begin
	   next_state <= stall ? DONE_B : TOGGLE;
	end else begin
	   next_state <= DONE_B;
	end
	NOMINAL: if (i_a_min_zero) begin
	   next_state <= stall ? NOMINAL : DONE_A;
	end else if (i_b_min_zero) begin
	   next_state <= stall ? NOMINAL : DONE_B;
	end else begin
	   next_state <= NOMINAL;
	end
	default: next_state <= TOGGLE;
      endcase	
   end
/*
      next_state <= (state == TOGGLE) ? (((~i_a_min_zero & ~i_b_min_zero) ? NOMINAL : TOGGLE)) :
		   (state == DONE_A) ? ((i_b_min_zero ? TOGGLE : DONE_A)) :
		   (state == DONE_B) ? ((i_a_min_zero ? TOGGLE : DONE_B)) :
		   (state == NOMINAL) ? (i_a_min_zero ? DONE_A :
					 (i_b_min_zero ? DONE_B : NOMINAL)) :
		   FINISHED; 
 */
   // Outputs
   assign stall = (i_fifo_out_full) | ((state == NOMINAL) & (i_a_empty | i_b_empty)) | (state == DONE_A & i_b_empty) | (state == DONE_B & i_a_empty) | (state == TOGGLE & (i_a_empty | ~i_a_min_zero) & (i_b_empty | ~i_b_min_zero) & (i_a_min_zero | i_b_min_zero));
   assign switch_output = (state == DONE_A & i_b_min_zero) | (state == DONE_B & i_a_min_zero);
   assign select_A = (((state == TOGGLE | state == NOMINAL) & (~i_a_min_zero & ~i_b_min_zero)) & i_a_lte_b) | ((state == DONE_B & ~i_a_min_zero) | (state == NOMINAL & ~i_a_min_zero & i_b_min_zero)) | (((state == DONE_A & i_b_min_zero) | (state == DONE_B & i_a_min_zero) | (state == TOGGLE & (i_a_min_zero | i_b_min_zero))) & i_a_min_zero & ~i_a_empty);

   initial
     begin
	ready <= 0;
	state <= 3'b000;
	// select_A <= 1'b0;
	// switch_output <= 1'b0;
     end

   // Memory element
   always @(posedge i_clk) begin
	 state <= next_state;
   end
endmodule

`timescale 1ns/10ps

module COUPLER #(
		 parameter P_WIDTH         = 128
		 ) (
		    input wire 			i_clk,
		    input wire [P_WIDTH-1:0] 	i_data,
		    output wire [2*P_WIDTH-1:0] o_data,
		    input wire 			i_enq,
		    input wire 			i_deq,
		    output 			o_full,
		    output 			o_empty
		    );

   reg 						next_state;
   reg 						state;
   reg [P_WIDTH-1:0] 				first_elem;
   reg [P_WIDTH-1:0] 				second_elem;
   reg [P_WIDTH-1:0] 				first_elem_clocked;
   reg [P_WIDTH-1:0] 				second_elem_clocked;
   wire [2*P_WIDTH-1:0] 			out_elem;
   wire [P_WIDTH-1:0] 				in_elem;
   wire 					in_deq, out_enq;
   wire 					first_is_zero;
   
   
   IFIFO16 #(P_WIDTH) in_fifo (.i_clk(i_clk),
                               .i_data(i_data),
                               .o_data(in_elem),
                               .i_enq(i_enq),
                               .i_deq(in_deq),
                               .o_full(o_full),
                               .o_empty(in_empty));

   IFIFO16 #(2*P_WIDTH) out_fifo (.i_clk(i_clk),
                                  .i_data(out_elem), 
                                  .o_data(o_data),
                                  .i_enq(out_enq),
                                  .i_deq(i_deq),
                                  .o_full(out_full),
                                  .o_empty(o_empty));                    
   
   assign out_elem = {second_elem, first_elem};
   
   assign in_deq = (~out_full & ~in_empty & ~(first_is_zero & in_elem != 0));
   assign out_enq = (~out_full & ~in_empty & state == 1) | (state == 1 & first_is_zero);
   assign first_is_zero = (first_elem == 0);

   initial begin
      state <= 0;
      first_elem_clocked <= 0;
      second_elem_clocked <= 0;
      first_elem <= 0;
      second_elem <= 0;            
   end

   // State
   always @(posedge i_clk) begin
      state <= next_state;
      first_elem_clocked <= first_elem;
      second_elem_clocked <= second_elem;      
   end

   // Outputs
   always @(*) begin
      case(state)
	0: begin
	   next_state <= (~out_full & ~in_empty) ? 1 : 0;
           first_elem <= in_elem;
	   second_elem <= second_elem_clocked;	   
	end
	1: begin
	   next_state <= ((~out_full & ~in_empty) | (state == 1 & first_is_zero)) ? 0 : 1;	   
	   first_elem <= first_elem_clocked;	    
	   second_elem <= first_is_zero ? 0 : in_elem;	   
	end
      endcase
   end
   
endmodule

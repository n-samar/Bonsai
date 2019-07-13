`timescale 1 ns/10 ps

/* For 1-merger */
module BITONIC_NETWORK_2 #(parameter DATA_WIDTH = 128, 
			   parameter KEY_WIDTH = 80) (input i_clk,
						       input 			   switch_output,
						       input 			   stall,
						       input [DATA_WIDTH-1:0] 	   top_tuple,
						       input [DATA_WIDTH-1:0] 	   i_elems_0,
						       input [DATA_WIDTH-1:0] 	   i_elems_1, 
						       output reg [DATA_WIDTH-1:0] o_elems_0,
						       output reg [DATA_WIDTH-1:0] o_elems_1,
						       output reg 		   o_switch_output,
						       output reg 		   o_stall,
						       output [DATA_WIDTH-1:0] 	   o_top_tuple);

   initial begin
      o_stall <= 0;
      o_elems_0 <= 0;
      o_elems_1 <= 0;
   end

   assign o_top_tuple = top_tuple;
   
   
   always @(posedge i_clk) begin
      o_stall <= stall;
      if (~stall) begin
	 o_switch_output <= switch_output;
	 if (i_elems_1[KEY_WIDTH-1:0] >= i_elems_0[KEY_WIDTH-1:0]) begin
	    o_elems_0 <= i_elems_0;
	    o_elems_1 <= i_elems_1;
	 end
	 else begin
	    o_elems_0 <= i_elems_1;
	    o_elems_1 <= i_elems_0;	 
	 end
      end // if (~stall)
   end
endmodule // BITONIC_NETWORK_2




   


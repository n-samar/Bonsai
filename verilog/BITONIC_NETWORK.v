`timescale 1 ns/10 ps

/* For 1-merger */
module BITONIC_NETWORK_2 (input i_clk,
			  input 	    switch_output,
			  input 	    stall,
			  input [31:0] 	    top_tuple,
			  input [31:0] 	    i_elems_0,
			  input [31:0] 	    i_elems_1, 
			  output reg [31:0] o_elems_0,
			  output reg [31:0] o_elems_1,
			  output reg 	    o_switch_output,
			  output reg 	    o_stall,
			  output [31:0]     o_top_tuple);

   initial begin
      /* nothing to do here */
   end

   assign o_top_tuple = top_tuple;
   
   
   always @(posedge i_clk) begin
      o_stall <= stall;
      if (~stall) begin
	 o_switch_output <= switch_output;
	 if (i_elems_1 >= i_elems_0) begin
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


/* For 2-merger */
module BITONIC_NETWORK_4 (input i_clk,
			  input 		switch_output,
			  input 		stall,
			  input [2*32-1:0] 	top_tuple,
			  input [2*32-1:0] 	i_elems_0,
			  input [2*32-1:0] 	i_elems_1, 
			  output reg [2*32-1:0] o_elems_0,
			  output reg [2*32-1:0] o_elems_1,
			  output reg 		o_switch_output,
			  output reg 		o_stall,
			  output [2*32-1:0] 	o_top_tuple);

   reg 					stall_1;
   reg 					switch_output_1;
   reg [2*32-1:0] 			elems_1_0;
   reg [2*32-1:0] 			elems_1_1;   
   wire [2*32-1:0] 			top_tuple_1 [0:1];

   assign top_tuple_1 = top_tuple;
   
   initial begin
      stall_1 <= 0;
      switch_output_1 <= 0;
      top_tuple_1[0] <= 0;
      top_tuple_1[1] <= 0;      
      elems_1_0 <= 0;
      elems_1_1 <= 0;
   end

   /* step 1 */
   always @(posedge i_clk) begin
      stall_1 <= stall;
      switch_output_1 <= switch_output;
      
      if (i_elems_1[2*32-1 : 32] >= i_elems_0[2*32-1 : 32]) begin
	 elems_1_1[2*32-1 : 32] <= i_elems_1[2*32-1 : 32];
	 elems_1_0[2*32-1 : 32] <= i_elems_0[2*32-1 : 32];	 
      end
      else begin
	 elems_1_1[2*32-1 : 32] <= i_elems_0[2*32-1 : 32];
	 elems_1_0[2*32-1 : 32] <= i_elems_1[2*32-1 : 32];	 
      end

      if (i_elems_1[31:0] >= i_elems_0[31:0]) begin
	 elems_1_1[31:0] <= i_elems_1[31:0];
	 elems_1_0[31:0] <= i_elems_0[31:0];	 
      end
      else begin
	 elems_1_1[31:0] <= i_elems_0[31:0];
	 elems_1_0[31:0] <= i_elems_1[31:0];	 
      end           
   end

   /* step 2 */
   always @(posedge i_clk) begin
      o_stall <= stall_1;
      o_switch_output <= switch_output_1;
      o_top_tuple <= top_tuple_1;

      if (elems_1_1[2*32-1 : 32] >= elems_1_1[31:0]) begin
	 o_elems[3] <= elems_1_1[2*32-1 : 32];
	 o_elems[2] <= elems_1_1[31:0];	 
      end
      else begin
	 o_elems[3] <= elems_1_1[31:0];
	 o_elems[2] <= elems_1_1[2*32-1 : 32];	 
      end

      if (elems_1_0[2*32-1 : 32] >= elems_1_1[31:0]) begin
	 o_elems[1] <= elems_1_0[2*32-1 : 32];
	 o_elems[0] <= elems_1_1[31:0];	 
      end
      else begin
	 o_elems[1] <= elems_1_1[31:0];
	 o_elems[0] <= elems_1_0[2*32-1 : 32];	 
      end            
   end
endmodule

   


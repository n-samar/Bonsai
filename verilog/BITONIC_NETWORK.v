`timescale 1 ns/10 ps

module BITONIC_NETWORK_2 (input i_clk,
			  input 	switch_output,
			  input 	stall,
			  input [31:0] 	top_tuple,
			  input [31:0] 	i_elems [0:1],
			  output [31:0] o_elems [0:1],
			  output o_switch_output,
			  output o_stall,
			  output [31:0] o_top_tuple);
   
   always @(posedge i_clk) begin
      o_stall <= stall;
      o_switch_output <= switch_output;
      o_top_tuple <= top_tuple;
      if (i_elems[1] >= i_elems[0]) begin
	 o_elems[0] <= i_elems[0];
	 o_elems[1] <= i_elems[1];
      end
      else begin
	 o_elems[0] <= i_elems[1];
	 o_elems[1] <= i_elems[0];	 
      end
   end
endmodule
			  
module BITONIC_NETWORK_4 (input i_clk,
			  input 	switch_output,
			  input 	stall,
			  input [31:0] 	top_tuple [0:1],
			  input [31:0] 	i_elems [0:3],
			  output [31:0] o_elems [0:3],
			  output o_switch_output,
			  output o_stall,
			  output [31:0] o_top_tuple [0:1]);

   reg 					stall_1;
   reg 					switch_output_1;
   reg [31:0] 				elems_1 [0:3];
   reg [31:0] 				top_tuple_1 [0:1];

   initial begin
      stall_1 <= 0;
      switch_output_1 <= 0;
      top_tuple_1[0] <= 0;
      top_tuple_1[1] <= 0;      
      elems_1[0] <= 0;
      elems_1[1] <= 0;
      elems_1[2] <= 0;
      elems_1[3] <= 0;
   end

   /* 1 -> output */
   always @(posedge i_clk) begin
      o_stall < stall_1;
      o_switch_output <= switch_output_1;
      o_top_tuple[0] <= top_tuple_1[0];
      o_top_tuple[1] <= top_tuple_1[1];

      if (elems_1[3] >= elems_1[2]) begin
	 o_elems[3] <= elems_1[3];
	 o_elems[2] <= elems_1[2];	 
      end
      else begin
	 o_elems[3] <= elems_1[2];
	 o_elems[2] <= elems_1[3];	 
      end

      if (elems_1[1] >= elems_1[0]) begin
	 o_elems[1] <= elems_1[1];
	 o_elems[0] <= elems_1[0];	 
      end
      else begin
	 o_elems[1] <= elems_1[0];
	 o_elems[0] <= elems_1[1];	 
      end            
   end
   
   /* input -> 1 for network */
   always @(posedge i_clk) begin
      if (i_elems[3] >= i_elems[1]) begin
	 elems_1[3] <= i_elems[3];
	 elems_1[1] <= i_elems[1];	 
      end
      else begin
	 elems_1[3] <= i_elems[1];
	 elems_1[1] <= i_elems[3];	 
      end

      if (i_elems[2] >= i_elems[0]) begin
	 elems_1[2] <= i_elems[2];
	 elems_1[0] <= i_elems[0];	 
      end
      else begin
	 elems_1[2] <= i_elems[0];
	 elems_1[0] <= i_elems[2];	 
      end      
   end
   
   
   /* input -> 1 for data transfer */
   always @(posedge i_clk) begin
      #3;   /* We must wait for the i_top_tuple signal to be ready */	
      stall_1 <= stall;
      switch_output_1 <= switch_output;
      top_tuple_1[0] <= top_tuple[0];
      top_tuple_1[1] <= top_tuple[1];
   end
endmodule

   

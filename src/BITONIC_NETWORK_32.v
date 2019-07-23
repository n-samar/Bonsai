/* For 16-merger */

module CAS #(parameter DATA_WIDTH = 128,
	     parameter KEY_WIDTH  = 80) (input i_clk,
            input         stall,
            input [DATA_WIDTH-1:0]  i_elems_0,
            input [DATA_WIDTH-1:0]  i_elems_1,
            output reg [DATA_WIDTH-1:0] o_elems_0,
            output reg [DATA_WIDTH-1:0] o_elems_1);

   initial begin
      o_elems_0 <= 0;
      o_elems_1 <= 0;      
   end
   
   always @(posedge i_clk) begin
      if (~stall) begin
         if (i_elems_0[KEY_WIDTH-1:0] > i_elems_1[KEY_WIDTH-1:0]) begin
	        /* switch */
	        o_elems_1 <= i_elems_0;
            o_elems_0 <= i_elems_1;
         end
         else begin
	        /* stay */
	        o_elems_1 <= i_elems_1;      
            o_elems_0 <= i_elems_0;
         end              
      end 
   end  
endmodule
   

module BITONIC_NETWORK_32 #(parameter DATA_WIDTH = 128,
			    parameter KEY_WIDTH = 80) (input i_clk,
						       input 			      switch_output,
						       input 			      stall,
						       input [16*DATA_WIDTH-1:0]      top_tuple,
						       input [16*DATA_WIDTH-1:0]      i_elems_0,
						       input [16*DATA_WIDTH-1:0]      i_elems_1, 
						       output [16*DATA_WIDTH-1:0]     o_elems_0,
						       output [16*DATA_WIDTH-1:0]     o_elems_1,
						       output reg 		      o_switch_output,
						       output reg 		      o_stall,
						       output reg [16*DATA_WIDTH-1:0] o_top_tuple);

   
   reg 										      stall_1;
   reg 										      stall_2;
   reg 										      stall_3;
   reg 										      stall_4;   
   
   reg 										      switch_output_1;
   reg 										      switch_output_2;
   reg 										      switch_output_3;
   reg 										      switch_output_4;   
   
   wire [16*DATA_WIDTH-1:0] 							      top_tuple_1;
   reg [16*DATA_WIDTH-1:0] 							      top_tuple_2;
   reg [16*DATA_WIDTH-1:0] 							      top_tuple_3;
   reg [16*DATA_WIDTH-1:0] 							      top_tuple_4;         
   
   wire [2*16*DATA_WIDTH-1:0] 							      elems_1;
   wire [2*16*DATA_WIDTH-1:0] 							      elems_2;
   wire [2*16*DATA_WIDTH-1:0] 							      elems_3;   
   wire [2*16*DATA_WIDTH-1:0] 							      elems_4;
   
   initial begin
      stall_1 <= 1;
      switch_output_1 <= 0;

      stall_2 <= 1;
      switch_output_2 <= 0;
      top_tuple_2 <= 0;
      
      stall_3 <= 1;
      switch_output_3 <= 0;
      top_tuple_3 <= 0;

      stall_4 <= 1;
      switch_output_4 <= 0;
      top_tuple_4 <= 0;

      o_stall <= 0;      
   end

   genvar i, j;

   /* step 1 */   
   generate
      for (i=0; i<16; i=i+1) begin : GEN
         CAS #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH)) cas(.i_clk(i_clk),
                 .stall(stall), 
                 .i_elems_0(i_elems_0[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]), 
                 .i_elems_1(i_elems_1[(16-i)*DATA_WIDTH-1:(16-i-1)*DATA_WIDTH]),
                 .o_elems_0(elems_1[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]), 
                 .o_elems_1(elems_1[(32-i)*DATA_WIDTH-1:(32-i-1)*DATA_WIDTH]));         
      end
   endgenerate

   /* step 2 */   
   generate
      for (j=0; j<2; j=j+1) begin : GEN2
         for (i=0; i<8; i=i+1) begin
            CAS #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH)) cas(.i_clk(i_clk),
                    .stall(stall_1), 
                    .i_elems_0(elems_1[(16*j+i+1)*DATA_WIDTH-1:(16*j+i)*DATA_WIDTH]), 
                    .i_elems_1(elems_1[(16*j+i+1+8)*DATA_WIDTH-1:(16*j+i+8)*DATA_WIDTH]),
                    .o_elems_0(elems_2[(16*j+i+1)*DATA_WIDTH-1:(16*j+i)*DATA_WIDTH]), 
                    .o_elems_1(elems_2[(16*j+i+1+8)*DATA_WIDTH-1:(16*j+i+8)*DATA_WIDTH]));
         end
      end
   endgenerate

   /* step 3 */   
   generate
      for (j=0; j<4; j=j+1) begin : GEN3
         for (i=0; i<4; i=i+1) begin
            CAS #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH)) cas(.i_clk(i_clk),
                    .stall(stall_2),
                    .i_elems_0(elems_2[(8*j+i+1)*DATA_WIDTH-1:(8*j+i)*DATA_WIDTH]), 
                    .i_elems_1(elems_2[(8*j+i+1+4)*DATA_WIDTH-1:(8*j+i+4)*DATA_WIDTH]),
                    .o_elems_0(elems_3[(8*j+i+1)*DATA_WIDTH-1:(8*j+i)*DATA_WIDTH]), 
                    .o_elems_1(elems_3[(8*j+i+1+4)*DATA_WIDTH-1:(8*j+i+4)*DATA_WIDTH]));       
         end
      end
   endgenerate

   /* step 3 */   
   generate
      for (j=0; j<8; j=j+1) begin : GEN4
         for (i=0; i<2; i=i+1) begin
            CAS #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH)) cas(.i_clk(i_clk),
                    .stall(stall_3),
                    .i_elems_0(elems_3[(4*j+i+1)*DATA_WIDTH-1:(4*j+i)*DATA_WIDTH]), 
                    .i_elems_1(elems_3[(4*j+i+1+2)*DATA_WIDTH-1:(4*j+i+2)*DATA_WIDTH]),
                    .o_elems_0(elems_4[(4*j+i+1)*DATA_WIDTH-1:(4*j+i)*DATA_WIDTH]), 
                    .o_elems_1(elems_4[(4*j+i+1+2)*DATA_WIDTH-1:(4*j+i+2)*DATA_WIDTH]));       
         end
      end
   endgenerate   

   /* step 4 */   
   generate
      for (i=0; i<16; i=i+2) begin : GEN5
            CAS #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH)) cas1(.i_clk(i_clk),
                    .stall(stall_4),
                    .i_elems_0(elems_4[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]), 
                    .i_elems_1(elems_4[(i+2)*DATA_WIDTH-1:(i+1)*DATA_WIDTH]),
                    .o_elems_0(o_elems_0[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]), 
                    .o_elems_1(o_elems_0[(i+2)*DATA_WIDTH-1:(i+1)*DATA_WIDTH]));
            CAS #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH)) cas2(.i_clk(i_clk),
                    .stall(stall_4),
                    .i_elems_0(elems_4[16*DATA_WIDTH+(i+1)*DATA_WIDTH-1:16*DATA_WIDTH+i*DATA_WIDTH]), 
                    .i_elems_1(elems_4[16*DATA_WIDTH+(i+2)*DATA_WIDTH-1:16*DATA_WIDTH+(i+1)*DATA_WIDTH]),
                    .o_elems_0(o_elems_1[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]), 
                    .o_elems_1(o_elems_1[(i+2)*DATA_WIDTH-1:(i+1)*DATA_WIDTH]));                
      end
   endgenerate         
   
   /* step 1 */
   assign top_tuple_1 = top_tuple;   
   always @(posedge i_clk) begin
      stall_1 <= stall;
      
      if (~stall) begin
	     switch_output_1 <= switch_output;
      end // if (~stall)      
   end
   
   /* step 2 */
   always @(posedge i_clk) begin
      stall_2 <= stall_1;
      if (~stall_1) begin
	     switch_output_2 <= switch_output_1;
	     top_tuple_2 <= top_tuple_1;                  
      end
   end // always @ (posedge i_clk)

   /* step 3 */
   always @(posedge i_clk) begin
      stall_3 <= stall_2;
      if (~stall_2) begin
	     switch_output_3 <= switch_output_2;
	     top_tuple_3 <= top_tuple_2;
      end
   end

   /* step 4 */
   always @(posedge i_clk) begin
      stall_4 <= stall_3;
      if (~stall_3) begin
	     switch_output_4 <= switch_output_3;
	     top_tuple_4 <= top_tuple_3;
      end
   end   

   /* step 5 */
   always @(posedge i_clk) begin
      o_stall <= stall_4;
      if (~stall_4) begin
	     o_switch_output <= switch_output_4;
	     o_top_tuple <= top_tuple_4;
      end
   end    
endmodule // BITONIC_NETWORK_DATA_WIDTH




   


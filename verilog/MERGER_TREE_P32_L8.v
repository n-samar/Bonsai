`timescale 1 ns/10 ps


module MERGER_TREE_P16_L8 #(parameter L = 8) (input i_clk,
					   input [32*8*L-1:0]   i_fifo,
					   input [2*L-1:0]      i_fifo_empty,
					   input 	      i_fifo_out_ready,
					   output [2*L-1:0]     o_fifo_read, 
					   output 	      o_out_fifo_write,
					   output wire [32*32-1:0] o_data);
   parameter log_L = 3;

   wire [8*32-1:0] 					      fifo_o_item_3 [7:0];
   wire [4*32-1:0] 						      fifo_i_item_3 [7:0];   
   wire [7:0] 						      fifo_read_3;
   wire [7:0] 						      fifo_write_3;
   wire [7:0] 						      fifo_empty_3;
   wire [7:0] 						      fifo_full_3;      

   wire [16*32-1:0] 					      fifo_o_item_2 [3:0];
   wire [8*32-1:0] 					      fifo_i_item_2 [3:0];   
   wire [3:0] 						      fifo_read_2;
   wire [3:0] 						      fifo_write_2;
   wire [3:0] 						      fifo_empty_2;
   wire [3:0] 						      fifo_full_2;

   wire [32*32-1:0] 					      fifo_o_item_1 [1:0];
   wire [16*32-1:0] 					      fifo_i_item_1 [1:0];   
   wire [1:0] 						      fifo_read_1;
   wire [1:0] 						      fifo_write_1;
   wire [1:0] 						      fifo_empty_1;
   wire [1:0] 						      fifo_full_1;

   
   genvar						      level, i;   
   generate
      for (level = L; level > 1; level = level/2) begin : IN
	 for (i = 0; i < level; i=i+1) begin
	    if (level == 8) begin
	       MERGER_4 merger(.i_clk(i_clk),
			     .i_fifo_1(i_fifo[32*8*i+4*32-1:32*8*i]),
			     .i_fifo_1_empty(i_fifo_empty[2*i]),
			     .i_fifo_2(i_fifo[32*8*i+4*32+4*32-1:32*8*i+4*32]),
			     .i_fifo_2_empty(i_fifo_empty[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_3[i] | fifo_read_3[i]),
			     .o_fifo_1_read(o_fifo_read[2*i]),
			     .o_fifo_2_read(o_fifo_read[2*i+1]),
			     .o_out_fifo_write(fifo_write_3[i]),
			     .o_data(fifo_i_item_3[i]));
	       COUPLER #(128) fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item_3[i]),
			    .i_enq(fifo_write_3[i]),
			    .i_deq(fifo_read_3[i]),
			    .o_data(fifo_o_item_3[i]),
			    .o_empty(fifo_empty_3[i]),
			    .o_full(fifo_full_3[i]));	       
	    end
	    else if (level == 4) begin
	       MERGER_8 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item_3[2*i]),
			     .i_fifo_1_empty(fifo_empty_3[2*i]),
			     .i_fifo_2(fifo_o_item_3[2*i+1]),
			     .i_fifo_2_empty(fifo_empty_3[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_2[i] | fifo_read_2[i]),
			     .o_fifo_1_read(fifo_read_3[2*i]),
			     .o_fifo_2_read(fifo_read_3[2*i+1]),
			     .o_out_fifo_write(fifo_write_2[i]),
			     .o_data(fifo_i_item_2[i]));
	       COUPLER #(256) fifo(.i_clk(i_clk),
				  .i_data(fifo_i_item_2[i]),
				  .i_enq(fifo_write_2[i]),
				  .i_deq(fifo_read_2[i]),
				  .o_data(fifo_o_item_2[i]),
				  .o_empty(fifo_empty_2[i]),
				  .o_full(fifo_full_2[i]));
	    end
	    else if (level == 2) begin
	       MERGER_16 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item_2[2*i]),
			     .i_fifo_1_empty(fifo_empty_2[2*i]),
			     .i_fifo_2(fifo_o_item_2[2*i+1]),
			     .i_fifo_2_empty(fifo_empty_2[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_1[i] | fifo_read_1[i]),
			     .o_fifo_1_read(fifo_read_2[2*i]),
			     .o_fifo_2_read(fifo_read_2[2*i+1]),
			     .o_out_fifo_write(fifo_write_1[i]),
			     .o_data(fifo_i_item_1[i]));
	       COUPLER #(512) fifo(.i_clk(i_clk),
				   .i_data(fifo_i_item_1[i]),
				   .i_enq(fifo_write_1[i]),
				   .i_deq(fifo_read_1[i]),
				   .o_data(fifo_o_item_1[i]),
				   .o_empty(fifo_empty_1[i]),
				   .o_full(fifo_full_1[i]));
	    end
	 end
      end
    endgenerate
   
   MERGER_32 merger(.i_clk(i_clk),
		   .i_fifo_1(fifo_o_item_1[0]),
		   .i_fifo_1_empty(fifo_empty_1[0]),
		   .i_fifo_2(fifo_o_item_1[1]),
		   .i_fifo_2_empty(fifo_empty_1[1]),
		   .i_fifo_out_ready(i_fifo_out_ready),
		   .o_fifo_1_read(fifo_read_1[0]),
		   .o_fifo_2_read(fifo_read_1[1]),
		   .o_out_fifo_write(o_out_fifo_write),
		   .o_data(o_data)
		   );	       
   
endmodule

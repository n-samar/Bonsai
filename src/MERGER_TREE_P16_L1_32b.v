`timescale 1 ns/10 ps


module MERGER_TREE_P16_L1 #(parameter L = 1, parameter DATA_WIDTH = 32, KEY_WIDTH = 32) (input i_clk,
					     input [16*DATA_WIDTH*2*L-1:0] i_fifo,
					     input [2*L-1:0] 	  i_fifo_empty,
					     input 		  i_fifo_out_ready,
					     output [2*L-1:0] 	  o_fifo_read, 
					     output 		  o_out_fifo_write,
					     output wire [16*DATA_WIDTH-1:0] o_data);


   wire [1:0] 							    fifo_read_1;
   wire [1:0] 							    fifo_write_1;
   wire [1:0] 							    fifo_empty_1;
   wire [1:0] 							    fifo_full_1;
   
   MERGER_16 #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH)) merger(.i_clk(i_clk),
		 .i_fifo_1(i_fifo[DATA_WIDTH*8*0+16*DATA_WIDTH-1:DATA_WIDTH*16*0]),
		 .i_fifo_1_empty(i_fifo_empty[0]),
		 .i_fifo_2(i_fifo[DATA_WIDTH*8*0+16*DATA_WIDTH-1+DATA_WIDTH*16:DATA_WIDTH*16*0+DATA_WIDTH*16]),
		 .i_fifo_2_empty(i_fifo_empty[1]),
		 .i_fifo_out_ready(i_fifo_out_ready),
		 .o_fifo_1_read(o_fifo_read[0]),
		 .o_fifo_2_read(o_fifo_read[1]),
		 .o_out_fifo_write(o_out_fifo_write),
		 .o_data(o_data)
		 );	       
   
endmodule
			 

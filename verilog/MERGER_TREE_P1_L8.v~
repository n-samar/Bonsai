`timescale 1 ns/10 ps

module MERGER_TREE_P1_L4(input i_clk,
			 input [31:0] 	    i_fifo_0,
			 input 		    i_fifo_0_empty,
			 input [31:0] 	    i_fifo_1,
			 input 		    i_fifo_1_empty,
			 input [31:0] 	    i_fifo_2,
			 input 		    i_fifo_2_empty,
			 input [31:0] 	    i_fifo_3,
			 input 		    i_fifo_3_empty,
			 input [31:0] 	    i_fifo_4,
			 input 		    i_fifo_4_empty,
			 input [31:0] 	    i_fifo_5,
			 input 		    i_fifo_5_empty,
			 input [31:0] 	    i_fifo_6,
			 input 		    i_fifo_6_empty,
			 input [31:0] 	    i_fifo_7,
			 input 		    i_fifo_7_empty, 
			 input 		    i_fifo_out_ready,
			 output 	    o_fifo_0_read,
			 output 	    o_fifo_1_read,
			 output 	    o_fifo_2_read,
			 output 	    o_fifo_3_read,
			 output 	    o_fifo_4_read,
			 output 	    o_fifo_5_read,
			 output 	    o_fifo_6_read,
			 output 	    o_fifo_7_read, 			 
			 output 	    o_out_fifo_write,
			 output wire [31:0] o_data);
   
   wire [31:0] 				    o_data_1_0;
   wire [31:0] 				    o_data_1_1;
   wire [31:0]				    fifo_1_0_i_item, fifo_1_1_i_item;
   wire [31:0] 				    fifo_1_0_o_item, fifo_1_1_o_item;
   wire 				    fifo_1_0_write, fifo_1_1_write;
   wire 				    fifo_1_0_read, fifo_1_1_read;
   wire 				    fifo_1_0_empty, fifo_1_1_empty;
   wire 				    fifo_1_0_full, fifo_1_1_full;

   wire [31:0]				    fifo_2_0_i_item, fifo_2_1_i_item;
   wire [31:0] 				    fifo_2_0_o_item, fifo_2_1_o_item;
   wire 				    fifo_2_0_write, fifo_2_1_write;
   wire 				    fifo_2_0_read, fifo_2_1_read;
   wire 				    fifo_2_0_empty, fifo_2_1_empty;
   wire 				    fifo_2_0_full, fifo_2_1_full;

   wire [31:0]				    fifo_2_2_i_item, fifo_2_3_i_item;
   wire [31:0] 				    fifo_2_2_o_item, fifo_2_3_o_item;
   wire 				    fifo_2_2_write, fifo_2_3_write;
   wire 				    fifo_2_2_read, fifo_2_3_read;
   wire 				    fifo_2_2_empty, fifo_2_3_empty;
   wire 				    fifo_2_2_full, fifo_2_3_full;         

   /* 0->output */
   MERGER_1 merger_0_0(.i_clk(i_clk),
		       .i_fifo_1(fifo_1_0_o_item),
		       .i_fifo_1_empty(fifo_1_0_empty),
		       .i_fifo_2(fifo_1_1_o_item),
		       .i_fifo_2_empty(fifo_1_1_empty),
		       .i_fifo_out_ready(i_fifo_out_ready),
		       .o_fifo_1_read(fifo_1_0_read),
		       .o_fifo_2_read(fifo_1_1_read),
		       .o_out_fifo_write(o_out_fifo_write),
		       .o_data(o_data));   

   /* 1->0 */   
   FIFO fifo_1_0(.i_clk(i_clk),
		 .i_item(fifo_1_0_i_item),
		 .i_write(fifo_1_0_write),
		 .i_read(fifo_1_0_read),
		 .o_item(fifo_1_0_o_item),
		 .empty(fifo_1_0_empty),
		 .full(fifo_1_0_full),
		 .overrun(),
		 .underrun());
   
   FIFO fifo_1_1(.i_clk(i_clk),
		 .i_item(fifo_1_1_i_item),
		 .i_write(fifo_1_1_write),
		 .i_read(fifo_1_1_read),
		 .o_item(fifo_1_1_o_item),
		 .empty(fifo_1_1_empty),
		 .full(fifo_1_1_full),
		 .overrun(),
		 .underrun());

   MERGER_1 merger_1_0(.i_clk(i_clk),
		       .i_fifo_1(fifo_2_0_o_item),
		       .i_fifo_1_empty(fifo_2_0_empty),
		       .i_fifo_2(fifo_2_1_o_item),
		       .i_fifo_2_empty(fifo_2_1_empty),
		       .i_fifo_out_ready(~fifo_1_0_full | fifo_1_0_read),
		       .o_fifo_1_read(fifo_2_0_read),
		       .o_fifo_2_read(fifo_2_1_read),
		       .o_out_fifo_write(fifo_1_0_write),
		       .o_data(fifo_1_0_i_item));
   
		       
   MERGER_1 merger_1_1(.i_clk(i_clk),
		       .i_fifo_1(fifo_2_2_o_item),
		       .i_fifo_1_empty(fifo_2_2_empty),
		       .i_fifo_2(fifo_2_3_o_item),
		       .i_fifo_2_empty(fifo_2_3_empty),
		       .i_fifo_out_ready(~fifo_1_1_full | fifo_1_1_read),
		       .o_fifo_1_read(fifo_2_2_read),
		       .o_fifo_2_read(fifo_2_3_read),
		       .o_out_fifo_write(fifo_1_1_write),
		       .o_data(fifo_1_1_i_item));

   /* 2-> 1 */
   FIFO fifo_2_0(.i_clk(i_clk),
		 .i_item(fifo_2_0_i_item),
		 .i_write(fifo_2_0_write),
		 .i_read(fifo_2_0_read),
		 .o_item(fifo_2_0_o_item),
		 .empty(fifo_2_0_empty),
		 .full(fifo_2_0_full),
		 .overrun(),
		 .underrun());
   
   FIFO fifo_2_1(.i_clk(i_clk),
		 .i_item(fifo_2_1_i_item),
		 .i_write(fifo_2_1_write),
		 .i_read(fifo_2_1_read),
		 .o_item(fifo_2_1_o_item),
		 .empty(fifo_2_1_empty),
		 .full(fifo_2_1_full),
		 .overrun(),
		 .underrun());

   FIFO fifo_2_2(.i_clk(i_clk),
		 .i_item(fifo_2_2_i_item),
		 .i_write(fifo_2_2_write),
		 .i_read(fifo_2_2_read),
		 .o_item(fifo_2_2_o_item),
		 .empty(fifo_2_2_empty),
		 .full(fifo_2_2_full),
		 .overrun(),
		 .underrun());
   
   FIFO fifo_2_3(.i_clk(i_clk),
		 .i_item(fifo_2_3_i_item),
		 .i_write(fifo_2_3_write),
		 .i_read(fifo_2_3_read),
		 .o_item(fifo_2_3_o_item),
		 .empty(fifo_2_3_empty),
		 .full(fifo_2_3_full),
		 .overrun(),
		 .underrun());   
   
   MERGER_1 merger_2_0(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_0),
		       .i_fifo_1_empty(i_fifo_0_empty),
		       .i_fifo_2(i_fifo_1),
		       .i_fifo_2_empty(i_fifo_1_empty),
		       .i_fifo_out_ready(~fifo_2_0_full | fifo_2_0_read),
		       .o_fifo_1_read(o_fifo_0_read),
		       .o_fifo_2_read(o_fifo_1_read),
		       .o_out_fifo_write(fifo_2_0_write),
		       .o_data(fifo_2_0_i_item));
   
		       
   MERGER_1 merger_2_1(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_2),
		       .i_fifo_1_empty(i_fifo_2_empty),
		       .i_fifo_2(i_fifo_3),
		       .i_fifo_2_empty(i_fifo_3_empty),
		       .i_fifo_out_ready(~fifo_2_1_full | fifo_2_1_read),
		       .o_fifo_1_read(o_fifo_2_read),
		       .o_fifo_2_read(o_fifo_3_read),
		       .o_out_fifo_write(fifo_2_1_write),
		       .o_data(fifo_2_1_i_item));

   MERGER_1 merger_2_2(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_4),
		       .i_fifo_1_empty(i_fifo_4_empty),
		       .i_fifo_2(i_fifo_5),
		       .i_fifo_2_empty(i_fifo_5_empty),
		       .i_fifo_out_ready(~fifo_2_2_full | fifo_2_2_read),
		       .o_fifo_1_read(o_fifo_4_read),
		       .o_fifo_2_read(o_fifo_5_read),
		       .o_out_fifo_write(fifo_2_2_write),
		       .o_data(fifo_2_2_i_item));
   
		       
   MERGER_1 merger_2_3(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_6),
		       .i_fifo_1_empty(i_fifo_6_empty),
		       .i_fifo_2(i_fifo_7),
		       .i_fifo_2_empty(i_fifo_7_empty),
		       .i_fifo_out_ready(~fifo_2_3_full | fifo_2_3_read),
		       .o_fifo_1_read(o_fifo_6_read),
		       .o_fifo_2_read(o_fifo_7_read),
		       .o_out_fifo_write(fifo_2_3_write),
		       .o_data(fifo_2_3_i_item));   
endmodule
			 
			 

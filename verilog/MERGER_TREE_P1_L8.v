`timescale 1 ns/10 ps

module MERGER_TREE_P1_L8(input i_clk,
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
			 input [31:0] 	    i_fifo_8,
			 input 		    i_fifo_8_empty,
			 input [31:0] 	    i_fifo_9,
			 input 		    i_fifo_9_empty,
			 input [31:0] 	    i_fifo_10,
			 input 		    i_fifo_10_empty,
			 input [31:0] 	    i_fifo_11,
			 input 		    i_fifo_11_empty,
			 input [31:0] 	    i_fifo_12,
			 input 		    i_fifo_12_empty,
			 input [31:0] 	    i_fifo_13,
			 input 		    i_fifo_13_empty,
			 input [31:0] 	    i_fifo_14,
			 input 		    i_fifo_14_empty,
			 input [31:0] 	    i_fifo_15,
			 input 		    i_fifo_15_empty, 
			 input 		    i_fifo_out_ready,
			 output 	    o_fifo_0_read,
			 output 	    o_fifo_1_read,
			 output 	    o_fifo_2_read,
			 output 	    o_fifo_3_read,
			 output 	    o_fifo_4_read,
			 output 	    o_fifo_5_read,
			 output 	    o_fifo_6_read,
			 output 	    o_fifo_7_read, 			 
			 output 	    o_fifo_8_read,
			 output 	    o_fifo_9_read,
			 output 	    o_fifo_10_read,
			 output 	    o_fifo_11_read,
			 output 	    o_fifo_12_read,
			 output 	    o_fifo_13_read,
			 output 	    o_fifo_14_read,
			 output 	    o_fifo_15_read, 			 
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

   wire [31:0]				    fifo_3_0_i_item, fifo_3_1_i_item;
   wire [31:0] 				    fifo_3_0_o_item, fifo_3_1_o_item;
   wire 				    fifo_3_0_write, fifo_3_1_write;
   wire 				    fifo_3_0_read, fifo_3_1_read;
   wire 				    fifo_3_0_empty, fifo_3_1_empty;
   wire 				    fifo_3_0_full, fifo_3_1_full;

   wire [31:0]				    fifo_3_2_i_item, fifo_3_3_i_item;
   wire [31:0] 				    fifo_3_2_o_item, fifo_3_3_o_item;
   wire 				    fifo_3_2_write, fifo_3_3_write;
   wire 				    fifo_3_2_read, fifo_3_3_read;
   wire 				    fifo_3_2_empty, fifo_3_3_empty;
   wire 				    fifo_3_2_full, fifo_3_3_full; 

   wire [31:0]				    fifo_3_4_i_item, fifo_3_5_i_item;
   wire [31:0] 				    fifo_3_4_o_item, fifo_3_5_o_item;
   wire 				    fifo_3_4_write, fifo_3_5_write;
   wire 				    fifo_3_4_read, fifo_3_5_read;
   wire 				    fifo_3_4_empty, fifo_3_5_empty;
   wire 				    fifo_3_4_full, fifo_3_5_full;

   wire [31:0]				    fifo_3_6_i_item, fifo_3_7_i_item;
   wire [31:0] 				    fifo_3_6_o_item, fifo_3_7_o_item;
   wire 				    fifo_3_6_write, fifo_3_7_write;
   wire 				    fifo_3_6_read, fifo_3_7_read;
   wire 				    fifo_3_6_empty, fifo_3_7_empty;
   wire 				    fifo_3_6_full, fifo_3_7_full;         

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
   IFIFO16 fifo_1_0(.i_clk(i_clk),
		 .i_data(fifo_1_0_i_item),
		 .i_enq(fifo_1_0_write),
		 .i_deq(fifo_1_0_read),
		 .o_data(fifo_1_0_o_item),
		 .o_empty(fifo_1_0_empty),
		 .o_full(fifo_1_0_full));
   
   IFIFO16 fifo_1_1(.i_clk(i_clk),
		 .i_data(fifo_1_1_i_item),
		 .i_enq(fifo_1_1_write),
		 .i_deq(fifo_1_1_read),
		 .o_data(fifo_1_1_o_item),
		 .o_empty(fifo_1_1_empty),
		 .o_full(fifo_1_1_full));

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
   IFIFO16 fifo_2_0(.i_clk(i_clk),
		 .i_data(fifo_2_0_i_item),
		 .i_enq(fifo_2_0_write),
		 .i_deq(fifo_2_0_read),
		 .o_data(fifo_2_0_o_item),
		 .o_empty(fifo_2_0_empty),
		 .o_full(fifo_2_0_full));
   
   IFIFO16 fifo_2_1(.i_clk(i_clk),
		 .i_data(fifo_2_1_i_item),
		 .i_enq(fifo_2_1_write),
		 .i_deq(fifo_2_1_read),
		 .o_data(fifo_2_1_o_item),
		 .o_empty(fifo_2_1_empty),
		 .o_full(fifo_2_1_full));

   IFIFO16 fifo_2_2(.i_clk(i_clk),
		 .i_data(fifo_2_2_i_item),
		 .i_enq(fifo_2_2_write),
		 .i_deq(fifo_2_2_read),
		 .o_data(fifo_2_2_o_item),
		 .o_empty(fifo_2_2_empty),
		 .o_full(fifo_2_2_full));
   
   IFIFO16 fifo_2_3(.i_clk(i_clk),
		 .i_data(fifo_2_3_i_item),
		 .i_enq(fifo_2_3_write),
		 .i_deq(fifo_2_3_read),
		 .o_data(fifo_2_3_o_item),
		 .o_empty(fifo_2_3_empty),
		 .o_full(fifo_2_3_full));   
   
   MERGER_1 merger_2_0(.i_clk(i_clk),
		       .i_fifo_1(fifo_3_0_o_item),
		       .i_fifo_1_empty(fifo_3_0_empty),
		       .i_fifo_2(fifo_3_1_o_item),
		       .i_fifo_2_empty(fifo_3_1_empty),
		       .i_fifo_out_ready(~fifo_2_0_full | fifo_2_0_read),
		       .o_fifo_1_read(fifo_3_0_read),
		       .o_fifo_2_read(fifo_3_1_read),
		       .o_out_fifo_write(fifo_2_0_write),
		       .o_data(fifo_2_0_i_item));
   
		       
   MERGER_1 merger_2_1(.i_clk(i_clk),
		       .i_fifo_1(fifo_3_2_o_item),
		       .i_fifo_1_empty(fifo_3_2_empty),
		       .i_fifo_2(fifo_3_3_o_item),
		       .i_fifo_2_empty(fifo_3_3_empty),
		       .i_fifo_out_ready(~fifo_2_1_full | fifo_2_1_read),
		       .o_fifo_1_read(fifo_3_2_read),
		       .o_fifo_2_read(fifo_3_3_read),
		       .o_out_fifo_write(fifo_2_1_write),
		       .o_data(fifo_2_1_i_item));

   MERGER_1 merger_2_2(.i_clk(i_clk),
		       .i_fifo_1(fifo_3_4_o_item),
		       .i_fifo_1_empty(fifo_3_4_empty),
		       .i_fifo_2(fifo_3_5_o_item),
		       .i_fifo_2_empty(fifo_3_5_empty),
		       .i_fifo_out_ready(~fifo_2_2_full | fifo_2_2_read),
		       .o_fifo_1_read(fifo_3_4_read),
		       .o_fifo_2_read(fifo_3_5_read),
		       .o_out_fifo_write(fifo_2_2_write),
		       .o_data(fifo_2_2_i_item));
   
		       
   MERGER_1 merger_2_3(.i_clk(i_clk),
		       .i_fifo_1(fifo_3_6_o_item),
		       .i_fifo_1_empty(fifo_3_6_empty),
		       .i_fifo_2(fifo_3_7_o_item),
		       .i_fifo_2_empty(fifo_3_7_empty),
		       .i_fifo_out_ready(~fifo_2_3_full | fifo_2_3_read),
		       .o_fifo_1_read(fifo_3_6_read),
		       .o_fifo_2_read(fifo_3_7_read),
		       .o_out_fifo_write(fifo_2_3_write),
		       .o_data(fifo_2_3_i_item));


   /* 3 -> 2 */
   IFIFO16 fifo_3_0(.i_clk(i_clk),
		 .i_data(fifo_3_0_i_item),
		 .i_enq(fifo_3_0_write),
		 .i_deq(fifo_3_0_read),
		 .o_data(fifo_3_0_o_item),
		 .o_empty(fifo_3_0_empty),
		 .o_full(fifo_3_0_full));
   
   IFIFO16 fifo_3_1(.i_clk(i_clk),
		 .i_data(fifo_3_1_i_item),
		 .i_enq(fifo_3_1_write),
		 .i_deq(fifo_3_1_read),
		 .o_data(fifo_3_1_o_item),
		 .o_empty(fifo_3_1_empty),
		 .o_full(fifo_3_1_full));

   IFIFO16 fifo_3_2(.i_clk(i_clk),
		 .i_data(fifo_3_2_i_item),
		 .i_enq(fifo_3_2_write),
		 .i_deq(fifo_3_2_read),
		 .o_data(fifo_3_2_o_item),
		 .o_empty(fifo_3_2_empty),
		 .o_full(fifo_3_2_full));
   
   IFIFO16 fifo_3_3(.i_clk(i_clk),
		 .i_data(fifo_3_3_i_item),
		 .i_enq(fifo_3_3_write),
		 .i_deq(fifo_3_3_read),
		 .o_data(fifo_3_3_o_item),
		 .o_empty(fifo_3_3_empty),
		 .o_full(fifo_3_3_full));

   IFIFO16 fifo_3_4(.i_clk(i_clk),
		 .i_data(fifo_3_4_i_item),
		 .i_enq(fifo_3_4_write),
		 .i_deq(fifo_3_4_read),
		 .o_data(fifo_3_4_o_item),
		 .o_empty(fifo_3_4_empty),
		 .o_full(fifo_3_4_full));
   
   IFIFO16 fifo_3_5(.i_clk(i_clk),
		 .i_data(fifo_3_5_i_item),
		 .i_enq(fifo_3_5_write),
		 .i_deq(fifo_3_5_read),
		 .o_data(fifo_3_5_o_item),
		 .o_empty(fifo_3_5_empty),
		 .o_full(fifo_3_5_full));

   IFIFO16 fifo_3_6(.i_clk(i_clk),
		 .i_data(fifo_3_6_i_item),
		 .i_enq(fifo_3_6_write),
		 .i_deq(fifo_3_6_read),
		 .o_data(fifo_3_6_o_item),
		 .o_empty(fifo_3_6_empty),
		 .o_full(fifo_3_6_full));
   
   IFIFO16 fifo_3_7(.i_clk(i_clk),
		 .i_data(fifo_3_7_i_item),
		 .i_enq(fifo_3_7_write),
		 .i_deq(fifo_3_7_read),
		 .o_data(fifo_3_7_o_item),
		 .o_empty(fifo_3_7_empty),
		 .o_full(fifo_3_7_full));      
   
   MERGER_1 merger_3_0(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_0),
		       .i_fifo_1_empty(i_fifo_0_empty),
		       .i_fifo_2(i_fifo_1),
		       .i_fifo_2_empty(i_fifo_1_empty),
		       .i_fifo_out_ready(~fifo_3_0_full | fifo_3_0_read),
		       .o_fifo_1_read(o_fifo_0_read),
		       .o_fifo_2_read(o_fifo_1_read),
		       .o_out_fifo_write(fifo_3_0_write),
		       .o_data(fifo_3_0_i_item));
   
		       
   MERGER_1 merger_3_1(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_2),
		       .i_fifo_1_empty(i_fifo_2_empty),
		       .i_fifo_2(i_fifo_3),
		       .i_fifo_2_empty(i_fifo_3_empty),
		       .i_fifo_out_ready(~fifo_3_1_full | fifo_3_1_read),
		       .o_fifo_1_read(o_fifo_2_read),
		       .o_fifo_2_read(o_fifo_3_read),
		       .o_out_fifo_write(fifo_3_1_write),
		       .o_data(fifo_3_1_i_item));

   MERGER_1 merger_3_2(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_4),
		       .i_fifo_1_empty(i_fifo_4_empty),
		       .i_fifo_2(i_fifo_5),
		       .i_fifo_2_empty(i_fifo_5_empty),
		       .i_fifo_out_ready(~fifo_3_2_full | fifo_3_2_read),
		       .o_fifo_1_read(o_fifo_4_read),
		       .o_fifo_2_read(o_fifo_5_read),
		       .o_out_fifo_write(fifo_3_2_write),
		       .o_data(fifo_3_2_i_item));
   
		       
   MERGER_1 merger_3_3(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_6),
		       .i_fifo_1_empty(i_fifo_6_empty),
		       .i_fifo_2(i_fifo_7),
		       .i_fifo_2_empty(i_fifo_7_empty),
		       .i_fifo_out_ready(~fifo_3_3_full | fifo_3_3_read),
		       .o_fifo_1_read(o_fifo_6_read),
		       .o_fifo_2_read(o_fifo_7_read),
		       .o_out_fifo_write(fifo_3_3_write),
		       .o_data(fifo_3_3_i_item));

   MERGER_1 merger_3_4(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_8),
		       .i_fifo_1_empty(i_fifo_8_empty),
		       .i_fifo_2(i_fifo_9),
		       .i_fifo_2_empty(i_fifo_9_empty),
		       .i_fifo_out_ready(~fifo_3_4_full | fifo_3_4_read),
		       .o_fifo_1_read(o_fifo_8_read),
		       .o_fifo_2_read(o_fifo_9_read),
		       .o_out_fifo_write(fifo_3_4_write),
		       .o_data(fifo_3_4_i_item));
   
		       
   MERGER_1 merger_3_5(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_10),
		       .i_fifo_1_empty(i_fifo_10_empty),
		       .i_fifo_2(i_fifo_11),
		       .i_fifo_2_empty(i_fifo_11_empty),
		       .i_fifo_out_ready(~fifo_3_5_full | fifo_3_5_read),
		       .o_fifo_1_read(o_fifo_10_read),
		       .o_fifo_2_read(o_fifo_11_read),
		       .o_out_fifo_write(fifo_3_5_write),
		       .o_data(fifo_3_5_i_item));

   MERGER_1 merger_3_6(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_12),
		       .i_fifo_1_empty(i_fifo_12_empty),
		       .i_fifo_2(i_fifo_13),
		       .i_fifo_2_empty(i_fifo_13_empty),
		       .i_fifo_out_ready(~fifo_3_6_full | fifo_3_6_read),
		       .o_fifo_1_read(o_fifo_12_read),
		       .o_fifo_2_read(o_fifo_13_read),
		       .o_out_fifo_write(fifo_3_6_write),
		       .o_data(fifo_3_6_i_item));
   
		       
   MERGER_1 merger_3_7(.i_clk(i_clk),
		       .i_fifo_1(i_fifo_14),
		       .i_fifo_1_empty(i_fifo_14_empty),
		       .i_fifo_2(i_fifo_15),
		       .i_fifo_2_empty(i_fifo_15_empty),
		       .i_fifo_out_ready(~fifo_3_7_full | fifo_3_7_read),
		       .o_fifo_1_read(o_fifo_14_read),
		       .o_fifo_2_read(o_fifo_15_read),
		       .o_out_fifo_write(fifo_3_7_write),
		       .o_data(fifo_3_7_i_item));         
endmodule
			 
		       

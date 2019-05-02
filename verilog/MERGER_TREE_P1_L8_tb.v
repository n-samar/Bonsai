`timescale 1 ns/10 ps

module merger_tree_tb;
   reg write_fifo_0, write_fifo_1, write_fifo_2, write_fifo_3, write_fifo_4, write_fifo_5, write_fifo_6, write_fifo_7;
   reg write_fifo_8, write_fifo_9, write_fifo_10, write_fifo_11, write_fifo_12, write_fifo_13, write_fifo_14, write_fifo_15;   
   reg read_fifo_out;
   
   wire [31:0] 			   out_fifo_0;
   wire [31:0] 			   out_fifo_1;
   wire [31:0] 			   out_fifo_2;
   wire [31:0] 			   out_fifo_3;
   wire [31:0] 			   out_fifo_4;
   wire [31:0] 			   out_fifo_5;
   wire [31:0] 			   out_fifo_6;
   wire [31:0] 			   out_fifo_7;
   wire [31:0] 			   out_fifo_8;
   wire [31:0] 			   out_fifo_9;
   wire [31:0] 			   out_fifo_10;
   wire [31:0] 			   out_fifo_11;
   wire [31:0] 			   out_fifo_12;
   wire [31:0] 			   out_fifo_13;
   wire [31:0] 			   out_fifo_14;
   wire [31:0] 			   out_fifo_15;      
   reg [31:0] 			   in_fifo_0;
   reg [31:0] 			   in_fifo_1; 
   reg [31:0] 			   in_fifo_2;
   reg [31:0] 			   in_fifo_3;
   reg [31:0] 			   in_fifo_4;
   reg [31:0] 			   in_fifo_5; 
   reg [31:0] 			   in_fifo_6;
   reg [31:0] 			   in_fifo_7;
   reg [31:0] 			   in_fifo_8;
   reg [31:0] 			   in_fifo_9; 
   reg [31:0] 			   in_fifo_10;
   reg [31:0] 			   in_fifo_11;
   reg [31:0] 			   in_fifo_12;
   reg [31:0] 			   in_fifo_13; 
   reg [31:0] 			   in_fifo_14;
   reg [31:0] 			   in_fifo_15;   
   
   wire 			   fifo_out_full, fifo_out_empty;
   wire [31:0] 			   o_data;
   reg 				   clk;
   wire [31:0] 			   out_fifo_item;

   
   parameter period = 4;   

   FIFO_EMPTY fifo_0(.i_clk(clk),
		     .i_item(in_fifo_0),
		     .i_write(write_fifo_0),
		     .o_item(out_fifo_0),
		     .i_read(o_fifo_0_read),
		     .empty(fifo_0_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_1(.i_clk(clk),
		     .i_item(in_fifo_1),
		     .i_write(write_fifo_1),
		     .o_item(out_fifo_1),
		     .i_read(o_fifo_1_read),
		     .empty(fifo_1_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_2(.i_clk(clk),
		     .i_item(in_fifo_2),
		     .i_write(write_fifo_2),
		     .o_item(out_fifo_2),
		     .i_read(o_fifo_2_read),
		     .empty(fifo_2_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_3(.i_clk(clk),
		     .i_item(in_fifo_3),
		     .i_write(write_fifo_3),
		     .o_item(out_fifo_3),
		     .i_read(o_fifo_3_read),
		     .empty(fifo_3_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_4(.i_clk(clk),
		     .i_item(in_fifo_4),
		     .i_write(write_fifo_4),
		     .o_item(out_fifo_4),
		     .i_read(o_fifo_4_read),
		     .empty(fifo_4_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_5(.i_clk(clk),
		     .i_item(in_fifo_5),
		     .i_write(write_fifo_5),
		     .o_item(out_fifo_5),
		     .i_read(o_fifo_5_read),
		     .empty(fifo_5_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_6(.i_clk(clk),
		     .i_item(in_fifo_6),
		     .i_write(write_fifo_6),
		     .o_item(out_fifo_6),
		     .i_read(o_fifo_6_read),
		     .empty(fifo_6_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_7(.i_clk(clk),
		     .i_item(in_fifo_7),
		     .i_write(write_fifo_7),
		     .o_item(out_fifo_7),
		     .i_read(o_fifo_7_read),
		     .empty(fifo_7_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_8(.i_clk(clk),
		     .i_item(in_fifo_8),
		     .i_write(write_fifo_8),
		     .o_item(out_fifo_8),
		     .i_read(o_fifo_8_read),
		     .empty(fifo_8_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_9(.i_clk(clk),
		     .i_item(in_fifo_9),
		     .i_write(write_fifo_9),
		     .o_item(out_fifo_9),
		     .i_read(o_fifo_9_read),
		     .empty(fifo_9_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_10(.i_clk(clk),
		     .i_item(in_fifo_10),
		     .i_write(write_fifo_10),
		     .o_item(out_fifo_10),
		     .i_read(o_fifo_10_read),
		     .empty(fifo_10_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_11(.i_clk(clk),
		     .i_item(in_fifo_11),
		     .i_write(write_fifo_11),
		     .o_item(out_fifo_11),
		     .i_read(o_fifo_11_read),
		     .empty(fifo_11_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_12(.i_clk(clk),
		     .i_item(in_fifo_12),
		     .i_write(write_fifo_12),
		     .o_item(out_fifo_12),
		     .i_read(o_fifo_12_read),
		     .empty(fifo_12_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_13(.i_clk(clk),
		     .i_item(in_fifo_13),
		     .i_write(write_fifo_13),
		     .o_item(out_fifo_13),
		     .i_read(o_fifo_13_read),
		     .empty(fifo_13_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_14(.i_clk(clk),
		     .i_item(in_fifo_14),
		     .i_write(write_fifo_14),
		     .o_item(out_fifo_14),
		     .i_read(o_fifo_14_read),
		     .empty(fifo_14_empty),
		     .full(),
		     .overrun(),
		     .underrun());

   FIFO_EMPTY fifo_15(.i_clk(clk),
		     .i_item(in_fifo_15),
		     .i_write(write_fifo_15),
		     .o_item(out_fifo_15),
		     .i_read(o_fifo_15_read),
		     .empty(fifo_15_empty),
		     .full(),
		     .overrun(),
		     .underrun());      

   FIFO fifo_out(.i_clk(clk),
		 .i_item(o_data),
		 .i_write(o_out_fifo_write),
		 .o_item(out_fifo_item),
		 .i_read(read_fifo_out),
		 .empty(fifo_out_empty),
		 .full(),
		 .overrun(),
		 .underrun());

   MERGER_TREE_P1_L8 dut (.i_clk(clk)
,			  .i_fifo_0(out_fifo_0),
			  .i_fifo_0_empty(fifo_0_empty),
			  .i_fifo_1(out_fifo_1),
			  .i_fifo_1_empty(fifo_1_empty),
			  .i_fifo_2(out_fifo_2),
			  .i_fifo_2_empty(fifo_2_empty),
			  .i_fifo_3(out_fifo_3),
			  .i_fifo_3_empty(fifo_3_empty),
			  .i_fifo_4(out_fifo_4),
			  .i_fifo_4_empty(fifo_4_empty),
			  .i_fifo_5(out_fifo_5),
			  .i_fifo_5_empty(fifo_5_empty),
			  .i_fifo_6(out_fifo_6),
			  .i_fifo_6_empty(fifo_6_empty),
			  .i_fifo_7(out_fifo_7),
			  .i_fifo_7_empty(fifo_7_empty),
			  .i_fifo_8(out_fifo_8),
			  .i_fifo_8_empty(fifo_8_empty),
			  .i_fifo_9(out_fifo_9),
			  .i_fifo_9_empty(fifo_9_empty),
			  .i_fifo_10(out_fifo_10),
			  .i_fifo_10_empty(fifo_10_empty),
			  .i_fifo_11(out_fifo_11),
			  .i_fifo_11_empty(fifo_11_empty),
			  .i_fifo_12(out_fifo_12),
			  .i_fifo_12_empty(fifo_12_empty),
			  .i_fifo_13(out_fifo_13),
			  .i_fifo_13_empty(fifo_13_empty),
			  .i_fifo_14(out_fifo_14),
			  .i_fifo_14_empty(fifo_14_empty),
			  .i_fifo_15(out_fifo_15),
			  .i_fifo_15_empty(fifo_15_empty),			  			  
			  .i_fifo_out_ready(~fifo_out_full | read_fifo_out),
			  .o_fifo_0_read(o_fifo_0_read),
			  .o_fifo_1_read(o_fifo_1_read),
			  .o_fifo_2_read(o_fifo_2_read),
			  .o_fifo_3_read(o_fifo_3_read),	
			  .o_fifo_4_read(o_fifo_4_read),
			  .o_fifo_5_read(o_fifo_5_read),
			  .o_fifo_6_read(o_fifo_6_read),
			  .o_fifo_7_read(o_fifo_7_read),			  
			  .o_fifo_8_read(o_fifo_8_read),
			  .o_fifo_9_read(o_fifo_9_read),
			  .o_fifo_10_read(o_fifo_10_read),
			  .o_fifo_11_read(o_fifo_11_read),	
			  .o_fifo_12_read(o_fifo_12_read),
			  .o_fifo_13_read(o_fifo_13_read),
			  .o_fifo_14_read(o_fifo_14_read),
			  .o_fifo_15_read(o_fifo_15_read),			  
			  .o_out_fifo_write(o_out_fifo_write),
			  .o_data(o_data));	       
   
   
   initial
     begin
	read_fifo_out <= 1'b1;
	
	clk <= 0;
	write_fifo_0 <= 1'b1;
	write_fifo_1 <= 1'b1;
	write_fifo_2 <= 1'b1;
	write_fifo_3 <= 1'b1;
	write_fifo_4 <= 1'b1;
	write_fifo_5 <= 1'b1;
	write_fifo_6 <= 1'b1;
	write_fifo_7 <= 1'b1;	
	write_fifo_8 <= 1'b1;
	write_fifo_9 <= 1'b1;
	write_fifo_10 <= 1'b1;
	write_fifo_11 <= 1'b1;
	write_fifo_12 <= 1'b1;
	write_fifo_13 <= 1'b1;
	write_fifo_14 <= 1'b1;
	write_fifo_15 <= 1'b1;			
	in_fifo_0 <= 0;
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;
	in_fifo_3 <= 0;
	in_fifo_4 <= 0;
	in_fifo_5 <= 0;
	in_fifo_6 <= 0;
	in_fifo_7 <= 0;
	in_fifo_8 <= 0;
	in_fifo_9 <= 0;
	in_fifo_10 <= 0;
	in_fifo_11 <= 0;
	in_fifo_12 <= 0;
	in_fifo_13 <= 0;
	in_fifo_14 <= 0;
	in_fifo_15 <= 0;		

	#period;	
	in_fifo_0 <= 1;	
	in_fifo_1 <= 3;
	in_fifo_2 <= 2;	
	in_fifo_3 <= 4;
	in_fifo_4 <= 5;	
	in_fifo_5 <= 7;
	in_fifo_6 <= 6;	
	in_fifo_7 <= 8;
	in_fifo_8 <= 9;	
	in_fifo_9 <= 11;
	in_fifo_10 <= 10;	
	in_fifo_11 <= 12;
	in_fifo_12 <= 13;
	in_fifo_13 <= 15;
	in_fifo_14 <= 14;
	in_fifo_15 <= 16;

	#period;
	in_fifo_0 <= 17;
	in_fifo_1 <= 19;
	in_fifo_2 <= 18;
	in_fifo_3 <= 20;
	in_fifo_4 <= 21;
	in_fifo_5 <= 22;
	in_fifo_6 <= 23;
	in_fifo_7 <= 24;
	in_fifo_8 <= 25;
	in_fifo_9 <= 26;
	in_fifo_10 <= 27;
	in_fifo_11 <= 28;
	in_fifo_12 <= 29;
	in_fifo_13 <= 30;
	in_fifo_14 <= 31;
	in_fifo_15 <= 32;	

	#period;
	in_fifo_0 <= 33;
	in_fifo_1 <= 34;
	in_fifo_2 <= 35;
	in_fifo_3 <= 36;
	in_fifo_4 <= 37;
	in_fifo_5 <= 38;
	in_fifo_6 <= 39;
	in_fifo_7 <= 40;
	in_fifo_8 <= 41;
	in_fifo_9 <= 42;
	in_fifo_10 <= 43;
	in_fifo_11 <= 44;
	in_fifo_12 <= 45;
	in_fifo_13 <= 46;
	in_fifo_14 <= 47;
	in_fifo_15 <= 48;		

	#period;
	in_fifo_0 <= 0;
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;
	in_fifo_3 <= 0;
	in_fifo_4 <= 0;
	in_fifo_5 <= 0;
	in_fifo_6 <= 0;
	in_fifo_7 <= 0;
	in_fifo_8 <= 0;
	in_fifo_9 <= 0;
	in_fifo_10 <= 0;
	in_fifo_11 <= 0;
	in_fifo_12 <= 0;
	in_fifo_13 <= 0;
	in_fifo_14 <= 0;
	in_fifo_15 <= 0;
	
	#period;
	#period;	
	#period;
	#period;
	#period;	
	#period;
	#period;
	#period;	
	#period;
	#period;
	#period;	
	#period;	
	write_fifo_0 <= 1'b0;
	write_fifo_1 <= 1'b0;
	write_fifo_2 <= 1'b0;
	write_fifo_3 <= 1'b0;	
	write_fifo_4 <= 1'b0;
	write_fifo_5 <= 1'b0;
	write_fifo_6 <= 1'b0;
	write_fifo_7 <= 1'b0;
	write_fifo_8 <= 1'b0;
	write_fifo_9 <= 1'b0;
	write_fifo_10 <= 1'b0;
	write_fifo_11 <= 1'b0;	
	write_fifo_12 <= 1'b0;
	write_fifo_13 <= 1'b0;
	write_fifo_14 <= 1'b0;
	write_fifo_15 <= 1'b0;
	
     end

   always
     #2 clk = ~clk;
   
   initial
     begin
	$dumpfile("test_merger.vcd");
	$dumpvars(0,merger_tree_tb);
     end
endmodule // merger_tb


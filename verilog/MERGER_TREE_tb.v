`timescale 1 ns/10 ps

module merger_tree_tb;
   reg write_fifo_0, write_fifo_1, write_fifo_2, write_fifo_3;
   reg read_fifo_out;
   wire fifo_0_empty, fifo_1_empty, fifo_2_empty, fifo_3_empty;
   
   wire [31:0] 			   out_fifo_0;
   wire [31:0] 			   out_fifo_1;
   wire [31:0] 			   out_fifo_2;
   wire [31:0] 			   out_fifo_3;
   reg [31:0] 			   in_fifo_0;
   reg [31:0] 			   in_fifo_1; 
   reg [31:0] 			   in_fifo_2;
   reg [31:0] 			   in_fifo_3;   
   wire 			   out_fifo_1_empty;   
   wire 			   fifo_out_full, fifo_out_empty;
   wire 			   o_fifo_1_read, o_fifo_2_read, o_out_fifo_write;
   wire [31:0] 			   o_data;
   reg 			   clk;
   wire [31:0] 		   out_fifo_item;
   
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

   FIFO fifo_out(.i_clk(clk),
		 .i_item(o_data),
		 .i_write(o_out_fifo_write),
		 .o_item(out_fifo_item),
		 .i_read(read_fifo_out),
		 .empty(fifo_out_empty),
		 .full(),
		 .overrun(),
		 .underrun());

   MERGER_TREE_BASIC dut (.i_clk(clk),
			  .i_fifo_0(out_fifo_0),
			  .i_fifo_0_empty(fifo_0_empty),
			  .i_fifo_1(out_fifo_1),
			  .i_fifo_1_empty(fifo_1_empty),
			  .i_fifo_2(out_fifo_2),
			  .i_fifo_2_empty(fifo_2_empty),
			  .i_fifo_3(out_fifo_3),
			  .i_fifo_3_empty(fifo_3_empty),			  
			  .i_fifo_out_ready(~fifo_out_full | read_fifo_out),
			  .o_fifo_0_read(o_fifo_0_read),
			  .o_fifo_1_read(o_fifo_1_read),
			  .o_fifo_2_read(o_fifo_2_read),
			  .o_fifo_3_read(o_fifo_3_read),			  
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
	in_fifo_0 <= 0;
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;
	in_fifo_3 <= 0;

	#period;	
	in_fifo_0 <= 1;	
	in_fifo_1 <= 3;
	in_fifo_2 <= 2;	
	in_fifo_3 <= 4;
	
	#period;
	in_fifo_0 <= 5;	
	in_fifo_1 <= 7;
	in_fifo_2 <= 6;	
	in_fifo_3 <= 8;

	#period;
	in_fifo_0 <= 9;	
	in_fifo_1 <= 11;
	in_fifo_2 <= 10;	
	in_fifo_3 <= 12;
	

	#period;
	in_fifo_0 <= 13;
	in_fifo_1 <= 15;
	in_fifo_2 <= 14;
	in_fifo_3 <= 16;

	#period;
	in_fifo_0 <= 17;
	in_fifo_1 <= 19;
	in_fifo_2 <= 18;
	in_fifo_3 <= 20;

	#period;
	in_fifo_0 <= 0;
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;
	in_fifo_3 <= 0;

	#period;
	in_fifo_0 <= 0;
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;
	in_fifo_3 <= 0;

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
     end

   always
     #2 clk = ~clk;
   
   initial
     begin
	$dumpfile("test_merger.vcd");
	$dumpvars(0,merger_tree_tb);
     end
endmodule // merger_tb


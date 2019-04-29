`timescale 1 ns/10 ps

module merger_tb;
   reg write_fifo_1, write_fifo_2, read_fifo_out;
   wire fifo_1_full, fifo_2_full, fifo_1_overrun, fifo_2_overrun, fifo_1_underrun, fifo_2_underrun, fifo_out_overrun, fifo_out_underrun;
   wire [31:0] 			   out_fifo_1;
   wire [31:0] 			   out_fifo_2;
   reg [31:0] 			   in_fifo_1;
   reg [31:0] 			   in_fifo_2;   
   wire 			   out_fifo_1_empty;   
   wire 			   fifo_2_empty;
   wire 			   fifo_out_full, fifo_out_empty;
   wire 			   o_fifo_1_read, o_fifo_2_read, o_out_fifo_write;
   wire [31:0] 			   o_data;
   reg 			   clk;
   wire [31:0] 		   out_fifo_item;
   
   parameter period = 4;   

   FIFO_EMPTY fifo_1(.i_clk(clk),
	       .i_item(in_fifo_1),
	       .i_write(write_fifo_1),
	       .o_item(out_fifo_1),
	       .i_read(o_fifo_1_read),
	       .empty(fifo_1_empty),
	       .full(fifo_1_full),
	       .overrun(fifo_1_overrun),
	       .underrun(fifo_1_underrun));

   FIFO_EMPTY fifo_2(.i_clk(clk),
	       .i_item(in_fifo_2),
	       .i_write(write_fifo_2),
	       .o_item(out_fifo_2),
	       .i_read(o_fifo_2_read),
	       .empty(fifo_2_empty),
	       .full(fifo_2_full),
	       .overrun(fifo_2_overrun),
	       .underrun(fifo_2_underrun));

   FIFO fifo_out(.i_clk(clk),
	       .i_item(o_data),
	       .i_write(o_out_fifo_write),
	       .o_item(out_fifo_item),
	       .i_read(read_fifo_out),
	       .empty(fifo_out_empty),
	       .full(fifo_out_full),
	       .overrun(fifo_out_overrun),
	       .underrun(fifo_out_underrun));

   MERGER_1 dut (.i_clk(clk),
	       .i_fifo_1(out_fifo_1),
	       .i_fifo_1_empty(fifo_1_empty),
	       .i_fifo_2(out_fifo_2),
	       .i_fifo_2_empty(fifo_2_empty),
	       .i_fifo_out_ready(~fifo_out_full | read_fifo_out),
	       .o_fifo_1_read(o_fifo_1_read),
	       .o_fifo_2_read(o_fifo_2_read),
	       .o_out_fifo_write(o_out_fifo_write),
	       .o_data(o_data));	       
   
   
   initial
     begin
	read_fifo_out <= 1'b1;
	
	clk <= 0;
	write_fifo_1 <= 1'b1;
	write_fifo_2 <= 1'b1;	
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;

	#period;	
	in_fifo_1 <= 1;	
	in_fifo_2 <= 2;
	
	#period;
	in_fifo_1 <= 3;	
	in_fifo_2 <= 4;

	#period;
	in_fifo_1 <= 5;	
	in_fifo_2 <= 6;
	

	#period;
	in_fifo_1 <= 7;
	in_fifo_2 <= 8;

	#period;
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;

	#period;
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;

	#period;
	in_fifo_1 <= 0;
	in_fifo_2 <= 0;	

	#period;	
	write_fifo_1 <= 1'b0;
	write_fifo_2 <= 1'b0;

	
     end

   always
     #2 clk = ~clk;
   
   initial
     begin
	$dumpfile("test_merger.vcd");
	$dumpvars(0,merger_tb);
     end
endmodule // merger_tb


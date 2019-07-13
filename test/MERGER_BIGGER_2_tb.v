 `timescale 1 ns/10 ps

module merger_tb;
   reg write_fifo_1, write_fifo_2, write_fifo_out;
   wire fifo_1_full, fifo_2_full, fifo_1_overrun, fifo_2_overrun, fifo_1_underrun, fifo_2_underrun, fifo_out_overrun, fifo_out_underrun;
   wire [2*32-1:0] 			   out_fifo_1;
   wire [2*32-1:0] 			   out_fifo_2;
   reg [2*32-1:0] 			   in_fifo_1;
   reg [2*32-1:0] 			   in_fifo_2;   
   wire 			   out_fifo_1_empty;   
   wire 			   fifo_2_empty;
   wire 			   fifo_out_full, fifo_out_empty;
   wire 			   o_fifo_1_read, o_fifo_2_read, o_out_fifo_write;
   wire [2*32-1:0] 			   o_data;
   reg 			   clk;
   wire [2*32-1:0] 		   out_fifo_item;
   
   parameter period = 4;   

   FIFO_EMPTY_2 fifo_1(.i_clk(clk),
	       .i_item(in_fifo_1),
	       .i_write(write_fifo_1),
	       .o_item(out_fifo_1),
	       .i_read(o_fifo_1_read),
	       .empty(fifo_1_empty),
	       .full(fifo_1_full),
	       .overrun(fifo_1_overrun),
	       .underrun(fifo_1_underrun));

   FIFO_EMPTY_2 fifo_2(.i_clk(clk), 
	       .i_item(in_fifo_2),
	       .i_write(write_fifo_2),
	       .o_item(out_fifo_2),
	       .i_read(o_fifo_2_read),
	       .empty(fifo_2_empty),
	       .full(fifo_2_full),
	       .overrun(fifo_2_overrun),
	       .underrun(fifo_2_underrun));

   FIFO_2 fifo_out(.i_clk(clk),
	       .i_item(o_data),
	       .i_write(o_out_fifo_write),
	       .o_item(out_fifo_item),
	       .i_read(write_fifo_out),
	       .empty(fifo_out_empty),
	       .full(fifo_out_full),
	       .overrun(fifo_out_overrun),
	       .underrun(fifo_out_underrun));

   MERGER_2 dut (.i_clk(clk),
	       .i_fifo_1(out_fifo_1),
	       .i_fifo_1_empty(fifo_1_empty),
	       .i_fifo_2(out_fifo_2),
	       .i_fifo_2_empty(fifo_2_empty),
	       .i_fifo_out_ready(~fifo_out_full | write_fifo_out),
	       .o_fifo_1_read(o_fifo_1_read),
	       .o_fifo_2_read(o_fifo_2_read),
	       .o_out_fifo_write(o_out_fifo_write),
	       .o_data(o_data));	       
   
   
   initial
     begin
	write_fifo_out <= 1'b1;
	
	clk <= 0;
	in_fifo_1 <= 0;	
	in_fifo_2 <= 0;
	write_fifo_1 <= 1'b1;
	write_fifo_2 <= 1'b1;
	
	#period;
	in_fifo_1[31:0] <= 1;	
	in_fifo_2[31:0] <= 2;
	in_fifo_1[2*32-1:32] <= 7;	
	in_fifo_2[2*32-1:32] <= 3;	

	#period;
	in_fifo_1[31:0] <= 8;
	in_fifo_2[31:0] <= 4;	
	in_fifo_1[2*32-1:32] <= 9;
	in_fifo_2[2*32-1:32] <= 5;

	#period;
	in_fifo_1[31:0] <= 11;
	in_fifo_2[31:0] <= 6;
	in_fifo_1[2*32-1:32] <= 12;
	in_fifo_2[2*32-1:32] <= 10;			

	#period;
	in_fifo_1[31:0] <= 14;
	in_fifo_2[31:0] <= 13;
	in_fifo_1[2*32-1:32] <= 15;
	in_fifo_2[2*32-1:32] <= 17;			

	#period;
	in_fifo_1[31:0] <= 16;
	in_fifo_2[31:0] <= 18;	
	in_fifo_1[2*32-1:32] <= 20;
	in_fifo_2[2*32-1:32] <= 19;

	#period;
	in_fifo_1[31:0] <= 22;
	in_fifo_2[31:0] <= 21;
	in_fifo_1[2*32-1:32] <= 23;
	in_fifo_2[2*32-1:32] <= 24;			

	#period;
	in_fifo_1[31:0] <= 26;
	in_fifo_2[31:0] <= 25;	
	in_fifo_1[2*32-1:32] <= 27;
	in_fifo_2[2*32-1:32] <= 30;	

	#period;
	in_fifo_1[31:0] <= 28;
	in_fifo_2[31:0] <= 31;	
	in_fifo_1[2*32-1:32] <= 29;
	in_fifo_2[2*32-1:32] <= 32;	
	
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
endmodule // control_tb


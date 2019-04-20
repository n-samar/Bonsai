`timescale 1 ns/10 ps

module fifo_tb;
   localparam period = 20;
   localparam DATA_WIDTH = 32;

   reg [(DATA_WIDTH-1):0] i_item;
   wire [(DATA_WIDTH-1):0] o_item;
   reg 			   i_write, i_read;
   reg 			   i_clk;
   wire 		   empty, full, overrun, underrun;
   
   
   FIFO dut (.i_clk(i_clk), .i_item(i_item), .i_write(i_write), .o_item(o_item), .i_read(i_read),
	     .empty(empty), .full(full), .overrun(overrun), .underrun(underrun));
   
   initial
     begin
	i_clk = 0;
	#period;
	
	i_item = 1;
	i_write = 1'b1;
	i_read = 1'b0;
	#period;

	i_write = 1'b1;
	i_read = 1'b1;
	#period;

	i_read = 1'b0;
	if (o_item != 1)
	  $display ("Test failed!");
	else
	  $display ("Test passed!");

	if (empty != 1'b0)
	  $display ("Test failed!");
	else
	  $display ("Test passed!");	  
     end

   always
     #1 i_clk = ~i_clk;
   
   always @(i_read)
     if (i_read == 1'b1)
       $display("At time %t, value = %d", $time, o_item);

   initial
     begin
	$dumpfile("test_fifo.vcd");
	$dumpvars(0,fifo_tb);
     end
   
endmodule

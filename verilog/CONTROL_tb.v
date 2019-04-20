`timescale 1 ns/10 ps

module control_tb;
   reg 			   i_fifo_out_full, i_a_min_zero, i_b_min_zero, i_a_lte_b, i_a_empty, i_b_empty, i_r_a_min_zero, i_r_b_min_zero;
   reg 			   i_clk;
   wire 		   stall, select_A, switch_output;
   parameter period = 4;   
   
   CONTROL dut (.i_clk(i_clk), .i_fifo_out_full(i_fifo_out_full), .i_a_min_zero(i_a_min_zero), 
		.i_b_min_zero(i_b_min_zero), .i_a_lte_b(i_a_lte_b), .i_a_empty(i_a_empty), 
		.i_b_empty(i_b_empty), .i_r_a_min_zero(i_r_a_min_zero), .i_r_b_min_zero(i_r_b_min_zero),
		.select_A(select_A), .stall(stall), .switch_output(switch_output));
   
   initial
     begin
	i_clk = 0;
	#period;
	
	i_fifo_out_full = 1'b0;
	i_a_min_zero = 1'b0;
	i_b_min_zero = 1'b0;
	i_a_lte_b = 1'b0;
	i_a_empty = 1'b0;
	i_b_empty = 1'b1;
	i_r_a_min_zero = 1'b0;
	i_r_b_min_zero = 1'b0;
	#period;
	
	if (select_A !== 1'b1)
	  $display ("Test failed!");
	else
	  $display ("Test passed!");	  
     end

   always
     #2 i_clk = ~i_clk;
   
   initial
     begin
	$dumpfile("test_ctrl.vcd");
	$dumpvars(0,control_tb);
     end
endmodule // control_tb


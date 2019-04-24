module MERGER_2 (input i_clk,
	      input [2*32-1:0] 	     i_fifo_1,
	      input 		     i_fifo_1_empty,
	      input [2*32-1:0] 	     i_fifo_2,
	      input 		     i_fifo_2_empty,
	      input 		     i_fifo_out_ready,
	      output 		     o_fifo_1_read,
	      output 		     o_fifo_2_read,
	      output 		     o_out_fifo_write,
	      output wire [2*32-1:0] o_data);

   wire 			     i_write_a, i_write_b;
   wire 			     i_c_read;
   wire 			     select_A;
   wire 			     stall;
   reg [2*32-1:0] 		     R_A;
   reg [2*32-1:0] 		     R_B;
   wire 			     fifo_a_empty, fifo_b_empty, fifo_c_empty, fifo_a_full, fifo_b_full, fifo_c_full;
   wire 			     overrun_a, overrun_b, overrun_c, underrun_a, underrun_b, underrun_c;
   reg 				     i_c_write; 			 
   reg [2*32-1:0] 		     i_fifo_c;
   wire [2*32-1:0] 		     fifo_a_out;
   wire [2*32-1:0] 		     fifo_b_out;
   wire 			     a_min_zero, b_min_zero, a_lte_b;
   wire 			     r_a_min_zero, r_b_min_zero;
   wire 			     switch_output;
   reg [2*32-1:0] 		     i_data_2_top;
   wire [2*32-1:0] 		     o_data_2_top;   
   wire [2*32-1:0] 		     data_2_bottom;   
   wire [2*32-1:0] 		     data_3_bigger;
   wire [2*32-1:0] 		     data_3_smaller;   
   wire 			     switch_output_2;
   wire 			     switch_output_3;
   wire 			     stall_2;
   wire 			     stall_3;

   parameter period = 4;
   
   assign a_min_zero = (fifo_a_out[31:0] == 0);
   assign b_min_zero = (fifo_b_out[31:0] == 0);
   assign a_lte_b = (fifo_a_out[31:0] <= fifo_b_out[31:0]);
   assign r_a_min_zero = (R_A[31:0] == 0);
   assign r_b_min_zero = (R_B[31:0] == 0);
   
   assign o_fifo_1_read = ~i_fifo_1_empty & (~fifo_a_full | (select_A & ~stall));
   assign i_write_a = ~i_fifo_1_empty & (~fifo_a_full | (select_A & ~stall));
   assign i_write_b = ~i_fifo_2_empty & (~fifo_b_full | (~select_A & ~stall));
   assign o_fifo_2_read = ~i_fifo_2_empty & (~fifo_b_full | (~select_A & ~stall));
   assign o_out_fifo_write = i_fifo_out_ready & ~fifo_c_empty;
   assign i_c_read = i_fifo_out_ready & ~fifo_c_empty;

   
   FIFO_2 fifo_a(.i_clk(i_clk), 
	       .i_item(i_fifo_1), 
	       .i_write(i_write_a), 
	       .i_read(select_A & ~stall),
	       .o_item(fifo_a_out), 
	       .empty(fifo_a_empty), 
	       .full(fifo_a_full), 
	       .overrun(overrun_a), 
	       .underrun(underrun_a));

   FIFO_2 fifo_b(.i_clk(i_clk), 
	       .i_item(i_fifo_2), 
	       .i_write(i_write_b), 
	       .i_read(~select_A & ~stall),
	       .o_item(fifo_b_out), 
	       .empty(fifo_b_empty), 
	       .full(fifo_b_full), 
	       .overrun(overrun_b), 
	       .underrun(underrun_b));     

   FIFO_2 fifo_c(.i_clk(i_clk), 
	       .i_item(i_fifo_c), 
	       .i_write(i_c_write), 
	       .i_read(i_c_read),
	       .o_item(o_data), 
	       .empty(fifo_c_empty), 
	       .full(fifo_c_full), 
	       .overrun(overrun_b), 
	       .underrun(underrun_b));

   CONTROL ctrl(.i_clk(i_clk), 
		.i_fifo_out_full(!i_fifo_out_ready), 
		.i_a_min_zero(a_min_zero), 
		.i_b_min_zero(b_min_zero),
		.i_a_lte_b(a_lte_b), 
		.i_a_empty(fifo_a_empty), 
		.i_b_empty(fifo_b_empty), 
		.i_r_a_min_zero(r_a_min_zero), 
		.i_r_b_min_zero(r_b_min_zero), 
		.select_A(select_A), 
		.stall(stall), 
		.switch_output(switch_output));

   BITONIC_NETWORK_4 first_merger (.i_clk(i_clk),
				   .switch_output(switch_output),
				   .stall(stall),
				   .top_tuple(i_data_2_top),
				   .i_elems_0(R_A),
				   .i_elems_1(R_B),
				   .o_elems_0(),
				   .o_elems_1(data_2_bottom),
				   .o_switch_output(switch_output_2),
				   .o_stall(stall_2),
				   .o_top_tuple(o_data_2_top));

   BITONIC_NETWORK_4 second_merger (.i_clk(i_clk),
				    .switch_output(switch_output_2),
				    .stall(stall),
				    .top_tuple(),
				    .i_elems_0(o_data_2_top),
				    .i_elems_1(data_2_bottom),
				    .o_elems_0(data_3_smaller),
				    .o_elems_1(data_3_bigger),
				    .o_switch_output(switch_output_3),
				    .o_stall(stall_3),
				    .o_top_tuple());

   initial begin
      R_A <= 0;
      R_B <= 0;
      i_data_2_top <= 0;
   end
   
   /* We must wait for the control logic to finish and fifos FIFO_A and FIFO_B to update */	   
   always @(posedge i_clk)
     begin
	if (~stall) begin
	   if (select_A) begin
	      i_data_2_top <= fifo_a_out;
	      R_A <= fifo_a_out;	      
	   end
	   else begin
	      i_data_2_top <= fifo_b_out;
	      R_B <= fifo_b_out;	      
	   end
	end // if (~stall)
	
     end // always @ (posedge i_clk)

   /* Advance the pipelined data stage LAST */
   always @(posedge i_clk)
     begin	
	if (~stall_3) begin
	   if (~switch_output_3) begin
	      i_fifo_c <= data_3_smaller;
	   end
	   else
	     i_fifo_c <= data_3_bigger;
	   i_c_write <= 1'b1;	
	end // if (~stall_3)
	else
	  i_c_write <= 1'b0;
     end
   endmodule // MERGER_2



	      

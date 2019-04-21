`timescale 1 ns/10 ps

/* NOTE: The size of FIFO_C should be at least log(P)*(log(P)+1)/2 + 1 */
module MERGER(input i_clk,
	      input [31:0] 	 i_fifo_1,
	      input 		 i_fifo_1_empty,
	      input [31:0] 	 i_fifo_2,
	      input 		 i_fifo_2_empty,
	      input 		 i_fifo_out_ready,
	      output reg 	 o_fifo_1_read,
	      output reg 	 o_fifo_2_read,
	      output reg 	 o_out_fifo_write,
	      output wire [31:0] o_data);

   reg 				 i_write_a, i_write_b;
   reg 				 i_write_c;
   wire 			 select_A;
   wire 			 stall;
   reg [31:0] 			 R_A;
   reg [31:0] 			 R_B;
   wire 			 fifo_a_empty, fifo_b_empty, fifo_c_empty, fifo_a_full, fifo_b_full, fifo_c_full;
   wire 			 overrun_a, overrun_b, overrun_c, underrun_a, underrun_b, underrun_c;
   reg 				 i_read_c; 			 
   reg [31:0] 			 i_fifo_c;
   wire [31:0] 			 fifo_a_out;
   wire [31:0] 			 fifo_b_out;
   wire 			 a_min_zero, b_min_zero, a_lte_b;
   wire 			 r_a_min_zero, r_b_min_zero;
   wire 			 switch_output;
   reg [31:0] 			 data_2_top;
   reg [31:0] 			 data_2_bottom;   
   reg [31:0] 			 data_3_bigger;
   reg [31:0] 			 data_3_smaller;   
   reg 				 switch_output_2;
   reg 				 switch_output_3;
   reg 				 stall_2;
   reg 				 stall_3;

   parameter period = 4;
   
   assign a_min_zero = (fifo_a_out == 0);
   assign b_min_zero = (fifo_b_out == 0);
   assign a_lte_b = (fifo_a_out <= fifo_b_out);
   assign r_a_min_zero = (R_A == 0);
   assign r_b_min_zero = (R_B == 0);
   
   
   FIFO fifo_a(.i_clk(i_clk), 
	       .i_item(i_fifo_1), 
	       .i_write(i_write_a), 
	       .i_read(select_A & ~stall),
	       .o_item(fifo_a_out), 
	       .empty(fifo_a_empty), 
	       .full(fifo_a_full), 
	       .overrun(overrun_a), 
	       .underrun(underrun_a));

   FIFO fifo_b(.i_clk(i_clk), 
	       .i_item(i_fifo_2), 
	       .i_write(i_write_b), 
	       .i_read(~select_A & ~stall),
	       .o_item(fifo_b_out), 
	       .empty(fifo_b_empty), 
	       .full(fifo_b_full), 
	       .overrun(overrun_b), 
	       .underrun(underrun_b));     

   FIFO fifo_c(.i_clk(i_clk), 
	       .i_item(i_fifo_c), 
	       .i_write(i_read_c), 
	       .i_read(i_write_c),
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

   initial begin
      R_A <= 0;
      R_B <= 0;
      data_2_top <= 0;
      data_2_bottom <= 0;
      data_3_bigger <= 0;
      data_3_smaller <= 0;
      switch_output_2 <= 0;
      switch_output_3 <= 0;      
      stall_2 <= 1;
      stall_3 <= 1;
   end
   
   /* Advance the pipelined data stage 1->2 */
   always @(posedge i_clk)
     begin
	stall_2 <= stall;	
	if (~stall) begin
	   if (select_A) begin
	     data_2_top <= fifo_a_out;
	      #1 R_A <= fifo_a_out;	      
	     end
	   else begin
	      data_2_top <= fifo_b_out;
	      #1 R_B <= fifo_b_out;	      
	   end
	   switch_output_2 <= switch_output;
	   if (R_A <= R_B)
	     data_2_bottom <= R_A;
	   else
	     data_2_bottom <= R_B;
	end // if (~stall)
     end // always @ (posedge i_clk)

   /* Advance the pipelined data stage 2->3 */
   always @(posedge i_clk)
     begin
	stall_3 <= stall_2;	
	if (~stall_2) begin
	   if (data_2_top <= data_2_bottom) begin
	      data_3_bigger <= data_2_bottom;   
	      data_3_smaller <= data_2_top;
	   end
	   else begin
	      data_3_bigger <= data_2_top;   
	      data_3_smaller <= data_2_bottom;
	   end
	   switch_output_3 <= switch_output_2;
	end // if (~stall_2)
     end // always @ (posedge i_clk)

   /* Advance the pipelined data stage 3->4 */
   always @(posedge i_clk)
     begin	
	if (~stall_3) begin
	   if (switch_output_3) begin
	      i_fifo_c <= data_3_smaller;
	   end
	   else
	     i_fifo_c <= data_3_bigger;
	   #1 i_read_c <= 1'b1;	   
	   if (~fifo_c_full | i_read_c)
	     i_write_c <= 1'b1;
	   else
	     $display("ERROR!");
	end // if (~stall_3)
     end

   /* Writting into FIFO_A if possible */
   always @(posedge i_clk)
     begin
	if (~i_fifo_1_empty & (~fifo_a_full | (select_A & ~stall))) begin	  
	   i_write_a <= 1'b1;
	   o_fifo_1_read <= 1'b1;	   
	end
	else begin
	   i_write_a <= 1'b0;
	   o_fifo_1_read <= 1'b0;
	end
     end

   /* Writting into FIFO_B if possible */
   always @(posedge i_clk)
     begin
	if (~i_fifo_2_empty & (~fifo_b_full | (~select_A & ~stall))) begin
	   i_write_b <= 1'b1;
	   o_fifo_2_read <= 1'b1;
	end
	else begin
	   i_write_b <= 1'b0;
	   o_fifo_2_read <= 1'b0;
	end
     end


   /* Writting into out_fifo if possible */
   always @(posedge i_clk)
     begin
	if (i_fifo_out_ready & ~fifo_c_empty) begin
	   o_out_fifo_write <= 1'b1;
	   i_write_c <= 1'b1;	   
	end
	else begin
	  o_out_fifo_write <= 1'b0;
	   i_write_c <= 1'b0;
	end
     end
endmodule // MERGER


	      

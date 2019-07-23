module MERGER_4 #(parameter DATA_WIDTH = 128,
		  parameter KEY_WIDTH = 80) (input i_clk,
					     input [4*DATA_WIDTH-1:0] 	    i_fifo_1,
					     input 			    i_fifo_1_empty,
					     input [4*DATA_WIDTH-1:0] 	    i_fifo_2,
					     input 			    i_fifo_2_empty,
					     input 			    i_fifo_out_ready,
					     output 			    o_fifo_1_read,
					     output 			    o_fifo_2_read,
					     output 			    o_out_fifo_write,
					     output wire [4*DATA_WIDTH-1:0] o_data);

   wire 								    i_write_a, i_write_b;
   wire 								    i_c_read;
   wire 								    select_A;
   wire 								    stall;
   reg [4*DATA_WIDTH-1:0] 						    R_A;
   reg [4*DATA_WIDTH-1:0] 						    R_B;
   wire 								    fifo_a_empty, fifo_b_empty, fifo_c_empty, fifo_a_full, fifo_b_full, fifo_c_available;
   wire 								    overrun_a, overrun_b, overrun_c, underrun_a, underrun_b, underrun_c;
   reg 									    i_c_write; 			 
   reg [4*DATA_WIDTH-1:0] 						    i_fifo_c;
   wire [4*DATA_WIDTH-1:0] 						    fifo_a_out;
   wire [4*DATA_WIDTH-1:0] 						    fifo_b_out;
   wire 								    a_min_zero, b_min_zero, a_lte_b;
   wire 								    switch_output;
   reg [4*DATA_WIDTH-1:0] 						    i_data_2_top;
   wire [4*DATA_WIDTH-1:0] 						    o_data_2_top;   
   wire [4*DATA_WIDTH-1:0] 						    data_2_bottom;   
   wire [4*DATA_WIDTH-1:0] 						    data_3_bigger;
   wire [4*DATA_WIDTH-1:0] 						    data_3_smaller;   
   wire 								    switch_output_2;
   wire 								    switch_output_3;
   wire 								    stall_2;
   wire 								    stall_3;
   reg 									    i_fifo_out_ready_clocked;

   always @(posedge i_clk) begin
      i_fifo_out_ready_clocked <= i_fifo_out_ready;
   end
   
   parameter period = 4;

   assign a_min_zero = (fifo_a_out[DATA_WIDTH-1:0] == 0);
   assign b_min_zero = (fifo_b_out[DATA_WIDTH-1:0] == 0);
   assign a_lte_b = (fifo_a_out[KEY_WIDTH-1:0] <= fifo_b_out[KEY_WIDTH-1:0]);

   assign o_fifo_1_read = ~i_fifo_1_empty & (~fifo_a_full);
   assign i_write_a = ~i_fifo_1_empty & (~fifo_a_full);
   assign i_write_b = ~i_fifo_2_empty & (~fifo_b_full);
   assign o_fifo_2_read = ~i_fifo_2_empty & (~fifo_b_full);
   assign o_out_fifo_write = i_fifo_out_ready_clocked & ~fifo_c_empty;
   assign i_c_read = i_fifo_out_ready_clocked & ~fifo_c_empty;   

   initial begin
      i_fifo_out_ready_clocked <= 0; 
   end

   
   IFIFO16 #(4*DATA_WIDTH) fifo_a(.i_clk(i_clk), 
				  .i_data(i_fifo_1), 
				  .o_data(fifo_a_out),
				  .i_enq(i_write_a), 		  
				  .i_deq(select_A & ~stall), 
				  .o_empty(fifo_a_empty), 
				  .o_full(fifo_a_full));

   IFIFO16 #(4*DATA_WIDTH) fifo_b(.i_clk(i_clk), 
				  .i_data(i_fifo_2), 
				  .o_data(fifo_b_out),
				  .i_enq(i_write_b), 
				  .i_deq(~select_A & ~stall), 
				  .o_empty(fifo_b_empty), 
				  .o_full(fifo_b_full));     

   IFIFO32 #(4*DATA_WIDTH) fifo_c(.i_clk(i_clk), 
				  .i_data(i_fifo_c), 
				  .o_data(o_data),
				  .i_enq(i_c_write), 
				  .i_deq(i_c_read),		  
				  .o_empty(fifo_c_empty),
				  .o_available(fifo_c_available),
				  .o_full());

   CONTROL ctrl(.i_clk(i_clk), 
		.i_fifo_out_full(!i_fifo_out_ready_clocked), 
		.i_a_min_zero(a_min_zero), 
		.i_b_min_zero(b_min_zero),
		.i_a_lte_b(a_lte_b), 
		.i_a_empty(fifo_a_empty), 
		.i_b_empty(fifo_b_empty), 
		.select_A(select_A), 
		.stall(stall), 
		.switch_output(switch_output));

   BITONIC_NETWORK_8 #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH)) first_merger (.i_clk(i_clk),
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

   BITONIC_NETWORK_8 #(.DATA_WIDTH(DATA_WIDTH), .KEY_WIDTH(KEY_WIDTH))  second_merger (.i_clk(i_clk),
										       .switch_output(switch_output_2),
										       .stall(stall_2),
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
      i_fifo_c <= 0;
      i_c_write <= 0;
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
        i_c_write <= ~stall_3;	           
	if (~stall_3) begin
	   if (~switch_output_3) begin
	      i_fifo_c <= data_3_smaller;
	   end
	   else
	     i_fifo_c <= data_3_bigger;
	end // if (~stall_3)
     end
endmodule // MERGER_4

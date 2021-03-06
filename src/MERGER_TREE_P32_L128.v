`timescale 1 ns/10 ps


module MERGER_TREE_P32_L128 #(parameter L = 128) (input i_clk,
					   input [32*2*L-1:0] 	  i_fifo,
					   input [2*L-1:0] 	  i_fifo_empty,
					   input 		  i_fifo_out_ready,
					   output [2*L-1:0] 	  o_fifo_read, 
					   output 		  o_out_fifo_write,
					   output wire [1024-1:0] o_data);

   // MERGER_1
   wire [31:0] 						      fifo_o_item_7 [127:0];
   wire [31:0] 						      fifo_i_item_7 [127:0];   
   wire [127:0] 					      fifo_read_7;
   wire [127:0] 					      fifo_write_7;
   wire [127:0] 					      fifo_empty_7;
   wire [127:0] 					      fifo_full_7;

   // MERGER_1
   wire [31:0] 						      fifo_o_item_6 [63:0];
   wire [31:0] 						      fifo_i_item_6 [63:0];   
   wire [63:0] 						      fifo_read_6;
   wire [63:0] 						      fifo_write_6;
   wire [63:0] 						      fifo_empty_6;
   wire [63:0] 						      fifo_full_6;

   // MERGER_2
   wire [64-1:0] 					      fifo_o_item_5 [31:0];
   wire [31:0] 						      fifo_i_item_5 [31:0];   
   wire [31:0] 						      fifo_read_5;
   wire [31:0] 						      fifo_write_5;
   wire [31:0] 						      fifo_empty_5;
   wire [31:0] 						      fifo_full_5;

   // MERGER_4
   wire [128-1:0] 					      fifo_o_item_4 [15:0];
   wire [64-1:0] 					      fifo_i_item_4 [15:0];   
   wire [15:0] 						      fifo_read_4;
   wire [15:0] 						      fifo_write_4;
   wire [15:0] 						      fifo_empty_4;
   wire [15:0] 						      fifo_full_4;

   // MERGER_8
   wire [256-1:0] 					      fifo_o_item_3 [7:0];
   wire [128-1:0] 					      fifo_i_item_3 [7:0];   
   wire [7:0] 						      fifo_read_3;
   wire [7:0] 						      fifo_write_3;
   wire [7:0] 						      fifo_empty_3;
   wire [7:0] 						      fifo_full_3;      

   // MERGER_16
   wire [512-1:0] 					      fifo_o_item_2 [3:0];
   wire [256-1:0] 					      fifo_i_item_2 [3:0];   
   wire [3:0] 						      fifo_read_2;
   wire [3:0] 						      fifo_write_2;
   wire [3:0] 						      fifo_empty_2;
   wire [3:0] 						      fifo_full_2;

   // MERGER_32
   wire [1024-1:0] 					      fifo_o_item_1 [1:0];
   wire [512-1:0] 					      fifo_i_item_1 [1:0];   
   wire [1:0] 						      fifo_read_1;
   wire [1:0] 						      fifo_write_1;
   wire [1:0] 						      fifo_empty_1;
   wire [1:0] 						      fifo_full_1;

   
   genvar						      level, i;   
   generate
      for (level = L; level > 1; level = level/2) begin : GEN
	 for (i = 0; i < level; i=i+1) begin : GENN
	    if (level == 128) begin
	       MERGER_1 merger(.i_clk(i_clk),
			     .i_fifo_1(i_fifo[32*2*i+31:32*2*i]),
			     .i_fifo_1_empty(i_fifo_empty[2*i]),
			     .i_fifo_2(i_fifo[32*2*i+32+31:32*2*i+32]),
			     .i_fifo_2_empty(i_fifo_empty[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_7[i] | fifo_read_7[i]),
			     .o_fifo_1_read(o_fifo_read[2*i]),
			     .o_fifo_2_read(o_fifo_read[2*i+1]),
			     .o_out_fifo_write(fifo_write_7[i]),
			     .o_data(fifo_i_item_7[i]));
	       IFIFO16 fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item_7[i]),
			    .i_enq(fifo_write_7[i]),
			    .i_deq(fifo_read_7[i]),
			    .o_data(fifo_o_item_7[i]),
			    .o_empty(fifo_empty_7[i]),
			    .o_full(fifo_full_7[i]));	       
	    end 
	    else if (level == 64) begin
	       MERGER_1 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item_7[2*i]),
			     .i_fifo_1_empty(fifo_empty_7[2*i]),
			     .i_fifo_2(fifo_o_item_7[2*i+1]),
			     .i_fifo_2_empty(fifo_empty_7[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_6[i] | fifo_read_6[i]),
			     .o_fifo_1_read(fifo_read_7[2*i]),
			     .o_fifo_2_read(fifo_read_7[2*i+1]),
			     .o_out_fifo_write(fifo_write_6[i]),
			     .o_data(fifo_i_item_6[i]));
	       IFIFO16 fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item_6[i]),
			    .i_enq(fifo_write_6[i]),
			    .i_deq(fifo_read_6[i]),
			    .o_data(fifo_o_item_6[i]),
			    .o_empty(fifo_empty_6[i]),
			    .o_full(fifo_full_6[i]));	       
	    end	            
	    else if (level == 32) begin
	       MERGER_1 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item_6[2*i]),
			     .i_fifo_1_empty(fifo_empty_6[2*i]),
			     .i_fifo_2(fifo_o_item_6[2*i+1]),
			     .i_fifo_2_empty(fifo_empty_6[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_5[i] | fifo_read_5[i]),
			     .o_fifo_1_read(fifo_read_6[2*i]),
			     .o_fifo_2_read(fifo_read_6[2*i+1]),
			     .o_out_fifo_write(fifo_write_5[i]),
			     .o_data(fifo_i_item_5[i]));
	       COUPLER #(32) fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item_5[i]),
			    .i_enq(fifo_write_5[i]),
			    .i_deq(fifo_read_5[i]),
			    .o_data(fifo_o_item_5[i]),
			    .o_empty(fifo_empty_5[i]),
			    .o_full(fifo_full_5[i]));	       
	    end	    
	    else if (level == 16) begin
	       MERGER_2 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item_5[2*i]),
			     .i_fifo_1_empty(fifo_empty_5[2*i]),
			     .i_fifo_2(fifo_o_item_5[2*i+1]),
			     .i_fifo_2_empty(fifo_empty_5[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_4[i] | fifo_read_4[i]),
			     .o_fifo_1_read(fifo_read_5[2*i]),
			     .o_fifo_2_read(fifo_read_5[2*i+1]),
			     .o_out_fifo_write(fifo_write_4[i]),
			     .o_data(fifo_i_item_4[i]));
	       COUPLER #(64) fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item_4[i]),
			    .i_enq(fifo_write_4[i]),
			    .i_deq(fifo_read_4[i]),
			    .o_data(fifo_o_item_4[i]),
			    .o_empty(fifo_empty_4[i]),
			    .o_full(fifo_full_4[i]));	       
	    end	    
	    else if (level == 8) begin
	       MERGER_4 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item_4[2*i]),
			     .i_fifo_1_empty(fifo_empty_4[2*i]),
			     .i_fifo_2(fifo_o_item_4[2*i+1]),
			     .i_fifo_2_empty(fifo_empty_4[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_3[i] | fifo_read_3[i]),
			     .o_fifo_1_read(fifo_read_4[2*i]),
			     .o_fifo_2_read(fifo_read_4[2*i+1]),
			     .o_out_fifo_write(fifo_write_3[i]),
			     .o_data(fifo_i_item_3[i]));
	       COUPLER #(128) fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item_3[i]),
			    .i_enq(fifo_write_3[i]),
			    .i_deq(fifo_read_3[i]),
			    .o_data(fifo_o_item_3[i]),
			    .o_empty(fifo_empty_3[i]),
			    .o_full(fifo_full_3[i]));	       
	    end
	    else if (level == 4) begin
	       MERGER_8 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item_3[2*i]),
			     .i_fifo_1_empty(fifo_empty_3[2*i]),
			     .i_fifo_2(fifo_o_item_3[2*i+1]),
			     .i_fifo_2_empty(fifo_empty_3[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_2[i] | fifo_read_2[i]),
			     .o_fifo_1_read(fifo_read_3[2*i]),
			     .o_fifo_2_read(fifo_read_3[2*i+1]),
			     .o_out_fifo_write(fifo_write_2[i]),
			     .o_data(fifo_i_item_2[i]));
	       COUPLER #(256) fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item_2[i]),
			    .i_enq(fifo_write_2[i]),
			    .i_deq(fifo_read_2[i]),
			    .o_data(fifo_o_item_2[i]),
			    .o_empty(fifo_empty_2[i]),
			    .o_full(fifo_full_2[i]));
	    end
	    else if (level == 2) begin
	       MERGER_16 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item_2[2*i]),
			     .i_fifo_1_empty(fifo_empty_2[2*i]),
			     .i_fifo_2(fifo_o_item_2[2*i+1]),
			     .i_fifo_2_empty(fifo_empty_2[2*i+1]),
			     .i_fifo_out_ready(~fifo_full_1[i] | fifo_read_1[i]),
			     .o_fifo_1_read(fifo_read_2[2*i]),
			     .o_fifo_2_read(fifo_read_2[2*i+1]),
			     .o_out_fifo_write(fifo_write_1[i]),
			     .o_data(fifo_i_item_1[i]));
	       COUPLER #(512) fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item_1[i]),
			    .i_enq(fifo_write_1[i]),
			    .i_deq(fifo_read_1[i]),
			    .o_data(fifo_o_item_1[i]),
			    .o_empty(fifo_empty_1[i]),
			    .o_full(fifo_full_1[i]));
	    end
	 end
      end
    endgenerate
   
   MERGER_32 merger(.i_clk(i_clk),
		 .i_fifo_1(fifo_o_item_1[0]),
		 .i_fifo_1_empty(fifo_empty_1[0]),
		 .i_fifo_2(fifo_o_item_1[1]),
		 .i_fifo_2_empty(fifo_empty_1[1]),
		 .i_fifo_out_ready(i_fifo_out_ready),
		 .o_fifo_1_read(fifo_read_1[0]),
		 .o_fifo_2_read(fifo_read_1[1]),
		 .o_out_fifo_write(o_out_fifo_write),
		 .o_data(o_data)
		 );	       
   
endmodule
			 
		       
/*
 	       MERGER_1 merger(.i_clk(i_clk),
			     .i_fifo_1(fifo_o_item[depth+1][32*2*i+31:32*2*i]),
			     .i_fifo_1_empty(fifo_empty[depth+1][2*i]),
			     .i_fifo_2(fifo_o_item[depth+1][32*2*i+32+31:32*2*i+32]),
			     .i_fifo_2_empty(fifo_empty[depth+1][2*i+1]),
			     .i_fifo_out_ready(~fifo_full[depth][i] | fifo_read[depth][i]),
			     .o_fifo_1_read(fifo_read[depth+1][2*i]),
			     .o_fifo_2_read(fifo_read[depth+1][2*i+1]),
			     .o_out_fifo_write(fifo_write[depth][i]),
			     .o_data(fifo_i_item[depth][i])
			     );	 
	       IFIFO16 fifo(.i_clk(i_clk),
			    .i_data(fifo_i_item[depth][i]),
			    .i_enq(fifo_write[depth][i]),
			    .i_deq(fifo_read[depth][i]),
			    .o_data(fifo_o_item[depth][i]),
			    .o_empty(fifo_empty[depth][i]),
			    .o_full(fifo_full[depth][i]));
 
 */

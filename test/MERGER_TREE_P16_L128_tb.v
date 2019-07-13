`timescale 1 ns/10 ps

module merger_tree_tb;
   reg [2*L-1:0] write_fifo;
   wire read_fifo_out;
   
   wire [31:0] out_fifo [0:2*L-1];
   wire [2*L-1:0] fifo_full;
   reg [31:0] in_fifo [0:2*L-1];
   wire        fifo_out_full, fifo_out_empty;
   wire [16*32-1:0] o_data;
   reg 	       clk;
   wire [16*32-1:0] out_fifo_item;
   wire [2*L-1:0] fifo_empty;
   wire [2*L-1:0] fifo_read;

   parameter L = 128;      
   parameter period = 4;   
   parameter LEAF_CNT = 2*L;
   parameter DATA_WIDTH = 32;
   parameter LEN_SEQ = 16;
   

   reg [31:0] 		   counter = 0;
   reg [31:0] 		   rdaddr [0:LEAF_CNT-1];
   integer 		   i;
   integer 		   j;
   integer 		   k;   
   reg [DATA_WIDTH-1:0] data [0:LEN_SEQ*LEAF_CNT];
   integer 		f;
   reg [31:0] 		countdown [0:LEAF_CNT-1];   

   assign read_fifo_out = ~fifo_out_empty;
   
   genvar fifo_index;
   generate
      for (fifo_index = 0; fifo_index < 2*L; fifo_index = fifo_index + 1) begin : IN
	     FIFO_EMPTY fifo(.i_clk(clk),
			             .i_item(in_fifo[fifo_index] ),
			             .i_write(write_fifo[fifo_index]),
			             .o_item(out_fifo[fifo_index]),
			             .i_read(fifo_read[fifo_index]),
			             .empty(fifo_empty[fifo_index]),
			             .full(fifo_full[fifo_index]),
			             .overrun(),
			             .underrun());	 
      end // block: IN
   endgenerate

   IFIFO16 #(512) fifo_out(.i_clk(clk),
		 .i_data(o_data),
		 .i_enq(o_out_fifo_write),
		 .o_data(out_fifo_item),
		 .i_deq(read_fifo_out),
		 .o_empty(fifo_out_empty),
		 .o_full(fifo_out_full));

   MERGER_TREE_P16_L128 dut (.i_clk(clk),
				.i_fifo({out_fifo[127+128], out_fifo[126+128], out_fifo[125+128], out_fifo[124+128], out_fifo[123+128], 
					 out_fifo[122+128], out_fifo[121+128], out_fifo[120+128], out_fifo[119+128], 
					 out_fifo[118+128], out_fifo[117+128], out_fifo[116+128], out_fifo[115+128], 
					 out_fifo[114+128], out_fifo[113+128], out_fifo[112+128], out_fifo[111+128],
					 out_fifo[110+128], out_fifo[109+128], out_fifo[108+128], out_fifo[107+128], 
					 out_fifo[106+128], out_fifo[105+128], out_fifo[104+128], 
					 out_fifo[103+128], out_fifo[102+128], out_fifo[101+128], out_fifo[100+128], 
					 out_fifo[99+128], out_fifo[98+128], out_fifo[97+128], out_fifo[96+128], 
					 out_fifo[95+128], out_fifo[94+128], out_fifo[93+128], out_fifo[92+128], 
					 out_fifo[91+128], out_fifo[90+128], out_fifo[89+128], out_fifo[88+128], 
					 out_fifo[87+128], out_fifo[86+128], out_fifo[85+128], out_fifo[84+128], 
					 out_fifo[83+128], out_fifo[82+128], out_fifo[81+128], out_fifo[80+128],
					 out_fifo[79+128], out_fifo[78+128], out_fifo[77+128], out_fifo[76+128], 
					 out_fifo[75+128], out_fifo[74+128], out_fifo[73+128], out_fifo[72+128], 
					 out_fifo[71+128], out_fifo[70+128], out_fifo[69+128], out_fifo[68+128], 
					 out_fifo[67+128], out_fifo[66+128], out_fifo[65+128], out_fifo[64+128],
					 out_fifo[63+128], out_fifo[62+128], out_fifo[61+128], out_fifo[60+128], out_fifo[59+128], 
					 out_fifo[58+128], out_fifo[57+128], out_fifo[56+128], out_fifo[55+128], 
					 out_fifo[54+128], out_fifo[53+128], out_fifo[52+128], out_fifo[51+128], 
					 out_fifo[50+128], out_fifo[49+128], out_fifo[48+128], out_fifo[47+128],
					 out_fifo[46+128], out_fifo[45+128], out_fifo[44+128], out_fifo[43+128], 
					 out_fifo[42+128], out_fifo[41+128], out_fifo[40+128], 
					 out_fifo[39+128], out_fifo[38+128], out_fifo[37+128], out_fifo[36+128], 
					 out_fifo[35+128], out_fifo[34+128], out_fifo[33+128], out_fifo[32+128], 
					 out_fifo[31+128], out_fifo[30+128], out_fifo[29+128], out_fifo[28+128], 
					 out_fifo[27+128], out_fifo[26+128], out_fifo[25+128], out_fifo[24+128], 
					 out_fifo[23+128], out_fifo[22+128], out_fifo[21+128], out_fifo[20+128], 
					 out_fifo[19+128], out_fifo[18+128], out_fifo[17+128], out_fifo[16+128],
					 out_fifo[15+128], out_fifo[14+128], out_fifo[13+128], out_fifo[12+128], 
					 out_fifo[11+128], out_fifo[10+128], out_fifo[9+128], out_fifo[8+128], 
					 out_fifo[7+128], out_fifo[6+128], out_fifo[5+128], out_fifo[4+128], 
					 out_fifo[3+128], out_fifo[2+128], out_fifo[1+128], out_fifo[0+128],
                         out_fifo[127], out_fifo[126], out_fifo[125], out_fifo[124], out_fifo[123], 
					 out_fifo[122], out_fifo[121], out_fifo[120], out_fifo[119], 
					 out_fifo[118], out_fifo[117], out_fifo[116], out_fifo[115], 
					 out_fifo[114], out_fifo[113], out_fifo[112], out_fifo[111],
					 out_fifo[110], out_fifo[109], out_fifo[108], out_fifo[107], 
					 out_fifo[106], out_fifo[105], out_fifo[104], 
					 out_fifo[103], out_fifo[102], out_fifo[101], out_fifo[100], 
					 out_fifo[99], out_fifo[98], out_fifo[97], out_fifo[96], 
					 out_fifo[95], out_fifo[94], out_fifo[93], out_fifo[92], 
					 out_fifo[91], out_fifo[90], out_fifo[89], out_fifo[88], 
					 out_fifo[87], out_fifo[86], out_fifo[85], out_fifo[84], 
					 out_fifo[83], out_fifo[82], out_fifo[81], out_fifo[80],
					 out_fifo[79], out_fifo[78], out_fifo[77], out_fifo[76], 
					 out_fifo[75], out_fifo[74], out_fifo[73], out_fifo[72], 
					 out_fifo[71], out_fifo[70], out_fifo[69], out_fifo[68], 
					 out_fifo[67], out_fifo[66], out_fifo[65], out_fifo[64],
					 out_fifo[63], out_fifo[62], out_fifo[61], out_fifo[60], out_fifo[59], 
					 out_fifo[58], out_fifo[57], out_fifo[56], out_fifo[55], 
					 out_fifo[54], out_fifo[53], out_fifo[52], out_fifo[51], 
					 out_fifo[50], out_fifo[49], out_fifo[48], out_fifo[47],
					 out_fifo[46], out_fifo[45], out_fifo[44], out_fifo[43], 
					 out_fifo[42], out_fifo[41], out_fifo[40], 
					 out_fifo[39], out_fifo[38], out_fifo[37], out_fifo[36], 
					 out_fifo[35], out_fifo[34], out_fifo[33], out_fifo[32], 
					 out_fifo[31], out_fifo[30], out_fifo[29], out_fifo[28], 
					 out_fifo[27], out_fifo[26], out_fifo[25], out_fifo[24], 
					 out_fifo[23], out_fifo[22], out_fifo[21], out_fifo[20], 
					 out_fifo[19], out_fifo[18], out_fifo[17], out_fifo[16],
					 out_fifo[15], out_fifo[14], out_fifo[13], out_fifo[12], 
					 out_fifo[11], out_fifo[10], out_fifo[9], out_fifo[8], 
					 out_fifo[7], out_fifo[6], out_fifo[5], out_fifo[4], 
					 out_fifo[3], out_fifo[2], out_fifo[1], out_fifo[0]}),
			       .i_fifo_empty(fifo_empty),			  
			  .i_fifo_out_ready(~fifo_out_full),
			  .o_fifo_read(fifo_read),		  
			  .o_out_fifo_write(o_out_fifo_write),
			  .o_data(o_data));	       
   

   initial begin
      $readmemh("data_256_16_1.txt", data, 0, LEAF_CNT*LEN_SEQ);
   end  
   
   always @ (negedge clk) begin
      counter <= counter + 1;	       
      for(i=0; i<LEAF_CNT; i=i+1) begin
	 if(~fifo_full[i]) begin
	    if(rdaddr[i] < (i+1)*LEN_SEQ-1) begin
	       write_fifo[i] <= 1;	       	 	    	       
	       rdaddr[i] <= rdaddr[i]+1;
	    end
	    else if(rdaddr[i] == (i+1)*LEN_SEQ-1) begin
	       write_fifo[i] <= 1;	       	 	    	       
	       rdaddr[i] <= LEAF_CNT*LEN_SEQ;      // This will push zeros for 3 clock cycles
	    end 
	    else begin
	       if (countdown[i] == 0) begin
		  write_fifo[i] <= 0;
	       end
	       else begin
		  countdown[i] <= countdown[i] - 1;		  
		  write_fifo[i] <= 1;	       	 	    		  
	       end
	    end
	 end // if (~fifo_full[i])
	 else begin
	    write_fifo[i] <= 0;
	 end
      end
   end
   
   always @ (posedge clk) begin
      for(k=0; k<LEAF_CNT; k = k+1) begin
	 in_fifo[k] <= data[rdaddr[k]];
      end
   end
   
   initial
     begin
	for (j=0; j<LEAF_CNT; j=j+1) begin
	   rdaddr[j] = j*LEN_SEQ;
	   write_fifo[j] <= 1'b1;
	   countdown[j] = 20;
	   in_fifo[j] <= data[rdaddr[j]];	   
	end
	clk <= 0;
     end

   always
     #2 clk = ~clk;
   
   initial
     begin
	$dumpfile("test_merger.vcd");
	$dumpvars(0,merger_tree_tb);
     end
   
   initial begin
      f = $fopen("out_256_16_1_16.txt", "w+");
   end

   always @(posedge clk) begin
      if(counter < LEAF_CNT*LEN_SEQ+2000) begin
	 if(read_fifo_out) begin
	    $fwrite(f, "%x\n", o_data);
	 end
      end
      else if(counter == LEAF_CNT*LEN_SEQ+2000) begin
	 $fclose(f);
	 $finish;
      end
   end
endmodule // merger_tb

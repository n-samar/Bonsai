`timescale 1 ns/10 ps

module merger_tree_tb;
   reg [2*L-1:0] write_fifo;
   reg read_fifo_out;
   
   wire [31:0] out_fifo [0:2*L-1];
   wire [2*L-1:0] fifo_full;
   reg [31:0] 	  in_fifo [0:2*L-1];
   wire       fifo_out_full, fifo_out_empty;
   wire [32-1:0] o_data;
   reg 	       clk;
   wire [32-1:0] out_fifo_item;
   wire [2*L-1:0] fifo_empty;
   wire [2*L-1:0] fifo_read;

   parameter L = 4;      
   parameter period = 4;   
   parameter LEAF_CNT = 2*L;
   parameter DATA_WIDTH = 32;
   parameter LEN_SEQ = 128;
   

   reg [31:0] 		   counter = 0;
   reg [31:0] 		   rdaddr [0:LEAF_CNT-1];
   integer 		   i;
   integer 		   j;
   integer 		   k;   
   reg [DATA_WIDTH-1:0]    data [0:LEN_SEQ*LEAF_CNT];
   integer 		   f;
   reg [31:0] 		   countdown [0:LEAF_CNT-1];   
   
   genvar 		   fifo_index;
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

   IFIFO16 fifo_out(.i_clk(clk),
			   .i_data(o_data),
			   .i_enq(o_out_fifo_write),
			   .o_data(out_fifo_item),
			   .i_deq(read_fifo_out),
			   .o_empty(fifo_out_empty),
			   .o_full(fifo_out_full));

   MERGER_TREE_P1_L4 dut (.i_clk(clk),
			  .i_fifo({out_fifo[7], out_fifo[6], out_fifo[5], out_fifo[4], 
				   out_fifo[3], out_fifo[2], out_fifo[1], out_fifo[0]}),
			  .i_fifo_empty(fifo_empty),			  
			  .i_fifo_out_ready(~fifo_out_full | read_fifo_out),
			  .o_fifo_read(fifo_read),		  
			  .o_out_fifo_write(o_out_fifo_write),
			  .o_data(o_data));	       
   

   initial begin
      $readmemh("data_8_128_1.txt", data, 0, LEAF_CNT*LEN_SEQ);
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
	read_fifo_out <= 1'b1;
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
      f = $fopen("out_8_128.txt", "w+");
   end
   
   always @(posedge clk) begin
      if(counter < LEAF_CNT*LEN_SEQ+1000) begin
	 $fwrite(f, "%x\n", o_data);
      end
      else if(counter == LEAF_CNT*LEN_SEQ+1000) begin
	 $fclose(f);
	 $finish;
      end
   end
endmodule // merger_tb

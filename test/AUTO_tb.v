`timescale 1 ns/10 ps

module merger_tb;
   reg [1:0] write_fifo;
   reg 	     read_fifo_out;
   wire [1:0] fifo_full;
   wire fifo_out_overrun, fifo_out_underrun;
   wire [31:0] 			   out_fifo [0:1];
   reg [31:0] 			   in_fifo [0:1];
   reg [31:0] 			   in_fifo_2;   
   wire [1:0] 			   fifo_empty;
   wire 			   fifo_out_full, fifo_out_empty;
   wire [1:0] 			   fifo_read;
   wire 			   o_out_fifo_write;
   wire [31:0] 			   o_data;
   reg 			   clk;
   wire [31:0] 		   out_fifo_item;
   
   parameter period = 4;
   parameter LEN_SEQ = 128;   // Length of each input sequence
   parameter DATA_WIDTH = 32;
   parameter LEAF_CNT = 2;

   reg [31:0] 		   counter = 0;
   reg [31:0] 		   rdaddr [0:LEAF_CNT-1];
   integer 		   i;
   integer 		   j;
   integer 		   k;   
   reg [DATA_WIDTH-1:0] data [0:LEN_SEQ*LEAF_CNT];
   integer 		f;
   reg [31:0] 		countdown [0:LEAF_CNT-1];
   

   FIFO_EMPTY fifo_0(.i_clk(clk),
	       .i_item(in_fifo[0] ),
	       .i_write(write_fifo[0]),
	       .o_item(out_fifo[0]),
	       .i_read(fifo_read[0]),
	       .empty(fifo_empty[0]),
	       .full(fifo_full[0]),
	       .overrun(),
	       .underrun());

   FIFO_EMPTY fifo_1(.i_clk(clk),
	       .i_item(in_fifo[1]),
	       .i_write(write_fifo[1]),
	       .o_item(out_fifo[1]),
	       .i_read(fifo_read[1]),
	       .empty(fifo_empty[1]),
	       .full(fifo_full[1]),
	       .overrun(),
	       .underrun());

   FIFO fifo_out(.i_clk(clk),
	       .i_item(o_data),
	       .i_write(o_out_fifo_write),
	       .o_item(out_fifo_item),
	       .i_read(read_fifo_out),
	       .empty(fifo_out_empty),
	       .full(fifo_out_full),
	       .overrun(),
	       .underrun());

   MERGER_1 dut (.i_clk(clk),
	       .i_fifo_1(out_fifo[0]),
	       .i_fifo_1_empty(fifo_empty[0]),
	       .i_fifo_2(out_fifo[1]),
	       .i_fifo_2_empty(fifo_empty[1]),
	       .i_fifo_out_ready(~fifo_out_full | read_fifo_out),
	       .o_fifo_1_read(fifo_read[0]),
	       .o_fifo_2_read(fifo_read[1]),
	       .o_out_fifo_write(o_out_fifo_write),
	       .o_data(o_data));	     


   initial begin
      $readmemh("data_2_128.txt", data, 0, LEAF_CNT*LEN_SEQ);
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
	   countdown[j] = 10;
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
	$dumpvars(0,merger_tb);
     end
   
   initial begin
      f = $fopen("out_2_128.txt", "w+");
   end
   
   always @(posedge clk) begin
      if(counter < 10*LEAF_CNT*LEN_SEQ+1000) begin
	 $fwrite(f, "%x\n", o_data);
      end
      else if(counter == 10*LEAF_CNT*LEN_SEQ+1000) begin
	 $fclose(f);
	 $finish;
      end
   end
endmodule // merger_tb


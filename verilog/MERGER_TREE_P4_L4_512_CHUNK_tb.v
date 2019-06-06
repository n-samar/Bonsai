`timescale 1 ns/10 ps

module merger_tree_tb;
   reg [2*L-1:0] write_fifo;
   wire read_fifo_out;
   
   wire [31:0] out_fifo [0:2*L-1];
   wire [2*L-1:0] fifo_full;
   reg [31:0] 	  in_fifo [0:2*L-1];
   wire       fifo_out_full, fifo_out_empty;
   wire [4*32-1:0] o_data;
   reg 	       clk;
   wire [4*32-1:0] out_fifo_item;
   wire [2*L-1:0] fifo_empty;
   wire [2*L-1:0] fifo_read;

   parameter L = 4;      
   parameter period = 4;   
   parameter LEAF_CNT = 2*L;
   parameter DATA_WIDTH = 32;
   parameter BURST_SIZE = 16;
   parameter LEN_SEQ = 4*512;
   integer 	  data_file;
   
   reg [31:0] 	  buffer_counter = 0;   
   reg [31:0] 	  counter = 0;
   reg [31:0] 	  rdaddr [0:LEAF_CNT-1];
   wire [LEAF_CNT-1:0] available;
   
   integer 		   i;
   integer 		   j;
   integer 		   k;   
   reg [DATA_WIDTH-1:0]    data [0:LEN_SEQ*LEAF_CNT];
   integer 		   f;
   reg [31:0] 		   countdown [0:LEAF_CNT-1];
   reg [3:0] 		   buffer_ptr [0:LEAF_CNT-1];
   reg [LEAF_CNT-1:0] 	   buffer_enq;
   reg [LEAF_CNT-1:0] 	   buffer_deq;
   wire [LEAF_CNT-1:0] 	   buffer_empty;
   wire [LEAF_CNT-1:0] 	   buffer_full;
   reg [31:0] 			   readmemh_data[0:15];
   
   reg [511:0] 		   buffer_in [0:LEAF_CNT-1];   
   wire [511:0]        buffer_out [0:LEAF_CNT-1];
   

   assign read_fifo_out = ~fifo_out_empty;
   
   
   genvar              fifo_index;
   generate
      for (fifo_index = 0; fifo_index < 2*L; fifo_index = fifo_index + 1) begin : IN
	 IFIFO32 #(512) buffer(.i_clk(clk),
			               .i_data(buffer_in[fifo_index]),
			               .o_data(buffer_out[fifo_index]),
			               .i_enq(buffer_enq[fifo_index]),
			               .i_deq(buffer_deq[fifo_index]),
			               .o_full(buffer_full[fifo_index]),
                           .o_available(available[fifo_index]),
			               .o_empty(buffer_empty[fifo_index]));
	 
	 IFIFO16 #(32) fifo(.i_clk(clk),
			 .i_data(in_fifo[fifo_index]),
			 .i_enq(write_fifo[fifo_index]),
			 .o_data(out_fifo[fifo_index]),
			 .i_deq(fifo_read[fifo_index]),
			 .o_empty(fifo_empty[fifo_index]),
			 .o_full(fifo_full[fifo_index]));	 
      end // block: IN
   endgenerate

   IFIFO16 #(128) fifo_out(.i_clk(clk),
		    .i_data(o_data),
		    .i_enq(o_out_fifo_write),
		    .o_data(out_fifo_item),
		    .i_deq(read_fifo_out),
		    .o_empty(fifo_out_empty),
		    .o_full(fifo_out_full));

   MERGER_TREE_P4_L4 dut (.i_clk(clk),
			  .i_fifo({out_fifo[7], out_fifo[6], out_fifo[5], out_fifo[4], 
				   out_fifo[3], out_fifo[2], out_fifo[1], out_fifo[0]}),
			  .i_fifo_empty(fifo_empty),			  
			  .i_fifo_out_ready(~fifo_out_full | read_fifo_out),
			  .o_fifo_read(fifo_read),		  
			  .o_out_fifo_write(o_out_fifo_write),
			  .o_data(o_data));	       

   integer ind;
   
   always @ (negedge clk) begin
      counter <= counter + 1;	    
      for(i=0; i<LEAF_CNT; i=i+1) begin
	 if (buffer_ptr[i] == 15 & ~buffer_empty[i] & ~fifo_full[i]) begin
	    buffer_deq[i] <= 1;	   
	 end
	 else begin
	    buffer_deq[i] <= 0;	    
	 end // if (~fifo_full[i])
      end
   end // always @ (negedge clk)

   initial begin
      $readmemh("data_P4_L4_512_chunk.txt", data, 0, LEAF_CNT*LEN_SEQ);      
   end

   integer l, z;
   always @ (posedge clk) begin
      for (l = 0;  l < LEAF_CNT; l=l+1) begin
	     if(~fifo_full[l] & ~buffer_empty[l]) begin
	        write_fifo[l] <= 1;	       	 	    	       
	        buffer_ptr[l] <= (buffer_ptr[l]+1)%(16);

	     end
	     else begin
	        write_fifo[l] <= 0;
	     end
         
	 if (l == (buffer_counter/BURST_SIZE)%(LEAF_CNT)) begin
	    if (available[l] | buffer_enq[l]) begin
	       buffer_enq[l] <= 1;
	       rdaddr[l] <= rdaddr[l] + 16;
	       buffer_counter <= (buffer_counter + 1) % (BURST_SIZE*LEAF_CNT);
	       if (rdaddr[l] < (l+1)*LEN_SEQ) begin
		  buffer_in[l] <= {data[rdaddr[l]+15],
				   data[rdaddr[l]+14],
				   data[rdaddr[l]+13],
				   data[rdaddr[l]+12],
				   data[rdaddr[l]+11],
				   data[rdaddr[l]+10],
				   data[rdaddr[l]+9],
				   data[rdaddr[l]+8],
				   data[rdaddr[l]+7],
				   data[rdaddr[l]+6],
				   data[rdaddr[l]+5],
				   data[rdaddr[l]+4],
				   data[rdaddr[l]+3],
				   data[rdaddr[l]+2],
				   data[rdaddr[l]+1],
				   data[rdaddr[l]+0]};
	       end
	       else begin
		  buffer_in[l] <= {data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0],
				   data[0]};	       
	       end	       
	    end 
	    else begin
	       buffer_enq[l] <= 0;
	       buffer_counter <= (buffer_counter + BURST_SIZE) % (BURST_SIZE*LEAF_CNT);			       
	    end
	 end // if (l == (buffer_counter/BURST_SIZE)%(LEAF_CNT))
	 else begin
	    buffer_enq[l] <= 0;	    
	 end
      end
   end




   integer x;
   always @ (posedge clk) begin
      for(x=0; x<LEAF_CNT; x=x+1) begin
	 if (~buffer_empty[x]) begin
	    in_fifo[x] <= {buffer_out[x][32*buffer_ptr[x]+31],
			   buffer_out[x][32*buffer_ptr[x]+30],
			   buffer_out[x][32*buffer_ptr[x]+29],
			   buffer_out[x][32*buffer_ptr[x]+28],
			   buffer_out[x][32*buffer_ptr[x]+27],
			   buffer_out[x][32*buffer_ptr[x]+26],
			   buffer_out[x][32*buffer_ptr[x]+25],
			   buffer_out[x][32*buffer_ptr[x]+24],
			   buffer_out[x][32*buffer_ptr[x]+23],
			   buffer_out[x][32*buffer_ptr[x]+22],
			   buffer_out[x][32*buffer_ptr[x]+21],
			   buffer_out[x][32*buffer_ptr[x]+20],
			   buffer_out[x][32*buffer_ptr[x]+19],
			   buffer_out[x][32*buffer_ptr[x]+18],
			   buffer_out[x][32*buffer_ptr[x]+17],
			   buffer_out[x][32*buffer_ptr[x]+16],
			   buffer_out[x][32*buffer_ptr[x]+15],
			   buffer_out[x][32*buffer_ptr[x]+14],
			   buffer_out[x][32*buffer_ptr[x]+13],
			   buffer_out[x][32*buffer_ptr[x]+12],
			   buffer_out[x][32*buffer_ptr[x]+11],
			   buffer_out[x][32*buffer_ptr[x]+10],
			   buffer_out[x][32*buffer_ptr[x]+9],
			   buffer_out[x][32*buffer_ptr[x]+8],
			   buffer_out[x][32*buffer_ptr[x]+7],
			   buffer_out[x][32*buffer_ptr[x]+6],
			   buffer_out[x][32*buffer_ptr[x]+5],
			   buffer_out[x][32*buffer_ptr[x]+4],
			   buffer_out[x][32*buffer_ptr[x]+3],
			   buffer_out[x][32*buffer_ptr[x]+2],
			   buffer_out[x][32*buffer_ptr[x]+1],
			   buffer_out[x][32*buffer_ptr[x]+0]			   
			   };
	 end
      end
   end   

   integer b;   
   initial
     begin
	for (j=0; j<LEAF_CNT; j=j+1) begin
	   rdaddr[j] = j*LEN_SEQ;
	   write_fifo[j] <= 0;
	   countdown[j] = 20;
	   in_fifo[j] <= 0;
	   buffer_ptr[j] <= 0;
	   in_fifo[j] <= 0;
	   buffer_enq[j] <= 0;
	   buffer_deq[j] <= 0;
	   buffer_in[j] <= 0;
	end
	clk <= 0;
     end

   always
     #2 clk = ~clk;
   
   initial
     begin
	$dumpfile("test_merger_512_chunk.vcd");
	$dumpvars(0, merger_tree_tb);
     end
   
   initial begin
      f = $fopen("out_P4_L4_512_chunk.txt", "w+");
   end

   always @(posedge clk) begin
      if(counter < (LEAF_CNT*LEN_SEQ)/4+175+1000) begin
	 if(read_fifo_out) begin
	    $fwrite(f, "%x\n", o_data);
	 end
      end
      else if(counter == (LEAF_CNT*LEN_SEQ)/4+175+1000) begin
	 $fclose(f);
	 $finish;
      end
   end
endmodule // merger_tb

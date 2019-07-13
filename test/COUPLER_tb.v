`timescale 1 ns/10 ps

module coupler_tb;
   wire [63:0] 			   o_data;
   reg [31:0] 			   i_data;
   reg                     clk;
   wire [31:0]             out_fifo_item;
   wire                    i_enq;
   wire                    i_deq;
   reg [31:0]              counter;
   
   
   parameter period = 4;
   parameter LEN_SEQ = 128;   // Length of each input sequence
   parameter DATA_WIDTH = 32;

   reg [31:0] 		   rdaddr;
   reg [DATA_WIDTH-1:0] data [0:LEN_SEQ];
   integer              f;
   


   initial begin
      $readmemh("data_1_128_1.txt", data, 0, LEN_SEQ);
   end

   COUPLER coupler(.i_clk(clk), 
		  .i_data(i_data), 
		  .o_data(o_data),
		  .i_enq(i_enq), 		  
		  .i_deq(i_deq), 
		  .o_empty(o_empty), 
		  .o_full(o_full));   
   
   always @ (posedge clk) begin
      counter <= counter + 1;
	 if(~o_full) begin
	    i_data = data[rdaddr];	       	       	    	    
	    if(rdaddr < LEN_SEQ) begin
	       rdaddr = rdaddr+1;	    	       
	    end
	 end
   end

   assign i_deq = ~o_empty;
   assign i_enq = ~o_full;
   
   
   initial
     begin
        counter <= 0;        
	rdaddr <= 0;
	i_data <= 0;	   
	clk <= 0;
     end

   always
     #2 clk = ~clk;
   
   initial
     begin
	    $dumpfile("test_merger.vcd");
	    $dumpvars(0, coupler_tb);
     end
   
   initial begin
      f = $fopen("out_1_128.txt", "w+");
   end
   
   always @(posedge clk) begin
      if(counter < LEN_SEQ+1000) begin
         if (i_deq) begin
	        $fwrite(f, "%x\n", o_data);
         end
      end
      else if(counter == LEN_SEQ+1000) begin
	     $fclose(f);
	     $finish;
      end
   end
endmodule // coupler_tb


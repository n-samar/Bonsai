module FIFO(
	    input 		      i_clk,
	    input [(DATA_WIDTH-1):0]  i_item,
	    input 		      i_write,
	    input 		      i_read,	    	    
	    output reg [(DATA_WIDTH-1):0] o_item,
	    output reg empty,
	    output reg full,
	    output reg overrun,
	    output reg underrun
	    );
   parameter	FIFO_SIZE = 8;
   parameter DATA_WIDTH = 32;   
   reg	[(FIFO_SIZE-1):0]	rdaddr, wraddr;
   reg [(DATA_WIDTH-1):0] 	mem	[0:((1<<FIFO_SIZE)-1)];
   wire	[(DATA_WIDTH-1):0]	dblnext, nxtread;
   assign	dblnext = wraddr + 2;
   assign	nxtread = rdaddr + 1'b1;

   initial
     begin
	rdaddr <= 0;
	wraddr <= 0;
	overrun  <= 0;
	underrun <= 0;
     end
   
   always @(posedge i_clk)
     casez({ i_write, i_read, !full, !empty })
	4'b01?1: begin	// A successful read
		full  <= 1'b0;
		empty <= (nxtread == wraddr);
	end
	4'b101?: begin	// A successful write
		full <= (dblnext == rdaddr);
		empty <= 1'b0;
	end
	4'b11?0: begin	// Successful write, failed read
		full  <= 1'b0;
		empty <= 1'b0;
	end
	4'b11?1: begin	// Successful read and write
		full  <= full;
		empty <= 1'b0;
	end
	default: begin end
	endcase
   
   always @(posedge i_clk)
	mem[wraddr] <= i_item;

   always @(posedge i_clk)
	o_item <= mem[wraddr];

   always @(posedge i_clk)
     if (i_write)
	begin
		// Update the FIFO write address any time a write is made to
		// the FIFO and it's not FULL.
		//
		// OR any time a write is made to the FIFO at the same time a
		// read is made from the FIFO.
		if ((!full)||(i_read))
			wraddr <= (wraddr + 1'b1);
		else
			overrun <= 1'b1;
	end // if (i_write)

   // Set wraddr and underrun
   always @(posedge i_clk)
     if (i_read)
	begin
		// On any read request, increment the pointer if the FIFO isn't
		// empty--independent of whether a write operation is taking
		// place at the same time.
		if (!empty)
			rdaddr <= rdaddr + 1'b1;
		else
			underrun <= 1'b1;
	end // if (i_read)
endmodule

`timescale 1ns/10ps

/* 2-element tuples as input */
module FIFO_2(
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
   parameter	FIFO_SIZE = 4;
   parameter DATA_WIDTH = 64;   
   reg	[((1<<FIFO_SIZE)-1):0]	rdaddr, wraddr;
   reg [(DATA_WIDTH-1):0] 	mem	[0:((1<<FIFO_SIZE)-1)];
   wire	[((1<<FIFO_SIZE)-1):0]	dblnext, nxtread;
   
   assign	dblnext = (wraddr + 1) % (1<<FIFO_SIZE);
   assign	nxtread = (rdaddr + 1'b1) % (1<<FIFO_SIZE);

   initial
     begin
	/* Fill FIFO with zeros */
	mem[1] <= 0;	
	mem[2] <= 0;
	mem[3] <= 0;	
	overrun  <= 0;
	underrun <= 0;
	full <= 0;
	empty <= 0;

	wraddr <= 4;
	mem[wraddr] <= 0;
	rdaddr <= 0;		
	mem[0] <= 0;	
	o_item <= 0;
     end
   /* wait for read and write signals to be updated */   
   always @(i_write or i_read or rdaddr or wraddr) begin
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
     endcase // casez ({ i_write, i_read, !full, !empty })
   end // always @ (posedge i_clk)

   always @(i_item or wraddr)
     mem[wraddr] <= i_item;
   
   always @(posedge i_clk) begin
      if (i_write)
	begin
	   // Update the FIFO write address any time a write is made to
	   // the FIFO and it's not FULL.
	   //
	   // OR any time a write is made to the FIFO at the same time a
	   // read is made from the FIFO.
	   if ((!full)||(i_read))
	     wraddr <= (wraddr + 1'b1) % (1<<FIFO_SIZE);
	   else
	     overrun <= 1'b1;
	end // if (i_write)       
   end // always @ (posedge i_clk)

   always @(rdaddr)
     o_item <= mem[rdaddr]; 
   
   always @(posedge i_clk) begin
      if (i_read)
	begin
	  // On any read request, increment the pointer if the FIFO isn't
	  // empty--independent of whether a write operation is taking
	  // place at the same time.
	   if (!empty)
	     rdaddr <= (rdaddr + 1'b1) % (1<<FIFO_SIZE);
	   else
	     underrun <= 1'b1;
	end // if (i_read)
   end // always @ (posedge i_clk)
endmodule




module FIFO_EMPTY_2 (
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
   parameter	FIFO_SIZE = 3;
   parameter DATA_WIDTH = 64;   
   reg	[(FIFO_SIZE-1):0]	rdaddr, wraddr;
   reg [(DATA_WIDTH-1):0] 	mem	[0:((1<<FIFO_SIZE)-1)];
   wire	[(DATA_WIDTH-1):0]	dblnext, nxtread;
   assign	dblnext = (wraddr + 2) % (1 << FIFO_SIZE);
   assign	nxtread = (rdaddr + 1'b1) % (1 << FIFO_SIZE);

   initial
     begin
	overrun  <= 0;
	underrun <= 0;
	full <= 0;
	empty <= 1;
	wraddr = 0;
	mem[wraddr] <= i_item;
	rdaddr = 0;		
	mem[0] = 0;	
	o_item <= mem[rdaddr];
     end
   
   always @(i_write or i_read or rdaddr or wraddr) begin
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
     endcase // casez ({ i_write, i_read, !full, !empty })
   end // always @ (i_write or i_read or rdaddr or wraddr)
   
   always @(i_item or wraddr)
     mem[wraddr] <= i_item;
   
   always @(posedge i_clk) begin
     if (i_write)
       begin
	  // Update the FIFO write address any time a write is made to
	  // the FIFO and it's not FULL.
	  //
	  // OR any time a write is made to the FIFO at the same time a
	  // read is made from the FIFO.
	  if ((!full)||(i_read))
	    wraddr <= (wraddr + 1'b1) % (1<<FIFO_SIZE);
	  else
	    overrun <= 1'b1;
       end // if (i_write)       
   end // always @ (posedge i_clk)

   always @(rdaddr)
     o_item <= mem[rdaddr]; 
   

   always @(posedge i_clk) begin
      if (i_read)
	begin
	   // On any read request, increment the pointer if the FIFO isn't
	   // empty--independent of whether a write operation is taking
	   // place at the same time.
	   if (!empty)
	     rdaddr <= (rdaddr + 1'b1) % (1<<FIFO_SIZE);
	   else
	     underrun <= 1'b1;
	end // if (i_read)
   end // always @ (posedge i_clk)
endmodule

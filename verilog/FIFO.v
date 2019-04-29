`timescale 1ns/10ps

module shift_right_logical_16E (Q, A0, A1, A2, A3, CE, CLK, D);
   parameter INIT = 16'h0000;
   output Q;
   input   A0, A1, A2, A3, CE, CLK, D;
   reg [15:0] data;
   assign Q = data[{A3, A2, A1, A0}];
   initial begin
      data[0] = 0;
      data[1] = 0;
      data[2] = 0;
      data[3] = 0;
   end
   always @(posedge CLK)
     begin
	if (CE == 1'b1) begin
	   {data[15:0]} <= {data[14:0], D};
	end
     end
endmodule // shift_right_logical_16E

module IFIFO16 #(
  parameter P_WIDTH         = 32
) (
  input  wire               i_clk,
  input  wire [P_WIDTH-1:0] i_data,
  output wire [P_WIDTH-1:0] o_data,
  input  wire               i_enq,
  input  wire               i_deq,
  output wire               o_full,
  output reg                o_empty
);
  initial begin
     o_empty = 0; 
  end
  
  reg [4:0]  cnt =  4;
  reg [3:0]  adr = 3;
  
  always @(posedge i_clk) begin
    adr     <=   adr + i_enq - i_deq;
    cnt     <=   cnt + i_enq - i_deq;
    o_empty <= ((cnt + i_enq - i_deq)==0);
    // if(cnt>16) $display("%m invalid enq! cnt=%d", cnt);
  end
  assign o_full = cnt[4]; // not verified this logic !!
  
  genvar i;
  generate
    for (i=0; i<P_WIDTH; i=i+1) begin : FIFO
       shift_right_logical_16E fifo16(.CLK(i_clk), .CE(i_enq), .D(i_data[i]), .Q(o_data[i]),
                    .A0(adr[0]),  .A1(adr[1]), .A2(adr[2]),  .A3(adr[3]));
    end
  endgenerate
endmodule

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
   parameter	FIFO_SIZE = 4;
   parameter DATA_WIDTH = 32;   
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
   always @(posedge i_clk) begin
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




module FIFO_EMPTY (
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
   parameter DATA_WIDTH = 32;   
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
   
   always @(posedge i_clk) begin
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

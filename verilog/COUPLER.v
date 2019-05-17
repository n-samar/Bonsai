`timescale 1ns/10ps

module COUPLER #(
  parameter P_WIDTH         = 32
) (
  input wire                  i_clk,
  input wire [P_WIDTH-1:0]    i_data,
  output wire [2*P_WIDTH-1:0] o_data,
  input wire                  i_enq,
  input wire                  i_deq,
  output                      o_full,
  output                      o_empty
);
   
   reg                        state;
   reg [P_WIDTH-1:0]          first_elem;
   reg [P_WIDTH-1:0]          second_elem;
   wire [2*P_WIDTH-1:0]       out_elem;
   wire [P_WIDTH-1:0]          in_elem;
   reg                         in_deq, out_enq;
   
   
   
   IFIFO16 #(P_WIDTH) in_fifo (.i_clk(i_clk),
                               .i_data(i_data),
                               .o_data(in_elem),
                               .i_enq(i_enq),
                               .i_deq(in_deq),
                               .o_full(o_full),
                               .o_empty(in_empty));

   IFIFO16 #(2*P_WIDTH) out_fifo (.i_clk(i_clk),
                                  .i_data(out_elem),
                                  .o_data(o_data),
                                  .i_enq(out_enq),
                                  .i_deq(i_deq),
                                  .o_full(out_full),
                                  .o_empty(o_empty));                    
   
   assign out_elem = {second_elem, first_elem};
   
   initial begin
      in_deq <= 1;
      out_enq <= 1;
      state <= 0;
      first_elem <= 0;
      second_elem <= 0;      
   end
   
   always @(negedge i_clk) begin
      if (~out_full & ~in_empty) begin
         if (state == 0) begin
            in_deq <= 1;	    
            out_enq <= 0;            
            first_elem <= in_elem;
            state <= 1;
         end
         else if (state == 1) begin
	    if (first_elem != 0) begin
	       in_deq <= 1;
               second_elem <= in_elem;   
	    end
	    else begin
	       in_deq <= 0;
	       second_elem <= 0;	       
	    end	      
            state <= 0;  
            out_enq <= 1;            
         end
      end 
      else begin
	 if (~out_full & out_elem == 0) begin
	    out_enq <= 1;
	 end
	 else begin
	    out_enq <= 0;	    
	 end
         in_deq <= 0;         
      end
   end
   
endmodule

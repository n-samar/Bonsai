/* For 8-merger */
module BITONIC_NETWORK_16 #(parameter DATA_WIDTH = 128,
			    parameter KEY_WIDTH = 80) (input i_clk,
			  input 		switch_output,
			  input 		stall,
			  input [8*DATA_WIDTH-1:0] 	top_tuple,
			  input [8*DATA_WIDTH-1:0] 	i_elems_0,
			  input [8*DATA_WIDTH-1:0] 	i_elems_1, 
			  output reg [8*DATA_WIDTH-1:0] o_elems_0,
			  output reg [8*DATA_WIDTH-1:0] o_elems_1,
			  output reg 		o_switch_output,
			  output reg 		o_stall,
			  output reg [8*DATA_WIDTH-1:0] o_top_tuple);
   
   reg                                    stall_1;
   reg                                    stall_2;
   reg                                    stall_3;
   
   reg                                    switch_output_1;
   reg                                    switch_output_2;
   reg                                    switch_output_3;

   wire [8*DATA_WIDTH-1:0] 			top_tuple_1;
   reg [8*DATA_WIDTH-1:0] 			top_tuple_2;
   reg [8*DATA_WIDTH-1:0] 			top_tuple_3;      
   
   reg [8*DATA_WIDTH-1:0] 			elems_1_0;
   reg [8*DATA_WIDTH-1:0] 			elems_1_1;
   
   reg [8*DATA_WIDTH-1:0] 			elems_2_0;
   reg [8*DATA_WIDTH-1:0] 			elems_2_1;
   
   reg [8*DATA_WIDTH-1:0]             elems_3_0;
   reg [8*DATA_WIDTH-1:0] 			elems_3_1;
   
   
   initial begin
      stall_1 <= 0;
      switch_output_1 <= 0;
      elems_1_0 <= 0;
      elems_1_1 <= 0;

      stall_2 <= 0;
      switch_output_2 <= 0;
      elems_2_0 <= 0;
      elems_2_1 <= 0;
      top_tuple_2 <= 0;
      
      stall_3 <= 0;
      switch_output_3 <= 0;
      elems_3_0 <= 0;
      elems_3_1 <= 0;
      top_tuple_3 <= 0;
      
      o_elems_0 <= 0;
      o_elems_1 <= 0;
      o_stall <= 0;
   end

   /* step 1 */
   assign top_tuple_1 = top_tuple;   
   always @(posedge i_clk) begin
      stall_1 <= stall;
      if (~stall) begin
	     switch_output_1 <= switch_output;

         // CAS(0, 15)
	     if (i_elems_0[KEY_WIDTH-1:0] > i_elems_1[7*DATA_WIDTH+KEY_WIDTH-1:7*DATA_WIDTH]) begin
	        /* switch */
	        elems_1_0[DATA_WIDTH-1:0] <= i_elems_1[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        elems_1_1[8*DATA_WIDTH-1:7*DATA_WIDTH] <= i_elems_0[DATA_WIDTH-1:0];
	     end
	     else begin
	        /* stay */
	        elems_1_1[8*DATA_WIDTH-1:7*DATA_WIDTH] <= i_elems_1[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        elems_1_0[DATA_WIDTH-1:0] <= i_elems_0[DATA_WIDTH-1:0];	    
	     end
         
         // CAS(1, 14)
	     if (i_elems_0[DATA_WIDTH+KEY_WIDTH-1:DATA_WIDTH] > i_elems_1[6*DATA_WIDTH+KEY_WIDTH-1:6*DATA_WIDTH]) begin
	        /* switch */
	        elems_1_0[2*DATA_WIDTH-1:DATA_WIDTH] <= i_elems_1[7*DATA_WIDTH-1:6*DATA_WIDTH];
	        elems_1_1[7*DATA_WIDTH-1:6*DATA_WIDTH] <= i_elems_0[2*DATA_WIDTH-1:DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_1_0[2*DATA_WIDTH-1:DATA_WIDTH] <= i_elems_0[2*DATA_WIDTH-1:DATA_WIDTH];
	        elems_1_1[7*DATA_WIDTH-1:6*DATA_WIDTH] <= i_elems_1[7*DATA_WIDTH-1:6*DATA_WIDTH];
	     end         

         // CAS(2, 13)
	     if (i_elems_0[2*DATA_WIDTH+KEY_WIDTH-1:2*DATA_WIDTH] > i_elems_1[5*DATA_WIDTH+KEY_WIDTH-1:5*DATA_WIDTH]) begin
	        /* switch */
	        elems_1_0[3*DATA_WIDTH-1:2*DATA_WIDTH] <= i_elems_1[6*DATA_WIDTH-1:5*DATA_WIDTH];
	        elems_1_1[6*DATA_WIDTH-1:5*DATA_WIDTH] <= i_elems_0[3*DATA_WIDTH-1:2*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_1_0[3*DATA_WIDTH-1:2*DATA_WIDTH] <= i_elems_0[3*DATA_WIDTH-1:2*DATA_WIDTH];
	        elems_1_1[6*DATA_WIDTH-1:5*DATA_WIDTH] <= i_elems_1[6*DATA_WIDTH-1:5*DATA_WIDTH];
	     end                  

         // CAS(3, 12)
	     if (i_elems_0[3*DATA_WIDTH+KEY_WIDTH-1:3*DATA_WIDTH] > i_elems_1[4*DATA_WIDTH+KEY_WIDTH-1:4*DATA_WIDTH]) begin
	        /* switch */
	        elems_1_0[4*DATA_WIDTH-1:3*DATA_WIDTH] <= i_elems_1[5*DATA_WIDTH-1:4*DATA_WIDTH];
	        elems_1_1[5*DATA_WIDTH-1:4*DATA_WIDTH] <= i_elems_0[4*DATA_WIDTH-1:3*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_1_0[4*DATA_WIDTH-1:3*DATA_WIDTH] <= i_elems_0[4*DATA_WIDTH-1:3*DATA_WIDTH];
	        elems_1_1[5*DATA_WIDTH-1:4*DATA_WIDTH] <= i_elems_1[5*DATA_WIDTH-1:4*DATA_WIDTH];
	     end         

         // CAS(4, 11)
	     if (i_elems_0[4*DATA_WIDTH+KEY_WIDTH-1:4*DATA_WIDTH] > i_elems_1[3*DATA_WIDTH+KEY_WIDTH-1:3*DATA_WIDTH]) begin
	        /* switch */
	        elems_1_0[5*DATA_WIDTH-1:4*DATA_WIDTH] <= i_elems_1[4*DATA_WIDTH-1:3*DATA_WIDTH];
	        elems_1_1[4*DATA_WIDTH-1:3*DATA_WIDTH] <= i_elems_0[5*DATA_WIDTH-1:4*DATA_WIDTH];
	     end
	     else begin
	        /* stay */ 
	        elems_1_0[5*DATA_WIDTH-1:4*DATA_WIDTH] <= i_elems_0[5*DATA_WIDTH-1:4*DATA_WIDTH];
	        elems_1_1[4*DATA_WIDTH-1:3*DATA_WIDTH] <= i_elems_1[4*DATA_WIDTH-1:3*DATA_WIDTH];
	     end          
        
         // CAS(5, 10)
	     if (i_elems_0[5*DATA_WIDTH+KEY_WIDTH-1:5*DATA_WIDTH] > i_elems_1[2*DATA_WIDTH+KEY_WIDTH-1:2*DATA_WIDTH]) begin
	        /* switch */
	        elems_1_0[6*DATA_WIDTH-1:5*DATA_WIDTH] <= i_elems_1[3*DATA_WIDTH-1:2*DATA_WIDTH];
	        elems_1_1[3*DATA_WIDTH-1:2*DATA_WIDTH] <= i_elems_0[6*DATA_WIDTH-1:5*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_1_0[6*DATA_WIDTH-1:5*DATA_WIDTH] <= i_elems_0[6*DATA_WIDTH-1:5*DATA_WIDTH];
	        elems_1_1[3*DATA_WIDTH-1:2*DATA_WIDTH] <= i_elems_1[3*DATA_WIDTH-1:2*DATA_WIDTH];
	     end
         
         // CAS(6, 9)
	     if (i_elems_0[6*DATA_WIDTH+KEY_WIDTH-1:6*DATA_WIDTH] > i_elems_1[1*DATA_WIDTH+KEY_WIDTH-1:1*DATA_WIDTH]) begin
	        /* switch */
	        elems_1_0[7*DATA_WIDTH-1:6*DATA_WIDTH] <= i_elems_1[2*DATA_WIDTH-1:1*DATA_WIDTH];
	        elems_1_1[2*DATA_WIDTH-1:1*DATA_WIDTH] <= i_elems_0[7*DATA_WIDTH-1:6*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_1_0[7*DATA_WIDTH-1:6*DATA_WIDTH] <= i_elems_0[7*DATA_WIDTH-1:6*DATA_WIDTH];
	        elems_1_1[2*DATA_WIDTH-1:1*DATA_WIDTH] <= i_elems_1[2*DATA_WIDTH-1:1*DATA_WIDTH];
	     end
         
         // CAS(7, 8)
	     if (i_elems_0[7*DATA_WIDTH+KEY_WIDTH-1:7*DATA_WIDTH] > i_elems_1[KEY_WIDTH-1:0*DATA_WIDTH]) begin
	        /* switch */
	        elems_1_0[8*DATA_WIDTH-1:7*DATA_WIDTH] <= i_elems_1[1*DATA_WIDTH-1:0*DATA_WIDTH];
	        elems_1_1[1*DATA_WIDTH-1:0*DATA_WIDTH] <= i_elems_0[8*DATA_WIDTH-1:7*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_1_0[8*DATA_WIDTH-1:7*DATA_WIDTH] <= i_elems_0[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        elems_1_1[1*DATA_WIDTH-1:0*DATA_WIDTH] <= i_elems_1[1*DATA_WIDTH-1:0*DATA_WIDTH];
	     end                                     
      end // if (~stall)      
   end

   /* step 2 */
   always @(posedge i_clk) begin
      stall_2 <= stall_1;
      if (~stall_1) begin
	     switch_output_2 <= switch_output_1;
	     top_tuple_2 <= top_tuple_1;

         // CAS(0, 4)
	     if (elems_1_0[1*KEY_WIDTH-1:0*DATA_WIDTH] > elems_1_0[4*DATA_WIDTH+KEY_WIDTH-1:4*DATA_WIDTH]) begin
	        /* switch */
	        elems_2_0[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_1_0[1*DATA_WIDTH-1:0*DATA_WIDTH];
	        elems_2_0[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_1_0[5*DATA_WIDTH-1:4*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_2_0[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_1_0[5*DATA_WIDTH-1:4*DATA_WIDTH];
	        elems_2_0[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_1_0[1*DATA_WIDTH-1:0*DATA_WIDTH];
	     end
         
         // CAS(1, 5)
	     if (elems_1_0[1*DATA_WIDTH+KEY_WIDTH-1:1*DATA_WIDTH] > elems_1_0[5*DATA_WIDTH+KEY_WIDTH-1:5*DATA_WIDTH]) begin
	        /* switch */
	        elems_2_0[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_1_0[2*DATA_WIDTH-1:1*DATA_WIDTH];
	        elems_2_0[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_1_0[6*DATA_WIDTH-1:5*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_2_0[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_1_0[6*DATA_WIDTH-1:5*DATA_WIDTH];
	        elems_2_0[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_1_0[2*DATA_WIDTH-1:1*DATA_WIDTH];
	     end
         
         // CAS(2, 6)
	     if (elems_1_0[2*DATA_WIDTH+KEY_WIDTH-1:2*DATA_WIDTH] > elems_1_0[6*DATA_WIDTH+KEY_WIDTH-1:6*DATA_WIDTH]) begin
	        /* switch */
	        elems_2_0[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_1_0[3*DATA_WIDTH-1:2*DATA_WIDTH];
	        elems_2_0[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_1_0[7*DATA_WIDTH-1:6*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_2_0[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_1_0[7*DATA_WIDTH-1:6*DATA_WIDTH];
	        elems_2_0[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_1_0[3*DATA_WIDTH-1:2*DATA_WIDTH];
	     end
         
         // CAS(3, 7)
	     if (elems_1_0[3*DATA_WIDTH+KEY_WIDTH-1:3*DATA_WIDTH] > elems_1_0[7*DATA_WIDTH+KEY_WIDTH-1:7*DATA_WIDTH]) begin
	        /* switch */
	        elems_2_0[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_1_0[4*DATA_WIDTH-1:3*DATA_WIDTH];
	        elems_2_0[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_1_0[8*DATA_WIDTH-1:7*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_2_0[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_1_0[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        elems_2_0[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_1_0[4*DATA_WIDTH-1:3*DATA_WIDTH];
	     end                  
/**********************************************************************/
         // CAS(8, 12)
	     if (elems_1_1[1*KEY_WIDTH-1:0*DATA_WIDTH] > elems_1_1[4*DATA_WIDTH+KEY_WIDTH-1:4*DATA_WIDTH]) begin
	        /* switch */
	        elems_2_1[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_1_1[1*DATA_WIDTH-1:0*DATA_WIDTH];
	        elems_2_1[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_1_1[5*DATA_WIDTH-1:4*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_2_1[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_1_1[5*DATA_WIDTH-1:4*DATA_WIDTH];
	        elems_2_1[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_1_1[1*DATA_WIDTH-1:0*DATA_WIDTH];
	     end
         
         // CAS(9, 13)
	     if (elems_1_1[1*DATA_WIDTH+KEY_WIDTH-1:1*DATA_WIDTH] > elems_1_1[5*DATA_WIDTH+KEY_WIDTH-1:5*DATA_WIDTH]) begin
	        /* switch */
	        elems_2_1[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_1_1[2*DATA_WIDTH-1:1*DATA_WIDTH];
	        elems_2_1[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_1_1[6*DATA_WIDTH-1:5*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_2_1[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_1_1[6*DATA_WIDTH-1:5*DATA_WIDTH];
	        elems_2_1[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_1_1[2*DATA_WIDTH-1:1*DATA_WIDTH];
	     end
         
         // CAS(10, 14)
	     if (elems_1_1[2*DATA_WIDTH+KEY_WIDTH-1:2*DATA_WIDTH] > elems_1_1[6*DATA_WIDTH+KEY_WIDTH-1:6*DATA_WIDTH]) begin
	        /* switch */
	        elems_2_1[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_1_1[3*DATA_WIDTH-1:2*DATA_WIDTH];
	        elems_2_1[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_1_1[7*DATA_WIDTH-1:6*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_2_1[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_1_1[7*DATA_WIDTH-1:6*DATA_WIDTH];
	        elems_2_1[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_1_1[3*DATA_WIDTH-1:2*DATA_WIDTH];
	     end
         
         // CAS(11, 15)
	     if (elems_1_1[3*DATA_WIDTH+KEY_WIDTH-1:3*DATA_WIDTH] > elems_1_1[7*DATA_WIDTH+KEY_WIDTH-1:7*DATA_WIDTH]) begin
	        /* switch */
	        elems_2_1[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_1_1[4*DATA_WIDTH-1:3*DATA_WIDTH];
	        elems_2_1[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_1_1[8*DATA_WIDTH-1:7*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_2_1[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_1_1[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        elems_2_1[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_1_1[4*DATA_WIDTH-1:3*DATA_WIDTH];
	     end                  
      end
   end // always @ (posedge i_clk)

   /* step 3 */
   always @(posedge i_clk) begin
      stall_3 <= stall_2;
      if (~stall_2) begin
	     switch_output_3 <= switch_output_2;
	     top_tuple_3 <= top_tuple_2;

         // CAS(0, 2)
	     if (elems_2_0[1*KEY_WIDTH-1:0*DATA_WIDTH] > elems_2_0[2*DATA_WIDTH+KEY_WIDTH-1:2*DATA_WIDTH]) begin
	        /* switch */
	        elems_3_0[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_2_0[3*DATA_WIDTH-1:2*DATA_WIDTH];
	        elems_3_0[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_2_0[1*DATA_WIDTH-1:0*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_3_0[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_2_0[1*DATA_WIDTH-1:0*DATA_WIDTH];
	        elems_3_0[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_2_0[3*DATA_WIDTH-1:2*DATA_WIDTH];
	     end
         
         // CAS(1, 3)
	     if (elems_2_0[1*DATA_WIDTH+KEY_WIDTH-1:1*DATA_WIDTH] > elems_2_0[3*DATA_WIDTH+KEY_WIDTH-1:3*DATA_WIDTH]) begin
	        /* switch */
	        elems_3_0[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_2_0[2*DATA_WIDTH-1:1*DATA_WIDTH];
	        elems_3_0[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_2_0[4*DATA_WIDTH-1:3*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_3_0[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_2_0[4*DATA_WIDTH-1:3*DATA_WIDTH];
	        elems_3_0[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_2_0[2*DATA_WIDTH-1:1*DATA_WIDTH];
	     end         

         // CAS(4, 6)
	     if (elems_2_0[4*DATA_WIDTH+KEY_WIDTH-1:4*DATA_WIDTH] > elems_2_0[6*DATA_WIDTH+KEY_WIDTH-1:6*DATA_WIDTH]) begin
	        /* switch */
	        elems_3_0[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_2_0[7*DATA_WIDTH-1:6*DATA_WIDTH];
	        elems_3_0[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_2_0[5*DATA_WIDTH-1:4*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_3_0[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_2_0[5*DATA_WIDTH-1:4*DATA_WIDTH];
	        elems_3_0[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_2_0[7*DATA_WIDTH-1:6*DATA_WIDTH];
	     end     
             
         // CAS(5, 7)
	     if (elems_2_0[5*DATA_WIDTH+KEY_WIDTH-1:5*DATA_WIDTH] > elems_2_0[7*DATA_WIDTH+KEY_WIDTH-1:7*DATA_WIDTH]) begin
	        /* switch */
	        elems_3_0[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_2_0[6*DATA_WIDTH-1:5*DATA_WIDTH];
	        elems_3_0[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_2_0[8*DATA_WIDTH-1:7*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_3_0[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_2_0[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        elems_3_0[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_2_0[6*DATA_WIDTH-1:5*DATA_WIDTH];
	     end              
/*****************************************************************/
         
         // CAS(8, 10)
	     if (elems_2_1[1*KEY_WIDTH-1:0*DATA_WIDTH] > elems_2_1[2*DATA_WIDTH+KEY_WIDTH-1:2*DATA_WIDTH]) begin
	        /* switch */
	        elems_3_1[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_2_1[3*DATA_WIDTH-1:2*DATA_WIDTH];
	        elems_3_1[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_2_1[1*DATA_WIDTH-1:0*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_3_1[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_2_1[1*DATA_WIDTH-1:0*DATA_WIDTH];
	        elems_3_1[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_2_1[3*DATA_WIDTH-1:2*DATA_WIDTH];
	     end
         
         // CAS(9, 11)
	     if (elems_2_1[1*DATA_WIDTH+KEY_WIDTH-1:1*DATA_WIDTH] > elems_2_1[3*DATA_WIDTH+KEY_WIDTH-1:3*DATA_WIDTH]) begin
	        /* switch */
	        elems_3_1[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_2_1[2*DATA_WIDTH-1:1*DATA_WIDTH];
	        elems_3_1[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_2_1[4*DATA_WIDTH-1:3*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_3_1[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_2_1[4*DATA_WIDTH-1:3*DATA_WIDTH];
	        elems_3_1[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_2_1[2*DATA_WIDTH-1:1*DATA_WIDTH];
	     end         

         // CAS(12, 14)
	     if (elems_2_1[4*DATA_WIDTH+KEY_WIDTH-1:4*DATA_WIDTH] > elems_2_1[6*DATA_WIDTH+KEY_WIDTH-1:6*DATA_WIDTH]) begin
	        /* switch */
	        elems_3_1[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_2_1[7*DATA_WIDTH-1:6*DATA_WIDTH];
	        elems_3_1[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_2_1[5*DATA_WIDTH-1:4*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_3_1[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_2_1[5*DATA_WIDTH-1:4*DATA_WIDTH];
	        elems_3_1[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_2_1[7*DATA_WIDTH-1:6*DATA_WIDTH];
	     end     
             
         // CAS(13, 15)
	     if (elems_2_1[5*DATA_WIDTH+KEY_WIDTH-1:5*DATA_WIDTH] > elems_2_1[7*DATA_WIDTH+KEY_WIDTH-1:7*DATA_WIDTH]) begin
	        /* switch */
	        elems_3_1[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_2_1[6*DATA_WIDTH-1:5*DATA_WIDTH];
	        elems_3_1[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_2_1[8*DATA_WIDTH-1:7*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        elems_3_1[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_2_1[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        elems_3_1[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_2_1[6*DATA_WIDTH-1:5*DATA_WIDTH];
	     end              
      end
   end

   /* step 4 */
   always @(posedge i_clk) begin
      o_stall <= stall_3;
      if (~stall_3) begin
	     o_switch_output <= switch_output_3;
	     o_top_tuple <= top_tuple_3;

         // CAS(0, 1)
	     if (elems_3_0[1*KEY_WIDTH-1:0*DATA_WIDTH] > elems_3_0[1*DATA_WIDTH+KEY_WIDTH-1:1*DATA_WIDTH]) begin
	        /* switch */
	        o_elems_0[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_3_0[2*DATA_WIDTH-1:1*DATA_WIDTH];
	        o_elems_0[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_3_0[1*DATA_WIDTH-1:0*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        o_elems_0[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_3_0[1*DATA_WIDTH-1:0*DATA_WIDTH];
	        o_elems_0[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_3_0[2*DATA_WIDTH-1:1*DATA_WIDTH];
	     end
      
         // CAS(2, 3)
	     if (elems_3_0[2*DATA_WIDTH+KEY_WIDTH-1:2*DATA_WIDTH] > elems_3_0[3*DATA_WIDTH+KEY_WIDTH-1:3*DATA_WIDTH]) begin
	        /* switch */
	        o_elems_0[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_3_0[3*DATA_WIDTH-1:2*DATA_WIDTH];
	        o_elems_0[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_3_0[4*DATA_WIDTH-1:3*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        o_elems_0[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_3_0[4*DATA_WIDTH-1:3*DATA_WIDTH];
	        o_elems_0[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_3_0[3*DATA_WIDTH-1:2*DATA_WIDTH];
	     end         

         // CAS(4, 5)
	     if (elems_3_0[4*DATA_WIDTH+KEY_WIDTH-1:4*DATA_WIDTH] > elems_3_0[5*DATA_WIDTH+KEY_WIDTH-1:5*DATA_WIDTH]) begin
	        /* switch */
	        o_elems_0[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_3_0[5*DATA_WIDTH-1:4*DATA_WIDTH];
	        o_elems_0[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_3_0[6*DATA_WIDTH-1:5*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        o_elems_0[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_3_0[6*DATA_WIDTH-1:5*DATA_WIDTH];
	        o_elems_0[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_3_0[5*DATA_WIDTH-1:4*DATA_WIDTH];
	     end
         
         // CAS(6, 7)
	     if (elems_3_0[6*DATA_WIDTH+KEY_WIDTH-1:6*DATA_WIDTH] > elems_3_0[7*DATA_WIDTH+KEY_WIDTH-1:7*DATA_WIDTH]) begin
	        /* switch */
	        o_elems_0[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_3_0[7*DATA_WIDTH-1:6*DATA_WIDTH];
	        o_elems_0[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_3_0[8*DATA_WIDTH-1:7*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        o_elems_0[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_3_0[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        o_elems_0[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_3_0[7*DATA_WIDTH-1:6*DATA_WIDTH];
	     end

         // CAS(0, 1)
	     if (elems_3_1[1*KEY_WIDTH-1:0*DATA_WIDTH] > elems_3_1[DATA_WIDTH+KEY_WIDTH-1:1*DATA_WIDTH]) begin
	        /* switch */
	        o_elems_1[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_3_1[2*DATA_WIDTH-1:1*DATA_WIDTH];
	        o_elems_1[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_3_1[1*DATA_WIDTH-1:0*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        o_elems_1[1*DATA_WIDTH-1:0*DATA_WIDTH] <= elems_3_1[1*DATA_WIDTH-1:0*DATA_WIDTH];
	        o_elems_1[2*DATA_WIDTH-1:1*DATA_WIDTH] <= elems_3_1[2*DATA_WIDTH-1:1*DATA_WIDTH];
	     end
      
         // CAS(2, 3)
	     if (elems_3_1[2*DATA_WIDTH+KEY_WIDTH-1:2*DATA_WIDTH] > elems_3_1[3*DATA_WIDTH+KEY_WIDTH-1:3*DATA_WIDTH]) begin
	        /* switch */
	        o_elems_1[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_3_1[3*DATA_WIDTH-1:2*DATA_WIDTH];
	        o_elems_1[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_3_1[4*DATA_WIDTH-1:3*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        o_elems_1[4*DATA_WIDTH-1:3*DATA_WIDTH] <= elems_3_1[4*DATA_WIDTH-1:3*DATA_WIDTH];
	        o_elems_1[3*DATA_WIDTH-1:2*DATA_WIDTH] <= elems_3_1[3*DATA_WIDTH-1:2*DATA_WIDTH];
	     end         

         // CAS(4, 5)
	     if (elems_3_1[4*DATA_WIDTH+KEY_WIDTH-1:4*DATA_WIDTH] > elems_3_1[5*DATA_WIDTH+KEY_WIDTH-1:5*DATA_WIDTH]) begin
	        /* switch */
	        o_elems_1[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_3_1[5*DATA_WIDTH-1:4*DATA_WIDTH];
	        o_elems_1[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_3_1[6*DATA_WIDTH-1:5*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        o_elems_1[6*DATA_WIDTH-1:5*DATA_WIDTH] <= elems_3_1[6*DATA_WIDTH-1:5*DATA_WIDTH];
	        o_elems_1[5*DATA_WIDTH-1:4*DATA_WIDTH] <= elems_3_1[5*DATA_WIDTH-1:4*DATA_WIDTH];
	     end
         
         // CAS(6, 7)
	     if (elems_3_1[6*DATA_WIDTH+KEY_WIDTH-1:6*DATA_WIDTH] > elems_3_1[7*DATA_WIDTH+KEY_WIDTH-1:7*DATA_WIDTH]) begin
	        /* switch */
	        o_elems_1[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_3_1[7*DATA_WIDTH-1:6*DATA_WIDTH];
	        o_elems_1[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_3_1[8*DATA_WIDTH-1:7*DATA_WIDTH];
	     end
	     else begin
	        /* stay */
	        o_elems_1[8*DATA_WIDTH-1:7*DATA_WIDTH] <= elems_3_1[8*DATA_WIDTH-1:7*DATA_WIDTH];
	        o_elems_1[7*DATA_WIDTH-1:6*DATA_WIDTH] <= elems_3_1[7*DATA_WIDTH-1:6*DATA_WIDTH];
	     end                 
      end
   end      
endmodule

   


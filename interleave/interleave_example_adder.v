// This is a generated file. Use and modify at your own risk.
////////////////////////////////////////////////////////////////////////////////
// Description: Pipelined adder.  This is an adder with pipelines before and
//   after the adder datapath.  The output is fed into a FIFO and prog_full is
//   used to signal ready.  This design allows for high Fmax.

// default_nettype of none prevents implicit wire declaration.
`default_nettype none
`timescale 1ps / 1ps

module interleave_example_adder #(
  parameter integer C_AXIS_TDATA_WIDTH = 512, // Data width of both input and output data
  parameter integer C_ADDER_BIT_WIDTH  = 32,
  parameter integer C_NUM_CLOCKS       = 1
)
(

  input wire  [C_ADDER_BIT_WIDTH-1:0]   ctrl_constant,

  input wire                             s_axis_aclk,
  input wire                             s_axis_areset,
  input wire                             s_axis_tvalid,
  output wire                            s_axis_tready,
  input wire  [C_AXIS_TDATA_WIDTH-1:0]   s_axis_tdata,
  input wire  [C_AXIS_TDATA_WIDTH/8-1:0] s_axis_tkeep,
  input wire                             s_axis_tlast,

  input wire                             m_axis_aclk,
  output wire                            m_axis_tvalid,
  input  wire                            m_axis_tready,
  output wire [C_AXIS_TDATA_WIDTH-1:0]   m_axis_tdata,
  output wire [C_AXIS_TDATA_WIDTH/8-1:0] m_axis_tkeep,
  output wire                            m_axis_tlast

);

localparam integer LP_NUM_LOOPS = C_AXIS_TDATA_WIDTH/C_ADDER_BIT_WIDTH;
localparam         LP_CLOCKING_MODE = C_NUM_CLOCKS == 1 ? "common_clock" : "independent_clock";
/////////////////////////////////////////////////////////////////////////////
// Variables
/////////////////////////////////////////////////////////////////////////////
reg                              d1_tvalid = 1'b0;
reg                              d1_tready = 1'b0;
reg   [C_AXIS_TDATA_WIDTH-1:0]   d1_tdata;
reg   [C_AXIS_TDATA_WIDTH/8-1:0] d1_tkeep;
reg                              d1_tlast;
reg   [C_ADDER_BIT_WIDTH-1:0]    d1_constant;

integer i;

reg                              d2_tvalid = 1'b0;
reg   [C_AXIS_TDATA_WIDTH-1:0]   d2_tdata;
reg   [C_AXIS_TDATA_WIDTH/8-1:0] d2_tkeep;
reg                              d2_tlast;

wire  [C_AXIS_TDATA_WIDTH/8-1:0] d2_tstrb;
wire  [0:0]                      d2_tid;
wire  [0:0]                      d2_tdest;
wire  [0:0]                      d2_tuser;

wire                             prog_full_axis;
reg                              fifo_ready_r = 1'b0;
/////////////////////////////////////////////////////////////////////////////
// RTL Logic
/////////////////////////////////////////////////////////////////////////////

// Register s_axis_interface/inputs
always @(posedge s_axis_aclk) begin
  d1_tvalid <= s_axis_tvalid;
  d1_tready <= s_axis_tready;
  d1_tdata  <= s_axis_tdata;
  d1_tkeep  <= s_axis_tkeep;
  d1_tlast  <= s_axis_tlast;
  d1_constant <= ctrl_constant;
end

// Adder function
always @(posedge s_axis_aclk) begin
  for (i = 0; i < LP_NUM_LOOPS; i = i + 1) begin
    d2_tdata[i*C_ADDER_BIT_WIDTH+:C_ADDER_BIT_WIDTH] <= d1_tdata[C_ADDER_BIT_WIDTH*i+:C_ADDER_BIT_WIDTH];
  end
end

// Register inputs to fifo
always @(posedge s_axis_aclk) begin
  d2_tvalid <= d1_tvalid & d1_tready;
  d2_tkeep  <= d1_tkeep;
  d2_tlast  <= d1_tlast;
end

// Tie-off unused inputs to FIFO.
assign d2_tstrb = {C_AXIS_TDATA_WIDTH/8{1'b1}};
assign d2_tid   = 1'b0;
assign d2_tdest = 1'b0;
assign d2_tuser = 1'b0;

always @(posedge s_axis_aclk) begin
  fifo_ready_r <= ~prog_full_axis;
end

assign s_axis_tready = fifo_ready_r;

xpm_fifo_axis #(
   .CDC_SYNC_STAGES     ( 2                      ) , // DECIMAL
   .CLOCKING_MODE       ( LP_CLOCKING_MODE       ) , // String
   .ECC_MODE            ( "no_ecc"               ) , // String
   .FIFO_DEPTH          ( 32                     ) , // DECIMAL
   .FIFO_MEMORY_TYPE    ( "distributed"          ) , // String
   .PACKET_FIFO         ( "false"                ) , // String
   .PROG_EMPTY_THRESH   ( 5                      ) , // DECIMAL
   .PROG_FULL_THRESH    ( 32-5                   ) , // DECIMAL
   .RD_DATA_COUNT_WIDTH ( 6                      ) , // DECIMAL
   .RELATED_CLOCKS      ( 0                      ) , // DECIMAL
   .TDATA_WIDTH         ( C_AXIS_TDATA_WIDTH     ) , // DECIMAL
   .TDEST_WIDTH         ( 1                      ) , // DECIMAL
   .TID_WIDTH           ( 1                      ) , // DECIMAL
   .TUSER_WIDTH         ( 1                      ) , // DECIMAL
   .USE_ADV_FEATURES    ( "1002"                 ) , // String: Only use prog_full
   .WR_DATA_COUNT_WIDTH ( 6                      )   // DECIMAL
)
inst_xpm_fifo_axis (
   .s_aclk             ( s_axis_aclk    ) ,
   .s_aresetn          ( ~s_axis_areset ) ,
   .s_axis_tvalid      ( d2_tvalid      ) ,
   .s_axis_tready      (                ) ,
   .s_axis_tdata       ( d2_tdata       ) ,
   .s_axis_tstrb       ( d2_tstrb       ) ,
   .s_axis_tkeep       ( d2_tkeep       ) ,
   .s_axis_tlast       ( d2_tlast       ) ,
   .s_axis_tid         ( d2_tid         ) ,
   .s_axis_tdest       ( d2_tdest       ) ,
   .s_axis_tuser       ( d2_tuser       ) ,
   .almost_full_axis   (                ) ,
   .prog_full_axis     ( prog_full_axis ) ,
   .wr_data_count_axis (                ) ,
   .injectdbiterr_axis ( 1'b0           ) ,
   .injectsbiterr_axis ( 1'b0           ) ,

   .m_aclk             ( m_axis_aclk   ) ,
   .m_axis_tvalid      ( m_axis_tvalid ) ,
   .m_axis_tready      ( m_axis_tready ) ,
   .m_axis_tdata       ( m_axis_tdata  ) ,
   .m_axis_tstrb       (               ) ,
   .m_axis_tkeep       ( m_axis_tkeep  ) ,
   .m_axis_tlast       ( m_axis_tlast  ) ,
   .m_axis_tid         (               ) ,
   .m_axis_tdest       (               ) ,
   .m_axis_tuser       (               ) ,
   .almost_empty_axis  (               ) ,
   .prog_empty_axis    (               ) ,
   .rd_data_count_axis (               ) ,
   .sbiterr_axis       (               ) ,
   .dbiterr_axis       (               )
);

endmodule

`default_nettype wire

// This is a generated file. Use and modify at your own risk.
////////////////////////////////////////////////////////////////////////////////
// Description: Pipelined adder.  This is an adder with pipelines before and
//   after the adder datapath.  The output is fed into a FIFO and prog_full is
//   used to signal ready.  This design allows for high Fmax.

// default_nettype of none prevents implicit wire declaration.
`default_nettype none
`timescale 1ps / 1ps

module interleave_example_adder #(
  parameter integer C_AXIS_TDATA_WIDTH = 512, // Data width of both input and output data
  parameter integer C_ADDER_BIT_WIDTH  = 32,
  parameter integer C_NUM_CLOCKS       = 1
)
(

  input wire  [C_ADDER_BIT_WIDTH-1:0]   ctrl_constant,

  input wire                             s_axis_aclk,
  input wire                             s_axis_areset,
  input wire                             s_axis_tvalid,
  output wire                            s_axis_tready,
  input wire  [C_AXIS_TDATA_WIDTH-1:0]   s_axis_tdata,
  input wire  [C_AXIS_TDATA_WIDTH/8-1:0] s_axis_tkeep,
  input wire                             s_axis_tlast,

  input wire                             m_axis_aclk,
  output wire                            m_axis_tvalid,
  input  wire                            m_axis_tready,
  output wire [C_AXIS_TDATA_WIDTH-1:0]   m_axis_tdata,
  output wire [C_AXIS_TDATA_WIDTH/8-1:0] m_axis_tkeep,
  output wire                            m_axis_tlast

);

localparam integer LP_NUM_LOOPS = C_AXIS_TDATA_WIDTH/C_ADDER_BIT_WIDTH;
localparam         LP_CLOCKING_MODE = C_NUM_CLOCKS == 1 ? "common_clock" : "independent_clock";
/////////////////////////////////////////////////////////////////////////////
// Variables
/////////////////////////////////////////////////////////////////////////////
reg                              d1_tvalid = 1'b0;
reg                              d1_tready = 1'b0;
reg   [C_AXIS_TDATA_WIDTH-1:0]   d1_tdata;
reg   [C_AXIS_TDATA_WIDTH/8-1:0] d1_tkeep;
reg                              d1_tlast;
reg   [C_ADDER_BIT_WIDTH-1:0]    d1_constant;

reg                              d2_tvalid = 1'b0;
reg   [C_AXIS_TDATA_WIDTH-1:0]   d2_tdata;
reg   [C_AXIS_TDATA_WIDTH/8-1:0] d2_tkeep;
reg                              d2_tlast;

wire  [C_AXIS_TDATA_WIDTH/8-1:0] d2_tstrb;
wire  [0:0]                      d2_tid;
wire  [0:0]                      d2_tdest;
wire  [0:0]                      d2_tuser;

wire                             prog_full_axis;
reg                              fifo_ready_r = 1'b0;
/////////////////////////////////////////////////////////////////////////////
// RTL Logic
/////////////////////////////////////////////////////////////////////////////

parameter LEAF_CNT = 8;

reg [32:0] data_counter = 0;
reg [32:0] data_counter_out = 0;
reg [512:0] d2_tdata_out = 0;
reg d2_tvalid_out = 0;
reg [LEAF_CNT-1:0] 	   buffer_enq;
reg [LEAF_CNT-1:0] 	   buffer_deq;
wire [LEAF_CNT-1:0] 	   buffer_empty;
wire [LEAF_CNT-1:0] 	   buffer_full;
wire [LEAF_CNT-1:0] available;
reg [511:0] 		   buffer_in [0:LEAF_CNT-1];   
wire [511:0]        buffer_out [0:LEAF_CNT-1];
// Register s_axis_interface/inputs
always @(posedge s_axis_aclk) begin
  d1_tvalid <= s_axis_tvalid;
  d1_tready <= ~buffer_full[(data_counter%16)/8];
  d1_tdata  <= s_axis_tdata;
  d1_tkeep  <= s_axis_tkeep;
  d1_tlast  <= s_axis_tlast;
  d1_constant <= ctrl_constant;
end

   genvar              fifo_index;
   generate
      for (fifo_index = 0; fifo_index < LEAF_CNT; fifo_index = fifo_index + 1) begin : IN
	 IFIFO32 #(512) buffer(.i_clk(s_axis_aclk),
			               .i_data(buffer_in[fifo_index]),
			               .o_data(buffer_out[fifo_index]),
			               .i_enq(buffer_enq[fifo_index]),
			               .i_deq(buffer_deq[fifo_index]),
			               .o_full(buffer_full[fifo_index]),
                           .o_available(available[fifo_index]),
			               .o_empty(buffer_empty[fifo_index]));
      end // block: IN
   endgenerate


// Adder function
always @(posedge s_axis_aclk) begin
  d2_tdata <= d1_tdata;
  buffer_in[(data_counter/16)%8] <= d2_tdata;
  d2_tdata_out <= buffer_out[data_counter_out%8];
end

integer i, j;
// Register inputs to fifo
always @(posedge s_axis_aclk) begin
  d2_tvalid <= d1_tvalid & d1_tready;
  d2_tvalid_out <= ~buffer_empty[data_counter_out%8] & m_axis_tready & (buffer_out[data_counter_out%8] != 0);
  for (i=0; i<LEAF_CNT; i=i+1) begin
    if (i == data_counter_out%8) begin
        buffer_deq[i] <= ~buffer_empty[i] & m_axis_tready;
    end
    else begin
        buffer_deq[i] <= 0;
    end
  end

  for (j=0; j<LEAF_CNT; j=j+1) begin
    if (j == (data_counter/16)%8) begin
        buffer_enq[j] <= ~buffer_full[j] & d2_tvalid;
    end
    else begin
        buffer_enq[j] <= 0;
    end
  end
  
  data_counter_out <= data_counter_out + (~buffer_empty[data_counter_out%8] & m_axis_tready);
  data_counter <= data_counter + (~buffer_full[(data_counter/16)%8] & d2_tvalid);
  d2_tkeep  <= d1_tkeep;
  d2_tlast  <= d1_tlast;
end

// Tie-off unused inputs to FIFO.
assign d2_tstrb = {C_AXIS_TDATA_WIDTH/8{1'b1}};
assign d2_tid   = 1'b0;
assign d2_tdest = 1'b0;
assign d2_tuser = 1'b0;

always @(posedge s_axis_aclk) begin
  fifo_ready_r <= ~prog_full_axis;
end

assign s_axis_tready = fifo_ready_r;

xpm_fifo_axis #(
   .CDC_SYNC_STAGES     ( 2                      ) , // DECIMAL
   .CLOCKING_MODE       ( LP_CLOCKING_MODE       ) , // String
   .ECC_MODE            ( "no_ecc"               ) , // String
   .FIFO_DEPTH          ( 32                     ) , // DECIMAL
   .FIFO_MEMORY_TYPE    ( "distributed"          ) , // String
   .PACKET_FIFO         ( "false"                ) , // String
   .PROG_EMPTY_THRESH   ( 5                      ) , // DECIMAL
   .PROG_FULL_THRESH    ( 32-5                   ) , // DECIMAL
   .RD_DATA_COUNT_WIDTH ( 6                      ) , // DECIMAL
   .RELATED_CLOCKS      ( 0                      ) , // DECIMAL
   .TDATA_WIDTH         ( C_AXIS_TDATA_WIDTH     ) , // DECIMAL
   .TDEST_WIDTH         ( 1                      ) , // DECIMAL
   .TID_WIDTH           ( 1                      ) , // DECIMAL
   .TUSER_WIDTH         ( 1                      ) , // DECIMAL
   .USE_ADV_FEATURES    ( "1002"                 ) , // String: Only use prog_full
   .WR_DATA_COUNT_WIDTH ( 6                      )   // DECIMAL
)
inst_xpm_fifo_axis (
   .s_aclk             ( s_axis_aclk    ) ,
   .s_aresetn          ( ~s_axis_areset ) ,
   .s_axis_tvalid      ( d2_tvalid_out      ) ,
   .s_axis_tready      (                ) ,
   .s_axis_tdata       ( d2_tdata_out   ) ,
   .s_axis_tstrb       ( d2_tstrb       ) ,
   .s_axis_tkeep       ( d2_tkeep       ) ,
   .s_axis_tlast       ( d2_tlast       ) ,
   .s_axis_tid         ( d2_tid         ) ,
   .s_axis_tdest       ( d2_tdest       ) ,
   .s_axis_tuser       ( d2_tuser       ) ,
   .almost_full_axis   (                ) ,
   .prog_full_axis     ( prog_full_axis ) ,
   .wr_data_count_axis (                ) ,
   .injectdbiterr_axis ( 1'b0           ) ,
   .injectsbiterr_axis ( 1'b0           ) ,

   .m_aclk             ( m_axis_aclk   ) ,
   .m_axis_tvalid      ( m_axis_tvalid ) ,
   .m_axis_tready      ( m_axis_tready ) ,
   .m_axis_tdata       ( m_axis_tdata  ) ,
   .m_axis_tstrb       (               ) ,
   .m_axis_tkeep       ( m_axis_tkeep  ) ,
   .m_axis_tlast       ( m_axis_tlast  ) ,
   .m_axis_tid         (               ) ,
   .m_axis_tdest       (               ) ,
   .m_axis_tuser       (               ) ,
   .almost_empty_axis  (               ) ,
   .prog_empty_axis    (               ) ,
   .rd_data_count_axis (               ) ,
   .sbiterr_axis       (               ) ,
   .dbiterr_axis       (               )
);

endmodule

`default_nettype wire


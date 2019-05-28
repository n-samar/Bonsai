// This is a generated file. Use and modify at your own risk.
//////////////////////////////////////////////////////////////////////////////// 
// default_nettype of none prevents implicit wire declaration.
`default_nettype none
module Top_wrapper #(
  parameter integer C_M00_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M00_AXI_DATA_WIDTH = 512,
  parameter integer C_M01_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M01_AXI_DATA_WIDTH = 512,
  parameter integer C_M02_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M02_AXI_DATA_WIDTH = 512,
  parameter integer C_M03_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M03_AXI_DATA_WIDTH = 512,
  parameter integer C_M04_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M04_AXI_DATA_WIDTH = 512,
  parameter integer C_M05_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M05_AXI_DATA_WIDTH = 512,
  parameter integer C_M06_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M06_AXI_DATA_WIDTH = 512,
  parameter integer C_M07_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M07_AXI_DATA_WIDTH = 512,
  parameter integer C_M08_AXI_ADDR_WIDTH = 64 ,
  parameter integer C_M08_AXI_DATA_WIDTH = 512
)
(
  // System Signals
  input  wire                              ap_clk         ,
  input  wire                              ap_rst_n       ,
  // AXI4 master interface m00_axi
  output wire                              m00_axi_awvalid,
  input  wire                              m00_axi_awready,
  output wire [C_M00_AXI_ADDR_WIDTH-1:0]   m00_axi_awaddr ,
  output wire [8-1:0]                      m00_axi_awlen  ,
  output wire                              m00_axi_wvalid ,
  input  wire                              m00_axi_wready ,
  output wire [C_M00_AXI_DATA_WIDTH-1:0]   m00_axi_wdata  ,
  output wire [C_M00_AXI_DATA_WIDTH/8-1:0] m00_axi_wstrb  ,
  output wire                              m00_axi_wlast  ,
  input  wire                              m00_axi_bvalid ,
  output wire                              m00_axi_bready ,
  output wire                              m00_axi_arvalid,
  input  wire                              m00_axi_arready,
  output wire [C_M00_AXI_ADDR_WIDTH-1:0]   m00_axi_araddr ,
  output wire [8-1:0]                      m00_axi_arlen  ,
  input  wire                              m00_axi_rvalid ,
  output wire                              m00_axi_rready ,
  input  wire [C_M00_AXI_DATA_WIDTH-1:0]   m00_axi_rdata  ,
  input  wire                              m00_axi_rlast  ,
  // AXI4 master interface m01_axi
  output wire                              m01_axi_awvalid,
  input  wire                              m01_axi_awready,
  output wire [C_M01_AXI_ADDR_WIDTH-1:0]   m01_axi_awaddr ,
  output wire [8-1:0]                      m01_axi_awlen  ,
  output wire                              m01_axi_wvalid ,
  input  wire                              m01_axi_wready ,
  output wire [C_M01_AXI_DATA_WIDTH-1:0]   m01_axi_wdata  ,
  output wire [C_M01_AXI_DATA_WIDTH/8-1:0] m01_axi_wstrb  ,
  output wire                              m01_axi_wlast  ,
  input  wire                              m01_axi_bvalid ,
  output wire                              m01_axi_bready ,
  output wire                              m01_axi_arvalid,
  input  wire                              m01_axi_arready,
  output wire [C_M01_AXI_ADDR_WIDTH-1:0]   m01_axi_araddr ,
  output wire [8-1:0]                      m01_axi_arlen  ,
  input  wire                              m01_axi_rvalid ,
  output wire                              m01_axi_rready ,
  input  wire [C_M01_AXI_DATA_WIDTH-1:0]   m01_axi_rdata  ,
  input  wire                              m01_axi_rlast  ,
  // AXI4 master interface m02_axi
  output wire                              m02_axi_awvalid,
  input  wire                              m02_axi_awready,
  output wire [C_M02_AXI_ADDR_WIDTH-1:0]   m02_axi_awaddr ,
  output wire [8-1:0]                      m02_axi_awlen  ,
  output wire                              m02_axi_wvalid ,
  input  wire                              m02_axi_wready ,
  output wire [C_M02_AXI_DATA_WIDTH-1:0]   m02_axi_wdata  ,
  output wire [C_M02_AXI_DATA_WIDTH/8-1:0] m02_axi_wstrb  ,
  output wire                              m02_axi_wlast  ,
  input  wire                              m02_axi_bvalid ,
  output wire                              m02_axi_bready ,
  output wire                              m02_axi_arvalid,
  input  wire                              m02_axi_arready,
  output wire [C_M02_AXI_ADDR_WIDTH-1:0]   m02_axi_araddr ,
  output wire [8-1:0]                      m02_axi_arlen  ,
  input  wire                              m02_axi_rvalid ,
  output wire                              m02_axi_rready ,
  input  wire [C_M02_AXI_DATA_WIDTH-1:0]   m02_axi_rdata  ,
  input  wire                              m02_axi_rlast  ,
  // AXI4 master interface m03_axi
  output wire                              m03_axi_awvalid,
  input  wire                              m03_axi_awready,
  output wire [C_M03_AXI_ADDR_WIDTH-1:0]   m03_axi_awaddr ,
  output wire [8-1:0]                      m03_axi_awlen  ,
  output wire                              m03_axi_wvalid ,
  input  wire                              m03_axi_wready ,
  output wire [C_M03_AXI_DATA_WIDTH-1:0]   m03_axi_wdata  ,
  output wire [C_M03_AXI_DATA_WIDTH/8-1:0] m03_axi_wstrb  ,
  output wire                              m03_axi_wlast  ,
  input  wire                              m03_axi_bvalid ,
  output wire                              m03_axi_bready ,
  output wire                              m03_axi_arvalid,
  input  wire                              m03_axi_arready,
  output wire [C_M03_AXI_ADDR_WIDTH-1:0]   m03_axi_araddr ,
  output wire [8-1:0]                      m03_axi_arlen  ,
  input  wire                              m03_axi_rvalid ,
  output wire                              m03_axi_rready ,
  input  wire [C_M03_AXI_DATA_WIDTH-1:0]   m03_axi_rdata  ,
  input  wire                              m03_axi_rlast  ,
  // AXI4 master interface m04_axi
  output wire                              m04_axi_awvalid,
  input  wire                              m04_axi_awready,
  output wire [C_M04_AXI_ADDR_WIDTH-1:0]   m04_axi_awaddr ,
  output wire [8-1:0]                      m04_axi_awlen  ,
  output wire                              m04_axi_wvalid ,
  input  wire                              m04_axi_wready ,
  output wire [C_M04_AXI_DATA_WIDTH-1:0]   m04_axi_wdata  ,
  output wire [C_M04_AXI_DATA_WIDTH/8-1:0] m04_axi_wstrb  ,
  output wire                              m04_axi_wlast  ,
  input  wire                              m04_axi_bvalid ,
  output wire                              m04_axi_bready ,
  output wire                              m04_axi_arvalid,
  input  wire                              m04_axi_arready,
  output wire [C_M04_AXI_ADDR_WIDTH-1:0]   m04_axi_araddr ,
  output wire [8-1:0]                      m04_axi_arlen  ,
  input  wire                              m04_axi_rvalid ,
  output wire                              m04_axi_rready ,
  input  wire [C_M04_AXI_DATA_WIDTH-1:0]   m04_axi_rdata  ,
  input  wire                              m04_axi_rlast  ,
  // AXI4 master interface m05_axi
  output wire                              m05_axi_awvalid,
  input  wire                              m05_axi_awready,
  output wire [C_M05_AXI_ADDR_WIDTH-1:0]   m05_axi_awaddr ,
  output wire [8-1:0]                      m05_axi_awlen  ,
  output wire                              m05_axi_wvalid ,
  input  wire                              m05_axi_wready ,
  output wire [C_M05_AXI_DATA_WIDTH-1:0]   m05_axi_wdata  ,
  output wire [C_M05_AXI_DATA_WIDTH/8-1:0] m05_axi_wstrb  ,
  output wire                              m05_axi_wlast  ,
  input  wire                              m05_axi_bvalid ,
  output wire                              m05_axi_bready ,
  output wire                              m05_axi_arvalid,
  input  wire                              m05_axi_arready,
  output wire [C_M05_AXI_ADDR_WIDTH-1:0]   m05_axi_araddr ,
  output wire [8-1:0]                      m05_axi_arlen  ,
  input  wire                              m05_axi_rvalid ,
  output wire                              m05_axi_rready ,
  input  wire [C_M05_AXI_DATA_WIDTH-1:0]   m05_axi_rdata  ,
  input  wire                              m05_axi_rlast  ,
  // AXI4 master interface m06_axi
  output wire                              m06_axi_awvalid,
  input  wire                              m06_axi_awready,
  output wire [C_M06_AXI_ADDR_WIDTH-1:0]   m06_axi_awaddr ,
  output wire [8-1:0]                      m06_axi_awlen  ,
  output wire                              m06_axi_wvalid ,
  input  wire                              m06_axi_wready ,
  output wire [C_M06_AXI_DATA_WIDTH-1:0]   m06_axi_wdata  ,
  output wire [C_M06_AXI_DATA_WIDTH/8-1:0] m06_axi_wstrb  ,
  output wire                              m06_axi_wlast  ,
  input  wire                              m06_axi_bvalid ,
  output wire                              m06_axi_bready ,
  output wire                              m06_axi_arvalid,
  input  wire                              m06_axi_arready,
  output wire [C_M06_AXI_ADDR_WIDTH-1:0]   m06_axi_araddr ,
  output wire [8-1:0]                      m06_axi_arlen  ,
  input  wire                              m06_axi_rvalid ,
  output wire                              m06_axi_rready ,
  input  wire [C_M06_AXI_DATA_WIDTH-1:0]   m06_axi_rdata  ,
  input  wire                              m06_axi_rlast  ,
  // AXI4 master interface m07_axi
  output wire                              m07_axi_awvalid,
  input  wire                              m07_axi_awready,
  output wire [C_M07_AXI_ADDR_WIDTH-1:0]   m07_axi_awaddr ,
  output wire [8-1:0]                      m07_axi_awlen  ,
  output wire                              m07_axi_wvalid ,
  input  wire                              m07_axi_wready ,
  output wire [C_M07_AXI_DATA_WIDTH-1:0]   m07_axi_wdata  ,
  output wire [C_M07_AXI_DATA_WIDTH/8-1:0] m07_axi_wstrb  ,
  output wire                              m07_axi_wlast  ,
  input  wire                              m07_axi_bvalid ,
  output wire                              m07_axi_bready ,
  output wire                              m07_axi_arvalid,
  input  wire                              m07_axi_arready,
  output wire [C_M07_AXI_ADDR_WIDTH-1:0]   m07_axi_araddr ,
  output wire [8-1:0]                      m07_axi_arlen  ,
  input  wire                              m07_axi_rvalid ,
  output wire                              m07_axi_rready ,
  input  wire [C_M07_AXI_DATA_WIDTH-1:0]   m07_axi_rdata  ,
  input  wire                              m07_axi_rlast  ,
  // AXI4 master interface m08_axi
  output wire                              m08_axi_awvalid,
  input  wire                              m08_axi_awready,
  output wire [C_M08_AXI_ADDR_WIDTH-1:0]   m08_axi_awaddr ,
  output wire [8-1:0]                      m08_axi_awlen  ,
  output wire                              m08_axi_wvalid ,
  input  wire                              m08_axi_wready ,
  output wire [C_M08_AXI_DATA_WIDTH-1:0]   m08_axi_wdata  ,
  output wire [C_M08_AXI_DATA_WIDTH/8-1:0] m08_axi_wstrb  ,
  output wire                              m08_axi_wlast  ,
  input  wire                              m08_axi_bvalid ,
  output wire                              m08_axi_bready ,
  output wire                              m08_axi_arvalid,
  input  wire                              m08_axi_arready,
  output wire [C_M08_AXI_ADDR_WIDTH-1:0]   m08_axi_araddr ,
  output wire [8-1:0]                      m08_axi_arlen  ,
  input  wire                              m08_axi_rvalid ,
  output wire                              m08_axi_rready ,
  input  wire [C_M08_AXI_DATA_WIDTH-1:0]   m08_axi_rdata  ,
  input  wire                              m08_axi_rlast  ,
  // SDx Control Signals
  input  wire                              ap_start       ,
  output wire                              ap_idle        ,
  output wire                              ap_done        ,
  input  wire                              kernel_rst     ,
  input  wire [32-1:0]                     insize00       ,
  input  wire [32-1:0]                     insize01       ,
  input  wire [32-1:0]                     insize02       ,
  input  wire [32-1:0]                     insize03       ,
  input  wire [32-1:0]                     insize04       ,
  input  wire [32-1:0]                     insize05       ,
  input  wire [32-1:0]                     insize06       ,
  input  wire [32-1:0]                     insize07       ,
  input  wire [64-1:0]                     in0_ptr        ,
  input  wire [64-1:0]                     in1_ptr        ,
  input  wire [64-1:0]                     in2_ptr        ,
  input  wire [64-1:0]                     in3_ptr        ,
  input  wire [64-1:0]                     in4_ptr        ,
  input  wire [64-1:0]                     in5_ptr        ,
  input  wire [64-1:0]                     in6_ptr        ,
  input  wire [64-1:0]                     in7_ptr        ,
  input  wire [64-1:0]                     out_ptr              
);


timeunit 1ps;
timeprecision 1ps;

///////////////////////////////////////////////////////////////////////////////
// Local Parameters
///////////////////////////////////////////////////////////////////////////////
// Large enough for interesting traffic.
localparam integer  LP_DEFAULT_LENGTH_IN_BYTES = 16384;
localparam integer  LP_NUM_EXAMPLES    = 1;

///////////////////////////////////////////////////////////////////////////////
// Wires and Variables
///////////////////////////////////////////////////////////////////////////////
(* KEEP = "yes" *)
logic                                areset                         = 1'b0;
logic                                ap_start_r                     = 1'b0;
logic                                ap_idle_r                      = 1'b1;
logic                                ap_start_pulse                ;
logic [LP_NUM_EXAMPLES-1:0]          ap_done_i                     ;
logic [LP_NUM_EXAMPLES-1:0]          ap_done_r                      = {LP_NUM_EXAMPLES{1'b0}};
logic [32-1:0]                       ctrl_xfer_size_in_bytes        = LP_DEFAULT_LENGTH_IN_BYTES;
//logic [32-1:0]                       ctrl_constant                  = 32'd1;
logic                                rd_tvalid;
logic                                rd_tready;
logic                                rd_tlast;
logic [C_M00_AXI_DATA_WIDTH-1:0]     rd_tdata;

logic [32-1:0]                       outsize;
///////////////////////////////////////////////////////////////////////////////
// Begin RTL
///////////////////////////////////////////////////////////////////////////////
assign outsize = insize00 + insize01 + insize02 + insize03 + insize04 + insize05 + insize06 + insize07 - 32'd1184;

// Register and invert reset signal.
always @(posedge ap_clk) begin
  areset <= ~ap_rst_n;
end

// create pulse when ap_start transitions to 1
always @(posedge ap_clk) begin
  begin
    ap_start_r <= ap_start;
  end
end

assign ap_start_pulse = ap_start & ~ap_start_r;

// ap_idle is asserted when done is asserted, it is de-asserted when ap_start_pulse
// is asserted
always @(posedge ap_clk) begin
  if (areset) begin
    ap_idle_r <= 1'b1;
  end
  else begin
    ap_idle_r <= ap_done ? 1'b1 :
      ap_start_pulse ? 1'b0 : ap_idle;
  end
end

assign ap_idle = ap_idle_r;

// Done logic
always @(posedge ap_clk) begin
  if (areset) begin
    ap_done_r <= '0;
  end
  else begin
    ap_done_r <= (ap_start_pulse | ap_done) ? '0 : ap_done_r | ap_done_i;
  end
end

assign ap_done = &ap_done_r;


// bitonic_sorter_top
MERGER_TREE_P4_L4_TOP #(
  .C_M00_AXI_ADDR_WIDTH ( C_M00_AXI_ADDR_WIDTH ),
  .C_M00_AXI_DATA_WIDTH ( C_M00_AXI_DATA_WIDTH ),
  .C_M01_AXI_ADDR_WIDTH ( C_M01_AXI_ADDR_WIDTH ),
  .C_M01_AXI_DATA_WIDTH ( C_M01_AXI_DATA_WIDTH ),
  .C_M02_AXI_ADDR_WIDTH ( C_M02_AXI_ADDR_WIDTH ),
  .C_M02_AXI_DATA_WIDTH ( C_M02_AXI_DATA_WIDTH ),
  .C_M03_AXI_ADDR_WIDTH ( C_M03_AXI_ADDR_WIDTH ),
  .C_M03_AXI_DATA_WIDTH ( C_M03_AXI_DATA_WIDTH ),
  .C_M04_AXI_ADDR_WIDTH ( C_M04_AXI_ADDR_WIDTH ),
  .C_M04_AXI_DATA_WIDTH ( C_M04_AXI_DATA_WIDTH ),
  .C_M05_AXI_ADDR_WIDTH ( C_M05_AXI_ADDR_WIDTH ),
  .C_M05_AXI_DATA_WIDTH ( C_M05_AXI_DATA_WIDTH ),
  .C_M06_AXI_ADDR_WIDTH ( C_M06_AXI_ADDR_WIDTH ),
  .C_M06_AXI_DATA_WIDTH ( C_M06_AXI_DATA_WIDTH ),
  .C_M07_AXI_ADDR_WIDTH ( C_M07_AXI_ADDR_WIDTH ),
  .C_M07_AXI_DATA_WIDTH ( C_M07_AXI_DATA_WIDTH ),
  .C_M08_AXI_ADDR_WIDTH ( C_M08_AXI_ADDR_WIDTH ),
  .C_M08_AXI_DATA_WIDTH ( C_M08_AXI_DATA_WIDTH ),
  .C_SORTER_BIT_WIDTH   ( 32                   ),
  .C_XFER_SIZE_WIDTH    ( 32                   )
)
MERGER_TREE_P4_L4_TOP_inst0 (
  .aclk                    ( ap_clk                  ),
  .areset                  ( areset                  ),
  .kernel_clk              ( ap_clk                  ),
  .kernel_rst              ( kernel_rst              ),
  .ap_start                ( ap_start_pulse          ),
  .ap_done                 ( ap_done_i               ),
  .ctrl00_addr_offset        ( in0_ptr                 ),
  .ctrl00_xfer_size_in_bytes ( insize00                ),
  .m00_axi_awvalid           ( m00_axi_awvalid         ),
  .m00_axi_awready           ( m00_axi_awready         ),
  .m00_axi_awaddr            ( m00_axi_awaddr          ),
  .m00_axi_awlen             ( m00_axi_awlen           ),
  .m00_axi_wvalid            ( m00_axi_wvalid          ),
  .m00_axi_wready            ( m00_axi_wready          ),
  .m00_axi_wdata             ( m00_axi_wdata           ),
  .m00_axi_wstrb             ( m00_axi_wstrb           ),
  .m00_axi_wlast             ( m00_axi_wlast           ),
  .m00_axi_bvalid            ( m00_axi_bvalid          ),
  .m00_axi_bready            ( m00_axi_bready          ),
  .m00_axi_arvalid           ( m00_axi_arvalid         ),
  .m00_axi_arready           ( m00_axi_arready         ),
  .m00_axi_araddr            ( m00_axi_araddr          ),
  .m00_axi_arlen             ( m00_axi_arlen           ),
  .m00_axi_rvalid            ( m00_axi_rvalid          ),
  .m00_axi_rready            ( m00_axi_rready          ),
  .m00_axi_rdata             ( m00_axi_rdata           ),
  .m00_axi_rlast             ( m00_axi_rlast           ),
  .ctrl01_addr_offset        ( in1_ptr                 ),
  .ctrl01_xfer_size_in_bytes ( insize01                ),
  .m01_axi_awvalid           ( m01_axi_awvalid         ),
  .m01_axi_awready           ( m01_axi_awready         ),
  .m01_axi_awaddr            ( m01_axi_awaddr          ),
  .m01_axi_awlen             ( m01_axi_awlen           ),
  .m01_axi_wvalid            ( m01_axi_wvalid          ),
  .m01_axi_wready            ( m01_axi_wready          ),
  .m01_axi_wdata             ( m01_axi_wdata           ),
  .m01_axi_wstrb             ( m01_axi_wstrb           ),
  .m01_axi_wlast             ( m01_axi_wlast           ),
  .m01_axi_bvalid            ( m01_axi_bvalid          ),
  .m01_axi_bready            ( m01_axi_bready          ),
  .m01_axi_arvalid           ( m01_axi_arvalid         ),
  .m01_axi_arready           ( m01_axi_arready         ),
  .m01_axi_araddr            ( m01_axi_araddr          ),
  .m01_axi_arlen             ( m01_axi_arlen           ),
  .m01_axi_rvalid            ( m01_axi_rvalid          ),
  .m01_axi_rready            ( m01_axi_rready          ),
  .m01_axi_rdata             ( m01_axi_rdata           ),
  .m01_axi_rlast             ( m01_axi_rlast           ),
  .ctrl02_addr_offset        ( in2_ptr                 ),
  .ctrl02_xfer_size_in_bytes ( insize02                ),
  .m02_axi_awvalid           ( m02_axi_awvalid         ),
  .m02_axi_awready           ( m02_axi_awready         ),
  .m02_axi_awaddr            ( m02_axi_awaddr          ),
  .m02_axi_awlen             ( m02_axi_awlen           ),
  .m02_axi_wvalid            ( m02_axi_wvalid          ),
  .m02_axi_wready            ( m02_axi_wready          ),
  .m02_axi_wdata             ( m02_axi_wdata           ),
  .m02_axi_wstrb             ( m02_axi_wstrb           ),
  .m02_axi_wlast             ( m02_axi_wlast           ),
  .m02_axi_bvalid            ( m02_axi_bvalid          ),
  .m02_axi_bready            ( m02_axi_bready          ),
  .m02_axi_arvalid           ( m02_axi_arvalid         ),
  .m02_axi_arready           ( m02_axi_arready         ),
  .m02_axi_araddr            ( m02_axi_araddr          ),
  .m02_axi_arlen             ( m02_axi_arlen           ),
  .m02_axi_rvalid            ( m02_axi_rvalid          ),
  .m02_axi_rready            ( m02_axi_rready          ),
  .m02_axi_rdata             ( m02_axi_rdata           ),
  .m02_axi_rlast             ( m02_axi_rlast           ),
  .ctrl03_addr_offset        ( in3_ptr                 ),
  .ctrl03_xfer_size_in_bytes ( insize03                ),
  .m03_axi_awvalid           ( m03_axi_awvalid         ),
  .m03_axi_awready           ( m03_axi_awready         ),
  .m03_axi_awaddr            ( m03_axi_awaddr          ),
  .m03_axi_awlen             ( m03_axi_awlen           ),
  .m03_axi_wvalid            ( m03_axi_wvalid          ),
  .m03_axi_wready            ( m03_axi_wready          ),
  .m03_axi_wdata             ( m03_axi_wdata           ),
  .m03_axi_wstrb             ( m03_axi_wstrb           ),
  .m03_axi_wlast             ( m03_axi_wlast           ),
  .m03_axi_bvalid            ( m03_axi_bvalid          ),
  .m03_axi_bready            ( m03_axi_bready          ),
  .m03_axi_arvalid           ( m03_axi_arvalid         ),
  .m03_axi_arready           ( m03_axi_arready         ),
  .m03_axi_araddr            ( m03_axi_araddr          ),
  .m03_axi_arlen             ( m03_axi_arlen           ),
  .m03_axi_rvalid            ( m03_axi_rvalid          ),
  .m03_axi_rready            ( m03_axi_rready          ),
  .m03_axi_rdata             ( m03_axi_rdata           ),
  .m03_axi_rlast             ( m03_axi_rlast           ),
  .ctrl04_addr_offset        ( in4_ptr                 ),
  .ctrl04_xfer_size_in_bytes ( insize04                ),
  .m04_axi_awvalid           ( m04_axi_awvalid         ),
  .m04_axi_awready           ( m04_axi_awready         ),
  .m04_axi_awaddr            ( m04_axi_awaddr          ),
  .m04_axi_awlen             ( m04_axi_awlen           ),
  .m04_axi_wvalid            ( m04_axi_wvalid          ),
  .m04_axi_wready            ( m04_axi_wready          ),
  .m04_axi_wdata             ( m04_axi_wdata           ),
  .m04_axi_wstrb             ( m04_axi_wstrb           ),
  .m04_axi_wlast             ( m04_axi_wlast           ),
  .m04_axi_bvalid            ( m04_axi_bvalid          ),
  .m04_axi_bready            ( m04_axi_bready          ),
  .m04_axi_arvalid           ( m04_axi_arvalid         ),
  .m04_axi_arready           ( m04_axi_arready         ),
  .m04_axi_araddr            ( m04_axi_araddr          ),
  .m04_axi_arlen             ( m04_axi_arlen           ),
  .m04_axi_rvalid            ( m04_axi_rvalid          ),
  .m04_axi_rready            ( m04_axi_rready          ),
  .m04_axi_rdata             ( m04_axi_rdata           ),
  .m04_axi_rlast             ( m04_axi_rlast           ),
  .ctrl05_addr_offset        ( in5_ptr                 ),
  .ctrl05_xfer_size_in_bytes ( insize05                ),
  .m05_axi_awvalid           ( m05_axi_awvalid         ),
  .m05_axi_awready           ( m05_axi_awready         ),
  .m05_axi_awaddr            ( m05_axi_awaddr          ),
  .m05_axi_awlen             ( m05_axi_awlen           ),
  .m05_axi_wvalid            ( m05_axi_wvalid          ),
  .m05_axi_wready            ( m05_axi_wready          ),
  .m05_axi_wdata             ( m05_axi_wdata           ),
  .m05_axi_wstrb             ( m05_axi_wstrb           ),
  .m05_axi_wlast             ( m05_axi_wlast           ),
  .m05_axi_bvalid            ( m05_axi_bvalid          ),
  .m05_axi_bready            ( m05_axi_bready          ),
  .m05_axi_arvalid           ( m05_axi_arvalid         ),
  .m05_axi_arready           ( m05_axi_arready         ),
  .m05_axi_araddr            ( m05_axi_araddr          ),
  .m05_axi_arlen             ( m05_axi_arlen           ),
  .m05_axi_rvalid            ( m05_axi_rvalid          ),
  .m05_axi_rready            ( m05_axi_rready          ),
  .m05_axi_rdata             ( m05_axi_rdata           ),
  .m05_axi_rlast             ( m05_axi_rlast           ),
  .ctrl06_addr_offset        ( in6_ptr                 ),
  .ctrl06_xfer_size_in_bytes ( insize06                ),
  .m06_axi_awvalid           ( m06_axi_awvalid         ),
  .m06_axi_awready           ( m06_axi_awready         ),
  .m06_axi_awaddr            ( m06_axi_awaddr          ),
  .m06_axi_awlen             ( m06_axi_awlen           ),
  .m06_axi_wvalid            ( m06_axi_wvalid          ),
  .m06_axi_wready            ( m06_axi_wready          ),
  .m06_axi_wdata             ( m06_axi_wdata           ),
  .m06_axi_wstrb             ( m06_axi_wstrb           ),
  .m06_axi_wlast             ( m06_axi_wlast           ),
  .m06_axi_bvalid            ( m06_axi_bvalid          ),
  .m06_axi_bready            ( m06_axi_bready          ),
  .m06_axi_arvalid           ( m06_axi_arvalid         ),
  .m06_axi_arready           ( m06_axi_arready         ),
  .m06_axi_araddr            ( m06_axi_araddr          ),
  .m06_axi_arlen             ( m06_axi_arlen           ),
  .m06_axi_rvalid            ( m06_axi_rvalid          ),
  .m06_axi_rready            ( m06_axi_rready          ),
  .m06_axi_rdata             ( m06_axi_rdata           ),
  .m06_axi_rlast             ( m06_axi_rlast           ),
  .ctrl07_addr_offset        ( in7_ptr                 ),
  .ctrl07_xfer_size_in_bytes ( insize07                ),
  .m07_axi_awvalid           ( m07_axi_awvalid         ),
  .m07_axi_awready           ( m07_axi_awready         ),
  .m07_axi_awaddr            ( m07_axi_awaddr          ),
  .m07_axi_awlen             ( m07_axi_awlen           ),
  .m07_axi_wvalid            ( m07_axi_wvalid          ),
  .m07_axi_wready            ( m07_axi_wready          ),
  .m07_axi_wdata             ( m07_axi_wdata           ),
  .m07_axi_wstrb             ( m07_axi_wstrb           ),
  .m07_axi_wlast             ( m07_axi_wlast           ),
  .m07_axi_bvalid            ( m07_axi_bvalid          ),
  .m07_axi_bready            ( m07_axi_bready          ),
  .m07_axi_arvalid           ( m07_axi_arvalid         ),
  .m07_axi_arready           ( m07_axi_arready         ),
  .m07_axi_araddr            ( m07_axi_araddr          ),
  .m07_axi_arlen             ( m07_axi_arlen           ),
  .m07_axi_rvalid            ( m07_axi_rvalid          ),
  .m07_axi_rready            ( m07_axi_rready          ),
  .m07_axi_rdata             ( m07_axi_rdata           ),
  .m07_axi_rlast             ( m07_axi_rlast           ),
  .ctrl08_addr_offset        ( out_ptr                 ),
  .ctrl08_xfer_size_in_bytes ( outsize                 ),
  .m08_axi_awvalid           ( m08_axi_awvalid         ),
  .m08_axi_awready           ( m08_axi_awready         ),
  .m08_axi_awaddr            ( m08_axi_awaddr          ),
  .m08_axi_awlen             ( m08_axi_awlen           ),
  .m08_axi_wvalid            ( m08_axi_wvalid          ),
  .m08_axi_wready            ( m08_axi_wready          ),
  .m08_axi_wdata             ( m08_axi_wdata           ),
  .m08_axi_wstrb             ( m08_axi_wstrb           ),
  .m08_axi_wlast             ( m08_axi_wlast           ),
  .m08_axi_bvalid            ( m08_axi_bvalid          ),
  .m08_axi_bready            ( m08_axi_bready          ),
  .m08_axi_arvalid           ( m08_axi_arvalid         ),
  .m08_axi_arready           ( m08_axi_arready         ),
  .m08_axi_araddr            ( m08_axi_araddr          ),
  .m08_axi_arlen             ( m08_axi_arlen           ),
  .m08_axi_rvalid            ( m08_axi_rvalid          ),
  .m08_axi_rready            ( m08_axi_rready          ),
  .m08_axi_rdata             ( m08_axi_rdata           ),
  .m08_axi_rlast             ( m08_axi_rlast           )
);

endmodule : Top_wrapper
`default_nettype wire

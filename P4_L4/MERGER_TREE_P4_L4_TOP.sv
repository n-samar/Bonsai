// This is a generated file. Use and modify at your own risk.
////////////////////////////////////////////////////////////////////////////////
// default_nettype of none prevents implicit wire declaration.
`default_nettype none

module MERGER_TREE_P4_L4_TOP #(
  parameter integer C_M00_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M00_AXI_DATA_WIDTH       = 512,
  parameter integer C_M01_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M01_AXI_DATA_WIDTH       = 512,
  parameter integer C_M02_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M02_AXI_DATA_WIDTH       = 512,
  parameter integer C_M03_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M03_AXI_DATA_WIDTH       = 512,
  parameter integer C_M04_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M04_AXI_DATA_WIDTH       = 512,
  parameter integer C_M05_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M05_AXI_DATA_WIDTH       = 512,
  parameter integer C_M06_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M06_AXI_DATA_WIDTH       = 512,
  parameter integer C_M07_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M07_AXI_DATA_WIDTH       = 512,
  parameter integer C_M08_AXI_ADDR_WIDTH       = 64 ,
  parameter integer C_M08_AXI_DATA_WIDTH       = 512,
  parameter integer C_XFER_SIZE_WIDTH        = 32,
  parameter integer C_SORTER_BIT_WIDTH        = 32
)
(
  // System Signals
  input wire                                    aclk               ,
  input wire                                    areset             ,
  // Extra clocks
  input wire                                    kernel_clk         ,
  input wire                                    kernel_rst         ,
  // Engine signal
  input wire                                    ap_start           ,
  output wire                                   ap_done            ,
  // AXI4 master interface 00
  input wire [C_M00_AXI_ADDR_WIDTH-1:0]         ctrl00_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl00_xfer_size_in_bytes,
  output wire                                   m00_axi_awvalid      ,
  input wire                                    m00_axi_awready      ,
  output wire [C_M00_AXI_ADDR_WIDTH-1:0]        m00_axi_awaddr       ,
  output wire [8-1:0]                           m00_axi_awlen        ,
  output wire                                   m00_axi_wvalid       ,
  input wire                                    m00_axi_wready       ,
  output wire [C_M00_AXI_DATA_WIDTH-1:0]        m00_axi_wdata        ,
  output wire [C_M00_AXI_DATA_WIDTH/8-1:0]      m00_axi_wstrb        ,
  output wire                                   m00_axi_wlast        ,
  output wire                                   m00_axi_arvalid      ,
  input wire                                    m00_axi_arready      ,
  output wire [C_M00_AXI_ADDR_WIDTH-1:0]        m00_axi_araddr       ,
  output wire [8-1:0]                           m00_axi_arlen        ,
  input wire                                    m00_axi_rvalid       ,
  output wire                                   m00_axi_rready       ,
  input wire [C_M00_AXI_DATA_WIDTH-1:0]         m00_axi_rdata        ,
  input wire                                    m00_axi_rlast        ,
  input wire                                    m00_axi_bvalid       ,
  output wire                                   m00_axi_bready       ,
  // AXI4 master interface 01
  input wire [C_M01_AXI_ADDR_WIDTH-1:0]         ctrl01_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl01_xfer_size_in_bytes,
  output wire                                   m01_axi_awvalid      ,
  input wire                                    m01_axi_awready      ,
  output wire [C_M01_AXI_ADDR_WIDTH-1:0]        m01_axi_awaddr       ,
  output wire [8-1:0]                           m01_axi_awlen        ,
  output wire                                   m01_axi_wvalid       ,
  input wire                                    m01_axi_wready       ,
  output wire [C_M01_AXI_DATA_WIDTH-1:0]        m01_axi_wdata        ,
  output wire [C_M01_AXI_DATA_WIDTH/8-1:0]      m01_axi_wstrb        ,
  output wire                                   m01_axi_wlast        ,
  output wire                                   m01_axi_arvalid      ,
  input wire                                    m01_axi_arready      ,
  output wire [C_M01_AXI_ADDR_WIDTH-1:0]        m01_axi_araddr       ,
  output wire [8-1:0]                           m01_axi_arlen        ,
  input wire                                    m01_axi_rvalid       ,
  output wire                                   m01_axi_rready       ,
  input wire [C_M01_AXI_DATA_WIDTH-1:0]         m01_axi_rdata        ,
  input wire                                    m01_axi_rlast        ,
  input wire                                    m01_axi_bvalid       ,
  output wire                                   m01_axi_bready       ,
  // AXI4 master interface 02
  input wire [C_M02_AXI_ADDR_WIDTH-1:0]         ctrl02_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl02_xfer_size_in_bytes,
  output wire                                   m02_axi_awvalid      ,
  input wire                                    m02_axi_awready      ,
  output wire [C_M02_AXI_ADDR_WIDTH-1:0]        m02_axi_awaddr       ,
  output wire [8-1:0]                           m02_axi_awlen        ,
  output wire                                   m02_axi_wvalid       ,
  input wire                                    m02_axi_wready       ,
  output wire [C_M02_AXI_DATA_WIDTH-1:0]        m02_axi_wdata        ,
  output wire [C_M02_AXI_DATA_WIDTH/8-1:0]      m02_axi_wstrb        ,
  output wire                                   m02_axi_wlast        ,
  output wire                                   m02_axi_arvalid      ,
  input wire                                    m02_axi_arready      ,
  output wire [C_M02_AXI_ADDR_WIDTH-1:0]        m02_axi_araddr       ,
  output wire [8-1:0]                           m02_axi_arlen        ,
  input wire                                    m02_axi_rvalid       ,
  output wire                                   m02_axi_rready       ,
  input wire [C_M02_AXI_DATA_WIDTH-1:0]         m02_axi_rdata        ,
  input wire                                    m02_axi_rlast        ,
  input wire                                    m02_axi_bvalid       ,
  output wire                                   m02_axi_bready       ,
  // AXI4 master interface 03
  input wire [C_M03_AXI_ADDR_WIDTH-1:0]         ctrl03_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl03_xfer_size_in_bytes,
  output wire                                   m03_axi_awvalid      ,
  input wire                                    m03_axi_awready      ,
  output wire [C_M03_AXI_ADDR_WIDTH-1:0]        m03_axi_awaddr       ,
  output wire [8-1:0]                           m03_axi_awlen        ,
  output wire                                   m03_axi_wvalid       ,
  input wire                                    m03_axi_wready       ,
  output wire [C_M03_AXI_DATA_WIDTH-1:0]        m03_axi_wdata        ,
  output wire [C_M03_AXI_DATA_WIDTH/8-1:0]      m03_axi_wstrb        ,
  output wire                                   m03_axi_wlast        ,
  output wire                                   m03_axi_arvalid      ,
  input wire                                    m03_axi_arready      ,
  output wire [C_M03_AXI_ADDR_WIDTH-1:0]        m03_axi_araddr       ,
  output wire [8-1:0]                           m03_axi_arlen        ,
  input wire                                    m03_axi_rvalid       ,
  output wire                                   m03_axi_rready       ,
  input wire [C_M03_AXI_DATA_WIDTH-1:0]         m03_axi_rdata        ,
  input wire                                    m03_axi_rlast        ,
  input wire                                    m03_axi_bvalid       ,
  output wire                                   m03_axi_bready       ,
  // AXI4 master interface 04
  input wire [C_M04_AXI_ADDR_WIDTH-1:0]         ctrl04_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl04_xfer_size_in_bytes,
  output wire                                   m04_axi_awvalid      ,
  input wire                                    m04_axi_awready      ,
  output wire [C_M04_AXI_ADDR_WIDTH-1:0]        m04_axi_awaddr       ,
  output wire [8-1:0]                           m04_axi_awlen        ,
  output wire                                   m04_axi_wvalid       ,
  input wire                                    m04_axi_wready       ,
  output wire [C_M04_AXI_DATA_WIDTH-1:0]        m04_axi_wdata        ,
  output wire [C_M04_AXI_DATA_WIDTH/8-1:0]      m04_axi_wstrb        ,
  output wire                                   m04_axi_wlast        ,
  output wire                                   m04_axi_arvalid      ,
  input wire                                    m04_axi_arready      ,
  output wire [C_M04_AXI_ADDR_WIDTH-1:0]        m04_axi_araddr       ,
  output wire [8-1:0]                           m04_axi_arlen        ,
  input wire                                    m04_axi_rvalid       ,
  output wire                                   m04_axi_rready       ,
  input wire [C_M04_AXI_DATA_WIDTH-1:0]         m04_axi_rdata        ,
  input wire                                    m04_axi_rlast        ,
  input wire                                    m04_axi_bvalid       ,
  output wire                                   m04_axi_bready       ,
  // AXI4 master interface 05
  input wire [C_M05_AXI_ADDR_WIDTH-1:0]         ctrl05_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl05_xfer_size_in_bytes,
  output wire                                   m05_axi_awvalid      ,
  input wire                                    m05_axi_awready      ,
  output wire [C_M05_AXI_ADDR_WIDTH-1:0]        m05_axi_awaddr       ,
  output wire [8-1:0]                           m05_axi_awlen        ,
  output wire                                   m05_axi_wvalid       ,
  input wire                                    m05_axi_wready       ,
  output wire [C_M05_AXI_DATA_WIDTH-1:0]        m05_axi_wdata        ,
  output wire [C_M05_AXI_DATA_WIDTH/8-1:0]      m05_axi_wstrb        ,
  output wire                                   m05_axi_wlast        ,
  output wire                                   m05_axi_arvalid      ,
  input wire                                    m05_axi_arready      ,
  output wire [C_M05_AXI_ADDR_WIDTH-1:0]        m05_axi_araddr       ,
  output wire [8-1:0]                           m05_axi_arlen        ,
  input wire                                    m05_axi_rvalid       ,
  output wire                                   m05_axi_rready       ,
  input wire [C_M05_AXI_DATA_WIDTH-1:0]         m05_axi_rdata        ,
  input wire                                    m05_axi_rlast        ,
  input wire                                    m05_axi_bvalid       ,
  output wire                                   m05_axi_bready       ,
  // AXI4 master interface 06
  input wire [C_M06_AXI_ADDR_WIDTH-1:0]         ctrl06_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl06_xfer_size_in_bytes,
  output wire                                   m06_axi_awvalid      ,
  input wire                                    m06_axi_awready      ,
  output wire [C_M06_AXI_ADDR_WIDTH-1:0]        m06_axi_awaddr       ,
  output wire [8-1:0]                           m06_axi_awlen        ,
  output wire                                   m06_axi_wvalid       ,
  input wire                                    m06_axi_wready       ,
  output wire [C_M06_AXI_DATA_WIDTH-1:0]        m06_axi_wdata        ,
  output wire [C_M06_AXI_DATA_WIDTH/8-1:0]      m06_axi_wstrb        ,
  output wire                                   m06_axi_wlast        ,
  output wire                                   m06_axi_arvalid      ,
  input wire                                    m06_axi_arready      ,
  output wire [C_M06_AXI_ADDR_WIDTH-1:0]        m06_axi_araddr       ,
  output wire [8-1:0]                           m06_axi_arlen        ,
  input wire                                    m06_axi_rvalid       ,
  output wire                                   m06_axi_rready       ,
  input wire [C_M06_AXI_DATA_WIDTH-1:0]         m06_axi_rdata        ,
  input wire                                    m06_axi_rlast        ,
  input wire                                    m06_axi_bvalid       ,
  output wire                                   m06_axi_bready       ,
  // AXI4 master interface 07
  input wire [C_M07_AXI_ADDR_WIDTH-1:0]         ctrl07_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl07_xfer_size_in_bytes,
  output wire                                   m07_axi_awvalid      ,
  input wire                                    m07_axi_awready      ,
  output wire [C_M07_AXI_ADDR_WIDTH-1:0]        m07_axi_awaddr       ,
  output wire [8-1:0]                           m07_axi_awlen        ,
  output wire                                   m07_axi_wvalid       ,
  input wire                                    m07_axi_wready       ,
  output wire [C_M07_AXI_DATA_WIDTH-1:0]        m07_axi_wdata        ,
  output wire [C_M07_AXI_DATA_WIDTH/8-1:0]      m07_axi_wstrb        ,
  output wire                                   m07_axi_wlast        ,
  output wire                                   m07_axi_arvalid      ,
  input wire                                    m07_axi_arready      ,
  output wire [C_M07_AXI_ADDR_WIDTH-1:0]        m07_axi_araddr       ,
  output wire [8-1:0]                           m07_axi_arlen        ,
  input wire                                    m07_axi_rvalid       ,
  output wire                                   m07_axi_rready       ,
  input wire [C_M07_AXI_DATA_WIDTH-1:0]         m07_axi_rdata        ,
  input wire                                    m07_axi_rlast        ,
  input wire                                    m07_axi_bvalid       ,
  output wire                                   m07_axi_bready       ,
  // AXI4 master interface 08
  input wire [C_M08_AXI_ADDR_WIDTH-1:0]         ctrl08_addr_offset   ,
  input wire [C_XFER_SIZE_WIDTH-1:0]            ctrl08_xfer_size_in_bytes,
  output wire                                   m08_axi_awvalid      ,
  input wire                                    m08_axi_awready      ,
  output wire [C_M08_AXI_ADDR_WIDTH-1:0]        m08_axi_awaddr       ,
  output wire [8-1:0]                           m08_axi_awlen        ,
  output wire                                   m08_axi_wvalid       ,
  input wire                                    m08_axi_wready       ,
  output wire [C_M08_AXI_DATA_WIDTH-1:0]        m08_axi_wdata        ,
  output wire [C_M08_AXI_DATA_WIDTH/8-1:0]      m08_axi_wstrb        ,
  output wire                                   m08_axi_wlast        ,
  output wire                                   m08_axi_arvalid      ,
  input wire                                    m08_axi_arready      ,
  output wire [C_M08_AXI_ADDR_WIDTH-1:0]        m08_axi_araddr       ,
  output wire [8-1:0]                           m08_axi_arlen        ,
  input wire                                    m08_axi_rvalid       ,
  output wire                                   m08_axi_rready       ,
  input wire [C_M08_AXI_DATA_WIDTH-1:0]         m08_axi_rdata        ,
  input wire                                    m08_axi_rlast        ,
  input wire                                    m08_axi_bvalid       ,
  output wire                                   m08_axi_bready       
);

timeunit 1ps;
timeprecision 1ps;


///////////////////////////////////////////////////////////////////////////////
// Local Parameters
///////////////////////////////////////////////////////////////////////////////
localparam integer LP_DW_BYTES_00             = C_M00_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_00        = 4096/LP_DW_BYTES_00 < 256 ? 4096/LP_DW_BYTES_00 : 256;
localparam integer LP_LOG_BURST_LEN_00        = $clog2(LP_AXI_BURST_LEN_00);
localparam integer LP_BRAM_DEPTH_00           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_00   = LP_BRAM_DEPTH_00 / LP_AXI_BURST_LEN_00;

localparam integer LP_DW_BYTES_01             = C_M01_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_01        = 4096/LP_DW_BYTES_01 < 256 ? 4096/LP_DW_BYTES_01 : 256;
localparam integer LP_LOG_BURST_LEN_01        = $clog2(LP_AXI_BURST_LEN_01);
localparam integer LP_BRAM_DEPTH_01           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_01   = LP_BRAM_DEPTH_01 / LP_AXI_BURST_LEN_01;

localparam integer LP_DW_BYTES_02             = C_M02_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_02        = 4096/LP_DW_BYTES_02 < 256 ? 4096/LP_DW_BYTES_02 : 256;
localparam integer LP_LOG_BURST_LEN_02        = $clog2(LP_AXI_BURST_LEN_02);
localparam integer LP_BRAM_DEPTH_02           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_02   = LP_BRAM_DEPTH_02 / LP_AXI_BURST_LEN_02;

localparam integer LP_DW_BYTES_03             = C_M03_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_03        = 4096/LP_DW_BYTES_03 < 256 ? 4096/LP_DW_BYTES_03 : 256;
localparam integer LP_LOG_BURST_LEN_03        = $clog2(LP_AXI_BURST_LEN_03);
localparam integer LP_BRAM_DEPTH_03           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_03   = LP_BRAM_DEPTH_03 / LP_AXI_BURST_LEN_03;

localparam integer LP_DW_BYTES_04             = C_M04_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_04        = 4096/LP_DW_BYTES_04 < 256 ? 4096/LP_DW_BYTES_04 : 256;
localparam integer LP_LOG_BURST_LEN_04        = $clog2(LP_AXI_BURST_LEN_04);
localparam integer LP_BRAM_DEPTH_04           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_04   = LP_BRAM_DEPTH_04 / LP_AXI_BURST_LEN_04;

localparam integer LP_DW_BYTES_05             = C_M05_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_05        = 4096/LP_DW_BYTES_05 < 256 ? 4096/LP_DW_BYTES_05 : 256;
localparam integer LP_LOG_BURST_LEN_05        = $clog2(LP_AXI_BURST_LEN_05);
localparam integer LP_BRAM_DEPTH_05           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_05   = LP_BRAM_DEPTH_05 / LP_AXI_BURST_LEN_05;

localparam integer LP_DW_BYTES_06             = C_M06_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_06        = 4096/LP_DW_BYTES_06 < 256 ? 4096/LP_DW_BYTES_06 : 256;
localparam integer LP_LOG_BURST_LEN_06        = $clog2(LP_AXI_BURST_LEN_06);
localparam integer LP_BRAM_DEPTH_06           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_06   = LP_BRAM_DEPTH_06 / LP_AXI_BURST_LEN_06;

localparam integer LP_DW_BYTES_07             = C_M07_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_07        = 4096/LP_DW_BYTES_07 < 256 ? 4096/LP_DW_BYTES_07 : 256;
localparam integer LP_LOG_BURST_LEN_07        = $clog2(LP_AXI_BURST_LEN_07);
localparam integer LP_BRAM_DEPTH_07           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_07   = LP_BRAM_DEPTH_07 / LP_AXI_BURST_LEN_07;

localparam integer LP_DW_BYTES_08             = C_M08_AXI_DATA_WIDTH/8;
localparam integer LP_AXI_BURST_LEN_08        = 4096/LP_DW_BYTES_08 < 256 ? 4096/LP_DW_BYTES_08 : 256;
localparam integer LP_LOG_BURST_LEN_08        = $clog2(LP_AXI_BURST_LEN_08);
localparam integer LP_BRAM_DEPTH_08           = 512;
localparam integer LP_RD_MAX_OUTSTANDING_08   = LP_BRAM_DEPTH_08 / LP_AXI_BURST_LEN_08;

localparam integer LP_WR_MAX_OUTSTANDING_08   = 32;

///////////////////////////////////////////////////////////////////////////////
// Wires and Variables
///////////////////////////////////////////////////////////////////////////////

// Control logic
logic                          done = 1'b0;
// AXI read master 00 stage
logic                          read_done_00;
logic                          rd_tvalid_00;
logic                          rd_tready_00;
logic                          rd_tlast_00;
logic [C_M00_AXI_DATA_WIDTH-1:0] rd_tdata_00;
// AXI read master 01 stage
logic                          read_done_01;
logic                          rd_tvalid_01;
logic                          rd_tready_01;
logic                          rd_tlast_01;
logic [C_M01_AXI_DATA_WIDTH-1:0] rd_tdata_01;
// AXI read master 02 stage
logic                          read_done_02;
logic                          rd_tvalid_02;
logic                          rd_tready_02;
logic                          rd_tlast_02;
logic [C_M02_AXI_DATA_WIDTH-1:0] rd_tdata_02;
// AXI read master 03 stage
logic                          read_done_03;
logic                          rd_tvalid_03;
logic                          rd_tready_03;
logic                          rd_tlast_03;
logic [C_M03_AXI_DATA_WIDTH-1:0] rd_tdata_03;
// AXI read master 04 stage
logic                          read_done_04;
logic                          rd_tvalid_04;
logic                          rd_tready_04;
logic                          rd_tlast_04;
logic [C_M04_AXI_DATA_WIDTH-1:0] rd_tdata_04;
// AXI read master 05 stage
logic                          read_done_05;
logic                          rd_tvalid_05;
logic                          rd_tready_05;
logic                          rd_tlast_05;
logic [C_M05_AXI_DATA_WIDTH-1:0] rd_tdata_05;
// AXI read master 06 stage
logic                          read_done_06;
logic                          rd_tvalid_06;
logic                          rd_tready_06;
logic                          rd_tlast_06;
logic [C_M06_AXI_DATA_WIDTH-1:0] rd_tdata_06;
// AXI read master 07 stage
logic                          read_done_07;
logic                          rd_tvalid_07;
logic                          rd_tready_07;
logic                          rd_tlast_07;
logic [C_M07_AXI_DATA_WIDTH-1:0] rd_tdata_07;

// AXI write master 08 stage
logic                           merger_out_tvalid;
logic                           merger_out_tready;
logic [C_M08_AXI_DATA_WIDTH-1:0]    merger_out_tdata;


///////////////////////////////////////////////////////////////////////////////
// Begin RTL
///////////////////////////////////////////////////////////////////////////////
// AXI4 Read Master00, output format is an AXI4-Stream master, one stream per thread.
axi_read_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M00_AXI_ADDR_WIDTH       ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M00_AXI_DATA_WIDTH       ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH          ) ,
  .C_MAX_OUTSTANDING   ( LP_RD_MAX_OUTSTANDING_00   ) ,
  .C_INCLUDE_DATA_FIFO ( 1                          )
)
AXI_Read_inst00 (
  .aclk                    ( aclk                       ) ,
  .areset                  ( areset                     ) ,
  .ctrl_start              ( ap_start                   ) ,
  .ctrl_done               ( read_done_00               ) ,
  .ctrl_addr_offset        ( ctrl00_addr_offset         ) ,
  .ctrl_xfer_size_in_bytes ( ctrl00_xfer_size_in_bytes  ) ,
  .m_axi_arvalid           ( m00_axi_arvalid            ) ,
  .m_axi_arready           ( m00_axi_arready            ) ,
  .m_axi_araddr            ( m00_axi_araddr             ) ,
  .m_axi_arlen             ( m00_axi_arlen              ) ,
  .m_axi_rvalid            ( m00_axi_rvalid             ) ,
  .m_axi_rready            ( m00_axi_rready             ) ,
  .m_axi_rdata             ( m00_axi_rdata              ) ,
  .m_axi_rlast             ( m00_axi_rlast              ) ,
  .m_axis_aclk             ( kernel_clk                 ) ,
  .m_axis_areset           ( kernel_rst                 ) ,
  .m_axis_tvalid           ( rd_tvalid_00               ) ,
  .m_axis_tready           ( rd_tready_00               ) ,
  .m_axis_tlast            ( rd_tlast_00                ) ,
  .m_axis_tdata            ( rd_tdata_00                )
);
// AXI4 Read Master01, output format is an AXI4-Stream master, one stream per thread.
axi_read_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M01_AXI_ADDR_WIDTH       ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M01_AXI_DATA_WIDTH       ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH          ) ,
  .C_MAX_OUTSTANDING   ( LP_RD_MAX_OUTSTANDING_01   ) ,
  .C_INCLUDE_DATA_FIFO ( 1                          )
)
AXI_Read_inst01 (
  .aclk                    ( aclk                       ) ,
  .areset                  ( areset                     ) ,
  .ctrl_start              ( ap_start                   ) ,
  .ctrl_done               ( read_done_01               ) ,
  .ctrl_addr_offset        ( ctrl01_addr_offset         ) ,
  .ctrl_xfer_size_in_bytes ( ctrl01_xfer_size_in_bytes  ) ,
  .m_axi_arvalid           ( m01_axi_arvalid            ) ,
  .m_axi_arready           ( m01_axi_arready            ) ,
  .m_axi_araddr            ( m01_axi_araddr             ) ,
  .m_axi_arlen             ( m01_axi_arlen              ) ,
  .m_axi_rvalid            ( m01_axi_rvalid             ) ,
  .m_axi_rready            ( m01_axi_rready             ) ,
  .m_axi_rdata             ( m01_axi_rdata              ) ,
  .m_axi_rlast             ( m01_axi_rlast              ) ,
  .m_axis_aclk             ( kernel_clk                 ) ,
  .m_axis_areset           ( kernel_rst                 ) ,
  .m_axis_tvalid           ( rd_tvalid_01               ) ,
  .m_axis_tready           ( rd_tready_01               ) ,
  .m_axis_tlast            ( rd_tlast_01                ) ,
  .m_axis_tdata            ( rd_tdata_01                )
);
// AXI4 Read Master02, output format is an AXI4-Stream master, one stream per thread.
axi_read_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M02_AXI_ADDR_WIDTH       ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M02_AXI_DATA_WIDTH       ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH          ) ,
  .C_MAX_OUTSTANDING   ( LP_RD_MAX_OUTSTANDING_02   ) ,
  .C_INCLUDE_DATA_FIFO ( 1                          )
)
AXI_Read_inst02 (
  .aclk                    ( aclk                       ) ,
  .areset                  ( areset                     ) ,
  .ctrl_start              ( ap_start                   ) ,
  .ctrl_done               ( read_done_02               ) ,
  .ctrl_addr_offset        ( ctrl02_addr_offset         ) ,
  .ctrl_xfer_size_in_bytes ( ctrl02_xfer_size_in_bytes  ) ,
  .m_axi_arvalid           ( m02_axi_arvalid            ) ,
  .m_axi_arready           ( m02_axi_arready            ) ,
  .m_axi_araddr            ( m02_axi_araddr             ) ,
  .m_axi_arlen             ( m02_axi_arlen              ) ,
  .m_axi_rvalid            ( m02_axi_rvalid             ) ,
  .m_axi_rready            ( m02_axi_rready             ) ,
  .m_axi_rdata             ( m02_axi_rdata              ) ,
  .m_axi_rlast             ( m02_axi_rlast              ) ,
  .m_axis_aclk             ( kernel_clk                 ) ,
  .m_axis_areset           ( kernel_rst                 ) ,
  .m_axis_tvalid           ( rd_tvalid_02               ) ,
  .m_axis_tready           ( rd_tready_02               ) ,
  .m_axis_tlast            ( rd_tlast_02                ) ,
  .m_axis_tdata            ( rd_tdata_02                )
);
// AXI4 Read Master03, output format is an AXI4-Stream master, one stream per thread.
axi_read_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M03_AXI_ADDR_WIDTH       ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M03_AXI_DATA_WIDTH       ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH          ) ,
  .C_MAX_OUTSTANDING   ( LP_RD_MAX_OUTSTANDING_03   ) ,
  .C_INCLUDE_DATA_FIFO ( 1                          )
)
AXI_Read_inst03 (
  .aclk                    ( aclk                       ) ,
  .areset                  ( areset                     ) ,
  .ctrl_start              ( ap_start                   ) ,
  .ctrl_done               ( read_done_03               ) ,
  .ctrl_addr_offset        ( ctrl03_addr_offset         ) ,
  .ctrl_xfer_size_in_bytes ( ctrl03_xfer_size_in_bytes  ) ,
  .m_axi_arvalid           ( m03_axi_arvalid            ) ,
  .m_axi_arready           ( m03_axi_arready            ) ,
  .m_axi_araddr            ( m03_axi_araddr             ) ,
  .m_axi_arlen             ( m03_axi_arlen              ) ,
  .m_axi_rvalid            ( m03_axi_rvalid             ) ,
  .m_axi_rready            ( m03_axi_rready             ) ,
  .m_axi_rdata             ( m03_axi_rdata              ) ,
  .m_axi_rlast             ( m03_axi_rlast              ) ,
  .m_axis_aclk             ( kernel_clk                 ) ,
  .m_axis_areset           ( kernel_rst                 ) ,
  .m_axis_tvalid           ( rd_tvalid_03               ) ,
  .m_axis_tready           ( rd_tready_03               ) ,
  .m_axis_tlast            ( rd_tlast_03                ) ,
  .m_axis_tdata            ( rd_tdata_03                )
);
// AXI4 Read Master04, output format is an AXI4-Stream master, one stream per thread.
axi_read_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M04_AXI_ADDR_WIDTH       ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M04_AXI_DATA_WIDTH       ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH          ) ,
  .C_MAX_OUTSTANDING   ( LP_RD_MAX_OUTSTANDING_04   ) ,
  .C_INCLUDE_DATA_FIFO ( 1                          )
)
AXI_Read_inst04 (
  .aclk                    ( aclk                       ) ,
  .areset                  ( areset                     ) ,
  .ctrl_start              ( ap_start                   ) ,
  .ctrl_done               ( read_done_04               ) ,
  .ctrl_addr_offset        ( ctrl04_addr_offset         ) ,
  .ctrl_xfer_size_in_bytes ( ctrl04_xfer_size_in_bytes  ) ,
  .m_axi_arvalid           ( m04_axi_arvalid            ) ,
  .m_axi_arready           ( m04_axi_arready            ) ,
  .m_axi_araddr            ( m04_axi_araddr             ) ,
  .m_axi_arlen             ( m04_axi_arlen              ) ,
  .m_axi_rvalid            ( m04_axi_rvalid             ) ,
  .m_axi_rready            ( m04_axi_rready             ) ,
  .m_axi_rdata             ( m04_axi_rdata              ) ,
  .m_axi_rlast             ( m04_axi_rlast              ) ,
  .m_axis_aclk             ( kernel_clk                 ) ,
  .m_axis_areset           ( kernel_rst                 ) ,
  .m_axis_tvalid           ( rd_tvalid_04               ) ,
  .m_axis_tready           ( rd_tready_04               ) ,
  .m_axis_tlast            ( rd_tlast_04                ) ,
  .m_axis_tdata            ( rd_tdata_04                )
);
// AXI4 Read Master05, output format is an AXI4-Stream master, one stream per thread.
axi_read_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M05_AXI_ADDR_WIDTH       ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M05_AXI_DATA_WIDTH       ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH          ) ,
  .C_MAX_OUTSTANDING   ( LP_RD_MAX_OUTSTANDING_05   ) ,
  .C_INCLUDE_DATA_FIFO ( 1                          )
)
AXI_Read_inst05 (
  .aclk                    ( aclk                       ) ,
  .areset                  ( areset                     ) ,
  .ctrl_start              ( ap_start                   ) ,
  .ctrl_done               ( read_done_05               ) ,
  .ctrl_addr_offset        ( ctrl05_addr_offset         ) ,
  .ctrl_xfer_size_in_bytes ( ctrl05_xfer_size_in_bytes  ) ,
  .m_axi_arvalid           ( m05_axi_arvalid            ) ,
  .m_axi_arready           ( m05_axi_arready            ) ,
  .m_axi_araddr            ( m05_axi_araddr             ) ,
  .m_axi_arlen             ( m05_axi_arlen              ) ,
  .m_axi_rvalid            ( m05_axi_rvalid             ) ,
  .m_axi_rready            ( m05_axi_rready             ) ,
  .m_axi_rdata             ( m05_axi_rdata              ) ,
  .m_axi_rlast             ( m05_axi_rlast              ) ,
  .m_axis_aclk             ( kernel_clk                 ) ,
  .m_axis_areset           ( kernel_rst                 ) ,
  .m_axis_tvalid           ( rd_tvalid_05               ) ,
  .m_axis_tready           ( rd_tready_05               ) ,
  .m_axis_tlast            ( rd_tlast_05                ) ,
  .m_axis_tdata            ( rd_tdata_05                )
);
// AXI4 Read Master06, output format is an AXI4-Stream master, one stream per thread.
axi_read_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M06_AXI_ADDR_WIDTH       ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M06_AXI_DATA_WIDTH       ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH          ) ,
  .C_MAX_OUTSTANDING   ( LP_RD_MAX_OUTSTANDING_06   ) ,
  .C_INCLUDE_DATA_FIFO ( 1                          )
)
AXI_Read_inst06 (
  .aclk                    ( aclk                       ) ,
  .areset                  ( areset                     ) ,
  .ctrl_start              ( ap_start                   ) ,
  .ctrl_done               ( read_done_06               ) ,
  .ctrl_addr_offset        ( ctrl06_addr_offset         ) ,
  .ctrl_xfer_size_in_bytes ( ctrl06_xfer_size_in_bytes  ) ,
  .m_axi_arvalid           ( m06_axi_arvalid            ) ,
  .m_axi_arready           ( m06_axi_arready            ) ,
  .m_axi_araddr            ( m06_axi_araddr             ) ,
  .m_axi_arlen             ( m06_axi_arlen              ) ,
  .m_axi_rvalid            ( m06_axi_rvalid             ) ,
  .m_axi_rready            ( m06_axi_rready             ) ,
  .m_axi_rdata             ( m06_axi_rdata              ) ,
  .m_axi_rlast             ( m06_axi_rlast              ) ,
  .m_axis_aclk             ( kernel_clk                 ) ,
  .m_axis_areset           ( kernel_rst                 ) ,
  .m_axis_tvalid           ( rd_tvalid_06               ) ,
  .m_axis_tready           ( rd_tready_06               ) ,
  .m_axis_tlast            ( rd_tlast_06                ) ,
  .m_axis_tdata            ( rd_tdata_06                )
);
// AXI4 Read Master07, output format is an AXI4-Stream master, one stream per thread.
axi_read_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M07_AXI_ADDR_WIDTH       ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M07_AXI_DATA_WIDTH       ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH          ) ,
  .C_MAX_OUTSTANDING   ( LP_RD_MAX_OUTSTANDING_07   ) ,
  .C_INCLUDE_DATA_FIFO ( 1                          )
)
AXI_Read_inst07 (
  .aclk                    ( aclk                       ) ,
  .areset                  ( areset                     ) ,
  .ctrl_start              ( ap_start                   ) ,
  .ctrl_done               ( read_done_07               ) ,
  .ctrl_addr_offset        ( ctrl07_addr_offset         ) ,
  .ctrl_xfer_size_in_bytes ( ctrl07_xfer_size_in_bytes  ) ,
  .m_axi_arvalid           ( m07_axi_arvalid            ) ,
  .m_axi_arready           ( m07_axi_arready            ) ,
  .m_axi_araddr            ( m07_axi_araddr             ) ,
  .m_axi_arlen             ( m07_axi_arlen              ) ,
  .m_axi_rvalid            ( m07_axi_rvalid             ) ,
  .m_axi_rready            ( m07_axi_rready             ) ,
  .m_axi_rdata             ( m07_axi_rdata              ) ,
  .m_axi_rlast             ( m07_axi_rlast              ) ,
  .m_axis_aclk             ( kernel_clk                 ) ,
  .m_axis_areset           ( kernel_rst                 ) ,
  .m_axis_tvalid           ( rd_tvalid_07               ) ,
  .m_axis_tready           ( rd_tready_07               ) ,
  .m_axis_tlast            ( rd_tlast_07                ) ,
  .m_axis_tdata            ( rd_tdata_07                )
);


//


MERGER_INTEGRATION #(
  .C_AXIS00_TDATA_WIDTH ( C_M00_AXI_DATA_WIDTH ) ,
  .C_AXIS01_TDATA_WIDTH ( C_M01_AXI_DATA_WIDTH ) ,
  .C_AXIS02_TDATA_WIDTH ( C_M02_AXI_DATA_WIDTH ) ,
  .C_AXIS03_TDATA_WIDTH ( C_M03_AXI_DATA_WIDTH ) ,
  .C_AXIS04_TDATA_WIDTH ( C_M04_AXI_DATA_WIDTH ) ,
  .C_AXIS05_TDATA_WIDTH ( C_M05_AXI_DATA_WIDTH ) ,
  .C_AXIS06_TDATA_WIDTH ( C_M06_AXI_DATA_WIDTH ) ,
  .C_AXIS07_TDATA_WIDTH ( C_M07_AXI_DATA_WIDTH ) ,
  .C_AXIS08_TDATA_WIDTH ( C_M08_AXI_DATA_WIDTH ), 
  .C_SORTER_BIT_WIDTH  ( C_SORTER_BIT_WIDTH  ) ,
  .C_NUM_CLOCKS       ( 1                  )
)
MERGER_INTEGRATION_inst0  (
  .s_axis_aclk   ( kernel_clk                   ) ,
  .s_axis_areset ( kernel_rst                   ) ,

  .s00_axis_tvalid ( rd_tvalid_00                    ) ,
  .s00_axis_tready ( rd_tready_00                    ) ,
  .s00_axis_tdata  ( rd_tdata_00                     ) ,
  .s00_axis_tkeep  ( {C_M00_AXI_DATA_WIDTH/8{1'b1}} ) ,
  .s00_axis_tlast  ( rd_tlast_00                     ) ,  

  .s01_axis_tvalid ( rd_tvalid_01                    ) ,
  .s01_axis_tready ( rd_tready_01                    ) ,
  .s01_axis_tdata  ( rd_tdata_01                     ) ,
  .s01_axis_tkeep  ( {C_M01_AXI_DATA_WIDTH/8{1'b1}} ) ,
  .s01_axis_tlast  ( rd_tlast_01                     ) ,  

  .s02_axis_tvalid ( rd_tvalid_02                    ) ,
  .s02_axis_tready ( rd_tready_02                    ) ,
  .s02_axis_tdata  ( rd_tdata_02                     ) ,
  .s02_axis_tkeep  ( {C_M02_AXI_DATA_WIDTH/8{1'b1}} ) ,
  .s02_axis_tlast  ( rd_tlast_02                     ) ,  

  .s03_axis_tvalid ( rd_tvalid_03                    ) ,
  .s03_axis_tready ( rd_tready_03                    ) ,
  .s03_axis_tdata  ( rd_tdata_03                     ) ,
  .s03_axis_tkeep  ( {C_M03_AXI_DATA_WIDTH/8{1'b1}} ) ,
  .s03_axis_tlast  ( rd_tlast_03                     ) ,  

  .s04_axis_tvalid ( rd_tvalid_04                    ) ,
  .s04_axis_tready ( rd_tready_04                    ) ,
  .s04_axis_tdata  ( rd_tdata_04                     ) ,
  .s04_axis_tkeep  ( {C_M04_AXI_DATA_WIDTH/8{1'b1}} ) ,
  .s04_axis_tlast  ( rd_tlast_04                     ) ,  

  .s05_axis_tvalid ( rd_tvalid_05                    ) ,
  .s05_axis_tready ( rd_tready_05                    ) ,
  .s05_axis_tdata  ( rd_tdata_05                     ) ,
  .s05_axis_tkeep  ( {C_M05_AXI_DATA_WIDTH/8{1'b1}} ) ,
  .s05_axis_tlast  ( rd_tlast_05                     ) ,  

  .s06_axis_tvalid ( rd_tvalid_06                    ) ,
  .s06_axis_tready ( rd_tready_06                    ) ,
  .s06_axis_tdata  ( rd_tdata_06                     ) ,
  .s06_axis_tkeep  ( {C_M06_AXI_DATA_WIDTH/8{1'b1}} ) ,
  .s06_axis_tlast  ( rd_tlast_06                     ) ,  

  .s07_axis_tvalid ( rd_tvalid_07                    ) ,
  .s07_axis_tready ( rd_tready_07                    ) ,
  .s07_axis_tdata  ( rd_tdata_07                     ) ,
  .s07_axis_tkeep  ( {C_M07_AXI_DATA_WIDTH/8{1'b1}} ) ,
  .s07_axis_tlast  ( rd_tlast_07                     ) ,  
  
  .m_axis_aclk   ( kernel_clk                   ) ,
  .m_axis_tvalid ( merger_out_tvalid            ) ,
  .m_axis_tready ( merger_out_tready            ) ,
  .m_axis_tdata  ( merger_out_tdata             ) ,
  .m_axis_tkeep  (                              ) , // Not used
  .m_axis_tlast  (                              )   // Not used
);

// AXI write master stage
logic                          write_done;

// AXI4 Write Master
axi_write_master #(
  .C_M_AXI_ADDR_WIDTH  ( C_M08_AXI_ADDR_WIDTH    ) ,
  .C_M_AXI_DATA_WIDTH  ( C_M08_AXI_DATA_WIDTH    ) ,
  .C_XFER_SIZE_WIDTH   ( C_XFER_SIZE_WIDTH     ) ,
  .C_MAX_OUTSTANDING   ( LP_WR_MAX_OUTSTANDING_08 ) ,
  .C_INCLUDE_DATA_FIFO ( 1                     )
)
AXI_write (
  .aclk                    ( aclk                    ) ,
  .areset                  ( areset                  ) ,
  .ctrl_start              ( ap_start                ) ,
  .ctrl_done               ( write_done              ) ,
  .ctrl_addr_offset        ( ctrl08_addr_offset        ) ,
  .ctrl_xfer_size_in_bytes ( ctrl08_xfer_size_in_bytes ) ,
  .m_axi_awvalid           ( m08_axi_awvalid           ) ,
  .m_axi_awready           ( m08_axi_awready           ) ,
  .m_axi_awaddr            ( m08_axi_awaddr            ) ,
  .m_axi_awlen             ( m08_axi_awlen             ) ,
  .m_axi_wvalid            ( m08_axi_wvalid            ) ,
  .m_axi_wready            ( m08_axi_wready            ) ,
  .m_axi_wdata             ( m08_axi_wdata             ) ,
  .m_axi_wstrb             ( m08_axi_wstrb             ) ,
  .m_axi_wlast             ( m08_axi_wlast             ) ,
  .m_axi_bvalid            ( m08_axi_bvalid            ) ,
  .m_axi_bready            ( m08_axi_bready            ) ,
  .s_axis_aclk             ( kernel_clk              ) ,
  .s_axis_areset           ( kernel_rst              ) ,
  .s_axis_tvalid           ( merger_out_tvalid            ) ,
  .s_axis_tready           ( merger_out_tready            ) ,
  .s_axis_tdata            ( merger_out_tdata             )
);

assign ap_done = write_done;

endmodule : MERGER_TREE_P4_L4_TOP
`default_nettype wire


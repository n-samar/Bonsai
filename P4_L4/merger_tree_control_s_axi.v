// This is a generated file. Use and modify at your own risk.
////////////////////////////////////////////////////////////////////////////////

// default_nettype of none prevents implicit wire declaration.
`default_nettype none
`timescale 1ns/1ps
module merger_tree_control_s_axi #(
  parameter integer C_ADDR_WIDTH = 12,
  parameter integer C_DATA_WIDTH = 32
)
(
  // AXI4-Lite slave signals
  input  wire                      aclk     ,
  input  wire                      areset   ,
  input  wire                      aclk_en  ,
  input  wire                      awvalid  ,
  output wire                      awready  ,
  input  wire [C_ADDR_WIDTH-1:0]   awaddr   ,
  input  wire                      wvalid   ,
  output wire                      wready   ,
  input  wire [C_DATA_WIDTH-1:0]   wdata    ,
  input  wire [C_DATA_WIDTH/8-1:0] wstrb    ,
  input  wire                      arvalid  ,
  output wire                      arready  ,
  input  wire [C_ADDR_WIDTH-1:0]   araddr   ,
  output wire                      rvalid   ,
  input  wire                      rready   ,
  output wire [C_DATA_WIDTH-1:0]   rdata    ,
  output wire [2-1:0]              rresp    ,
  output wire                      bvalid   ,
  input  wire                      bready   ,
  output wire [2-1:0]              bresp    ,
  output wire                      interrupt,
  output wire                      ap_start ,
  input  wire                      ap_idle  ,
  input  wire                      ap_done  ,
  // User defined arguments
  output wire [32-1:0]             insize00 ,
  output wire [32-1:0]             insize01 ,
  output wire [32-1:0]             insize02 ,
  output wire [32-1:0]             insize03 ,
  output wire [32-1:0]             insize04 ,
  output wire [32-1:0]             insize05 ,
  output wire [32-1:0]             insize06 ,
  output wire [32-1:0]             insize07 ,
  output wire [64-1:0]             in0_ptr  ,
  output wire [64-1:0]             in1_ptr  ,
  output wire [64-1:0]             in2_ptr  ,
  output wire [64-1:0]             in3_ptr  ,
  output wire [64-1:0]             in4_ptr  ,
  output wire [64-1:0]             in5_ptr  ,
  output wire [64-1:0]             in6_ptr  ,
  output wire [64-1:0]             in7_ptr  ,
  output wire [64-1:0]             out_ptr  
);

//------------------------Address Info-------------------
// 0x000 : Control signals
//         bit 0  - ap_start (Read/Write/COH)
//         bit 1  - ap_done (Read/COR)
//         bit 2  - ap_idle (Read)
//         others - reserved
// 0x004 : Global Interrupt Enable Register
//         bit 0  - Global Interrupt Enable (Read/Write)
//         others - reserved
// 0x008 : IP Interrupt Enable Register (Read/Write)
//         bit 0  - Channel 0 (ap_done)
//         others - reserved
// 0x00c : IP Interrupt Status Register (Read/TOW)
//         bit 0  - Channel 0 (ap_done)
//         others - reserved
// 0x010 : Data signal of insize00
//         bit 31~0 - insize00[31:0] (Read/Write)
// 0x014 : reserved
// 0x018 : Data signal of insize01
//         bit 31~0 - insize01[31:0] (Read/Write)
// 0x01c : reserved
// 0x020 : Data signal of insize02
//         bit 31~0 - insize02[31:0] (Read/Write)
// 0x024 : reserved
// 0x028 : Data signal of insize03
//         bit 31~0 - insize03[31:0] (Read/Write)
// 0x02c : reserved
// 0x030 : Data signal of insize04
//         bit 31~0 - insize04[31:0] (Read/Write)
// 0x034 : reserved
// 0x038 : Data signal of insize05
//         bit 31~0 - insize05[31:0] (Read/Write)
// 0x03c : reserved
// 0x040 : Data signal of insize06
//         bit 31~0 - insize06[31:0] (Read/Write)
// 0x044 : reserved
// 0x048 : Data signal of insize07
//         bit 31~0 - insize07[31:0] (Read/Write)
// 0x04c : reserved
// 0x050 : Data signal of in0_ptr
//         bit 31~0 - in0_ptr[31:0] (Read/Write)
// 0x054 : Data signal of in0_ptr
//         bit 31~0 - in0_ptr[63:32] (Read/Write)
// 0x058 : Data signal of in1_ptr
//         bit 31~0 - in1_ptr[31:0] (Read/Write)
// 0x05c : Data signal of in1_ptr
//         bit 31~0 - in1_ptr[63:32] (Read/Write)
// 0x060 : Data signal of in2_ptr
//         bit 31~0 - in2_ptr[31:0] (Read/Write)
// 0x064 : Data signal of in2_ptr
//         bit 31~0 - in2_ptr[63:32] (Read/Write)
// 0x068 : Data signal of in3_ptr
//         bit 31~0 - in3_ptr[31:0] (Read/Write)
// 0x06c : Data signal of in3_ptr
//         bit 31~0 - in3_ptr[63:32] (Read/Write)
// 0x070 : Data signal of in4_ptr
//         bit 31~0 - in4_ptr[31:0] (Read/Write)
// 0x074 : Data signal of in4_ptr
//         bit 31~0 - in4_ptr[63:32] (Read/Write)
// 0x078 : Data signal of in5_ptr
//         bit 31~0 - in5_ptr[31:0] (Read/Write)
// 0x07c : Data signal of in5_ptr
//         bit 31~0 - in5_ptr[63:32] (Read/Write)
// 0x080 : Data signal of in6_ptr
//         bit 31~0 - in6_ptr[31:0] (Read/Write)
// 0x084 : Data signal of in6_ptr
//         bit 31~0 - in6_ptr[63:32] (Read/Write)
// 0x088 : Data signal of in7_ptr
//         bit 31~0 - in7_ptr[31:0] (Read/Write)
// 0x08c : Data signal of in7_ptr
//         bit 31~0 - in7_ptr[63:32] (Read/Write)
// 0x090 : Data signal of out_ptr
//         bit 31~0 - out_ptr[31:0] (Read/Write)
// 0x094 : Data signal of out_ptr
//         bit 31~0 - out_ptr[63:32] (Read/Write)
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

///////////////////////////////////////////////////////////////////////////////
// Local Parameters
///////////////////////////////////////////////////////////////////////////////
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_AP_CTRL                = 12'h000;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_GIE                    = 12'h004;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_IER                    = 12'h008;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_ISR                    = 12'h00c;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_INSIZE00_0             = 12'h010;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_INSIZE01_0             = 12'h018;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_INSIZE02_0             = 12'h020;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_INSIZE03_0             = 12'h028;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_INSIZE04_0             = 12'h030;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_INSIZE05_0             = 12'h038;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_INSIZE06_0             = 12'h040;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_INSIZE07_0             = 12'h048;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in0_ptr_0              = 12'h050;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in0_ptr_1              = 12'h054;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in1_ptr_0              = 12'h058;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in1_ptr_1              = 12'h05c;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in2_ptr_0              = 12'h060;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in2_ptr_1              = 12'h064;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in3_ptr_0              = 12'h068;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in3_ptr_1              = 12'h06c;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in4_ptr_0              = 12'h070;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in4_ptr_1              = 12'h074;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in5_ptr_0              = 12'h078;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in5_ptr_1              = 12'h07c;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in6_ptr_0              = 12'h080;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in6_ptr_1              = 12'h084;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in7_ptr_0              = 12'h088;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_in7_ptr_1              = 12'h08c;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_out_ptr_0              = 12'h090;
localparam [C_ADDR_WIDTH-1:0]       LP_ADDR_out_ptr_1              = 12'h094;
localparam integer                  LP_SM_WIDTH                    = 2;
localparam [LP_SM_WIDTH-1:0]        SM_WRIDLE                      = 2'd0;
localparam [LP_SM_WIDTH-1:0]        SM_WRDATA                      = 2'd1;
localparam [LP_SM_WIDTH-1:0]        SM_WRRESP                      = 2'd2;
localparam [LP_SM_WIDTH-1:0]        SM_WRRESET                     = 2'd3;
localparam [LP_SM_WIDTH-1:0]        SM_RDIDLE                      = 2'd0;
localparam [LP_SM_WIDTH-1:0]        SM_RDDATA                      = 2'd1;
localparam [LP_SM_WIDTH-1:0]        SM_RDRESET                     = 2'd3;

///////////////////////////////////////////////////////////////////////////////
// Wires and Variables
///////////////////////////////////////////////////////////////////////////////
reg  [LP_SM_WIDTH-1:0]              wstate                         = SM_WRRESET;
reg  [LP_SM_WIDTH-1:0]              wnext                         ;
reg  [C_ADDR_WIDTH-1:0]             waddr                         ;
wire [C_DATA_WIDTH-1:0]             wmask                         ;
wire                                aw_hs                         ;
wire                                w_hs                          ;
reg  [LP_SM_WIDTH-1:0]              rstate                         = SM_RDRESET;
reg  [LP_SM_WIDTH-1:0]              rnext                         ;
reg  [C_DATA_WIDTH-1:0]             rdata_r                       ;
wire                                ar_hs                         ;
wire [C_ADDR_WIDTH-1:0]             raddr                         ;
// internal registers
wire                                int_ap_idle                   ;
reg                                 int_ap_done                    = 1'b0;
reg                                 int_ap_start                   = 1'b0;
reg                                 int_gie                        = 1'b0;
reg                                 int_ier                        = 1'b0;
reg                                 int_isr                        = 1'b0;

reg  [32-1:0]                       int_insize00                   = 32'd0;
reg  [32-1:0]                       int_insize01                   = 32'd0;
reg  [32-1:0]                       int_insize02                   = 32'd0;
reg  [32-1:0]                       int_insize03                   = 32'd0;
reg  [32-1:0]                       int_insize04                   = 32'd0;
reg  [32-1:0]                       int_insize05                   = 32'd0;
reg  [32-1:0]                       int_insize06                   = 32'd0;
reg  [32-1:0]                       int_insize07                   = 32'd0;
reg  [64-1:0]                       int_in0_ptr                    = 64'd0;
reg  [64-1:0]                       int_in1_ptr                    = 64'd0;
reg  [64-1:0]                       int_in2_ptr                    = 64'd0;
reg  [64-1:0]                       int_in3_ptr                    = 64'd0;
reg  [64-1:0]                       int_in4_ptr                    = 64'd0;
reg  [64-1:0]                       int_in5_ptr                    = 64'd0;
reg  [64-1:0]                       int_in6_ptr                    = 64'd0;
reg  [64-1:0]                       int_in7_ptr                    = 64'd0;
reg  [64-1:0]                       int_out_ptr                    = 64'd0;

///////////////////////////////////////////////////////////////////////////////
// Begin RTL
///////////////////////////////////////////////////////////////////////////////

//------------------------AXI write fsm------------------
assign awready = (wstate == SM_WRIDLE);
assign wready  = (wstate == SM_WRDATA);
assign bresp   = 2'b00;  // OKAY
assign bvalid  = (wstate == SM_WRRESP);
assign wmask   = { {8{wstrb[3]}}, {8{wstrb[2]}}, {8{wstrb[1]}}, {8{wstrb[0]}} };
assign aw_hs   = awvalid & awready;
assign w_hs    = wvalid & wready;

// wstate
always @(posedge aclk) begin
  if (areset)
    wstate <= SM_WRRESET;
  else if (aclk_en)
    wstate <= wnext;
end

// wnext
always @(*) begin
  case (wstate)
    SM_WRIDLE:
      if (awvalid)
        wnext = SM_WRDATA;
      else
        wnext = SM_WRIDLE;
    SM_WRDATA:
      if (wvalid)
        wnext = SM_WRRESP;
      else
        wnext = SM_WRDATA;
    SM_WRRESP:
      if (bready)
        wnext = SM_WRIDLE;
      else
        wnext = SM_WRRESP;
    // SM_WRRESET
    default:
      wnext = SM_WRIDLE;
  endcase
end

// waddr
always @(posedge aclk) begin
  if (aclk_en) begin
    if (aw_hs)
      waddr <= awaddr;
  end
end

//------------------------AXI read fsm-------------------
assign arready = (rstate == SM_RDIDLE);
assign rdata   = rdata_r;
assign rresp   = 2'b00;  // OKAY
assign rvalid  = (rstate == SM_RDDATA);
assign ar_hs   = arvalid & arready;
assign raddr   = araddr;

// rstate
always @(posedge aclk) begin
  if (areset)
    rstate <= SM_RDRESET;
  else if (aclk_en)
    rstate <= rnext;
end

// rnext
always @(*) begin
  case (rstate)
    SM_RDIDLE:
      if (arvalid)
        rnext = SM_RDDATA;
      else
        rnext = SM_RDIDLE;
    SM_RDDATA:
      if (rready & rvalid)
        rnext = SM_RDIDLE;
      else
        rnext = SM_RDDATA;
    // SM_RDRESET:
    default:
      rnext = SM_RDIDLE;
  endcase
end

// rdata_r
always @(posedge aclk) begin
  if (aclk_en) begin
    if (ar_hs) begin
      rdata_r <= {C_DATA_WIDTH{1'b0}};
      case (raddr)
        LP_ADDR_AP_CTRL: begin
          rdata_r[0] <= int_ap_start;
          rdata_r[1] <= int_ap_done;
          rdata_r[2] <= int_ap_idle;
          rdata_r[3+:C_DATA_WIDTH-3] <= {C_DATA_WIDTH-3{1'b0}};
        end
        LP_ADDR_GIE: begin
          rdata_r[0] <= int_gie;
          rdata_r[1+:C_DATA_WIDTH-1] <=  {C_DATA_WIDTH-1{1'b0}};
        end
        LP_ADDR_IER: begin
          rdata_r[0] <= int_ier;
          rdata_r[1+:C_DATA_WIDTH-1] <=  {C_DATA_WIDTH-1{1'b0}};
        end
        LP_ADDR_ISR: begin
          rdata_r[0] <= int_isr;
          rdata_r[1+:C_DATA_WIDTH-1] <=  {C_DATA_WIDTH-1{1'b0}};
        end
        LP_ADDR_INSIZE00_0: begin
          rdata_r <= int_insize00[0+:32];
        end
        LP_ADDR_INSIZE01_0: begin
          rdata_r <= int_insize01[0+:32];
        end
        LP_ADDR_INSIZE02_0: begin
          rdata_r <= int_insize02[0+:32];
        end
        LP_ADDR_INSIZE03_0: begin
          rdata_r <= int_insize03[0+:32];
        end
        LP_ADDR_INSIZE04_0: begin
          rdata_r <= int_insize04[0+:32];
        end
        LP_ADDR_INSIZE05_0: begin
          rdata_r <= int_insize05[0+:32];
        end
        LP_ADDR_INSIZE06_0: begin
          rdata_r <= int_insize06[0+:32];
        end
        LP_ADDR_INSIZE07_0: begin
          rdata_r <= int_insize07[0+:32];
        end
        LP_ADDR_in0_ptr_0: begin
          rdata_r <= int_in0_ptr[0+:32];
        end
        LP_ADDR_in0_ptr_1: begin
          rdata_r <= int_in0_ptr[32+:32];
        end
        LP_ADDR_in1_ptr_0: begin
          rdata_r <= int_in1_ptr[0+:32];
        end
        LP_ADDR_in1_ptr_1: begin
          rdata_r <= int_in1_ptr[32+:32];
        end
        LP_ADDR_in2_ptr_0: begin
          rdata_r <= int_in2_ptr[0+:32];
        end
        LP_ADDR_in2_ptr_1: begin
          rdata_r <= int_in2_ptr[32+:32];
        end
        LP_ADDR_in3_ptr_0: begin
          rdata_r <= int_in3_ptr[0+:32];
        end
        LP_ADDR_in3_ptr_1: begin
          rdata_r <= int_in3_ptr[32+:32];
        end
        LP_ADDR_in4_ptr_0: begin
          rdata_r <= int_in4_ptr[0+:32];
        end
        LP_ADDR_in4_ptr_1: begin
          rdata_r <= int_in4_ptr[32+:32];
        end
        LP_ADDR_in5_ptr_0: begin
          rdata_r <= int_in5_ptr[0+:32];
        end
        LP_ADDR_in5_ptr_1: begin
          rdata_r <= int_in5_ptr[32+:32];
        end
        LP_ADDR_in6_ptr_0: begin
          rdata_r <= int_in6_ptr[0+:32];
        end
        LP_ADDR_in6_ptr_1: begin
          rdata_r <= int_in6_ptr[32+:32];
        end
        LP_ADDR_in7_ptr_0: begin
          rdata_r <= int_in7_ptr[0+:32];
        end
        LP_ADDR_in7_ptr_1: begin
          rdata_r <= int_in7_ptr[32+:32];
        end
        LP_ADDR_out_ptr_0: begin
          rdata_r <= int_out_ptr[0+:32];
        end
        LP_ADDR_out_ptr_1: begin
          rdata_r <= int_out_ptr[32+:32];
        end

        default: begin
          rdata_r <= {C_DATA_WIDTH{1'b0}};
        end
      endcase
    end
  end
end

//------------------------Register logic-----------------
assign interrupt    = int_gie & (|int_isr);
assign ap_start     = int_ap_start;
assign int_ap_idle  = ap_idle;
assign insize00 = int_insize00;
assign insize01 = int_insize01;
assign insize02 = int_insize02;
assign insize03 = int_insize03;
assign insize04 = int_insize04;
assign insize05 = int_insize05;
assign insize06 = int_insize06;
assign insize07 = int_insize07;
assign in0_ptr = int_in0_ptr;
assign in1_ptr = int_in1_ptr;
assign in2_ptr = int_in2_ptr;
assign in3_ptr = int_in3_ptr;
assign in4_ptr = int_in4_ptr;
assign in5_ptr = int_in5_ptr;
assign in6_ptr = int_in6_ptr;
assign in7_ptr = int_in7_ptr;
assign out_ptr = int_out_ptr;

// int_ap_start
always @(posedge aclk) begin
  if (areset)
    int_ap_start <= 1'b0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_AP_CTRL && wstrb[0] && wdata[0])
      int_ap_start <= 1'b1;
    else if (ap_done)
      int_ap_start <= 1'b0;
  end
end

// int_ap_done
always @(posedge aclk) begin
  if (areset)
    int_ap_done <= 1'b0;
  else if (aclk_en) begin
    if (ap_done)
      int_ap_done <= 1'b1;
    else if (ar_hs && raddr == LP_ADDR_AP_CTRL)
      int_ap_done <= 1'b0; // clear on read
  end
end

// int_gie
always @(posedge aclk) begin
  if (areset)
    int_gie     <= 1'b0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_GIE && wstrb[0])
      int_gie <= wdata[0];
  end
end

// int_ier
always @(posedge aclk) begin
  if (areset)
    int_ier     <= 1'b0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_IER && wstrb[0])
      int_ier <= wdata[0];
  end
end

// int_isr
always @(posedge aclk) begin
  if (areset)
    int_isr     <= 1'b0;
  else if (aclk_en) begin
    if (int_ier & ap_done)
      int_isr <= 1'b1;
    else if (w_hs && waddr == LP_ADDR_ISR && wstrb[0])
      int_isr <= int_isr ^ wdata[0];
  end
end


// int_insize00[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_insize00[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_INSIZE00_0)
      int_insize00[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_insize00[0+:32] & ~wmask[0+:32]);
  end
end

// int_insize01[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_insize01[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_INSIZE01_0)
      int_insize01[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_insize01[0+:32] & ~wmask[0+:32]);
  end
end

// int_insize02[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_insize02[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_INSIZE02_0)
      int_insize02[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_insize02[0+:32] & ~wmask[0+:32]);
  end
end

// int_insize03[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_insize03[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_INSIZE03_0)
      int_insize03[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_insize03[0+:32] & ~wmask[0+:32]);
  end
end

// int_insize04[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_insize04[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_INSIZE04_0)
      int_insize04[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_insize04[0+:32] & ~wmask[0+:32]);
  end
end

// int_insize05[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_insize05[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_INSIZE05_0)
      int_insize05[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_insize05[0+:32] & ~wmask[0+:32]);
  end
end

// int_insize06[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_insize06[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_INSIZE06_0)
      int_insize06[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_insize06[0+:32] & ~wmask[0+:32]);
  end
end

// int_insize07[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_insize07[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_INSIZE07_0)
      int_insize07[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_insize07[0+:32] & ~wmask[0+:32]);
  end
end

// int_in0_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in0_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in0_ptr_0)
      int_in0_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in0_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_in0_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in0_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in0_ptr_1)
      int_in0_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in0_ptr[32+:32] & ~wmask[0+:32]);
  end
end

// int_in1_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in1_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in1_ptr_0)
      int_in1_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in1_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_in1_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in1_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in1_ptr_1)
      int_in1_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in1_ptr[32+:32] & ~wmask[0+:32]);
  end
end

// int_in2_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in2_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in2_ptr_0)
      int_in2_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in2_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_in2_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in2_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in2_ptr_1)
      int_in2_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in2_ptr[32+:32] & ~wmask[0+:32]);
  end
end

// int_in3_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in3_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in3_ptr_0)
      int_in3_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in3_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_in3_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in3_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in3_ptr_1)
      int_in3_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in3_ptr[32+:32] & ~wmask[0+:32]);
  end
end

// int_in4_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in4_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in4_ptr_0)
      int_in4_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in4_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_in4_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in4_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in4_ptr_1)
      int_in4_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in4_ptr[32+:32] & ~wmask[0+:32]);
  end
end

// int_in5_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in5_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in5_ptr_0)
      int_in5_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in5_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_in5_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in5_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in5_ptr_1)
      int_in5_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in5_ptr[32+:32] & ~wmask[0+:32]);
  end
end

// int_in6_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in6_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in6_ptr_0)
      int_in6_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in6_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_in6_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in6_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in6_ptr_1)
      int_in6_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in6_ptr[32+:32] & ~wmask[0+:32]);
  end
end

// int_in7_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in7_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in7_ptr_0)
      int_in7_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in7_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_in7_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_in7_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_in7_ptr_1)
      int_in7_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_in7_ptr[32+:32] & ~wmask[0+:32]);
  end
end

// int_out_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_out_ptr[0+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_out_ptr_0)
      int_out_ptr[0+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_out_ptr[0+:32] & ~wmask[0+:32]);
  end
end

// int_out_ptr[32-1:0]
always @(posedge aclk) begin
  if (areset)
    int_out_ptr[32+:32] <= 32'd0;
  else if (aclk_en) begin
    if (w_hs && waddr == LP_ADDR_out_ptr_1)
      int_out_ptr[32+:32] <= (wdata[0+:32] & wmask[0+:32]) | (int_out_ptr[32+:32] & ~wmask[0+:32]);
  end
end


endmodule

`default_nettype wire


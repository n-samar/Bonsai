// default_nettype of none prevents implicit wire declaration.
`default_nettype none
`timescale 1ps / 1ps

module MERGER_INTEGRATION #(
  parameter integer C_AXIS00_TDATA_WIDTH = 512, 
  parameter integer C_AXIS01_TDATA_WIDTH = 512, 
  parameter integer C_AXIS02_TDATA_WIDTH = 512, 
  parameter integer C_AXIS03_TDATA_WIDTH = 512, 
  parameter integer C_AXIS04_TDATA_WIDTH = 512, 
  parameter integer C_AXIS05_TDATA_WIDTH = 512, 
  parameter integer C_AXIS06_TDATA_WIDTH = 512, 
  parameter integer C_AXIS07_TDATA_WIDTH = 512, 
  parameter integer C_AXIS08_TDATA_WIDTH = 512, 
  parameter integer C_SORTER_BIT_WIDTH  = 32,
  parameter integer C_NUM_CLOCKS       = 1
)
(

  input wire                                s_axis_aclk,
  input wire                                s_axis_areset,

  input wire                                s00_axis_tvalid,
  output wire                               s00_axis_tready,
  input wire  [C_AXIS00_TDATA_WIDTH-1:0]    s00_axis_tdata,
  input wire  [C_AXIS00_TDATA_WIDTH/8-1:0]  s00_axis_tkeep,
  input wire                                s00_axis_tlast,

  input wire                                s01_axis_tvalid,
  output wire                               s01_axis_tready,
  input wire  [C_AXIS01_TDATA_WIDTH-1:0]    s01_axis_tdata,
  input wire  [C_AXIS01_TDATA_WIDTH/8-1:0]  s01_axis_tkeep,
  input wire                                s01_axis_tlast,

  input wire                                s02_axis_tvalid,
  output wire                               s02_axis_tready,
  input wire  [C_AXIS02_TDATA_WIDTH-1:0]    s02_axis_tdata,
  input wire  [C_AXIS02_TDATA_WIDTH/8-1:0]  s02_axis_tkeep,
  input wire                                s02_axis_tlast,

  input wire                                s03_axis_tvalid,
  output wire                               s03_axis_tready,
  input wire  [C_AXIS03_TDATA_WIDTH-1:0]    s03_axis_tdata,
  input wire  [C_AXIS03_TDATA_WIDTH/8-1:0]  s03_axis_tkeep,
  input wire                                s03_axis_tlast,

  input wire                                s04_axis_tvalid,
  output wire                               s04_axis_tready,
  input wire  [C_AXIS04_TDATA_WIDTH-1:0]    s04_axis_tdata,
  input wire  [C_AXIS04_TDATA_WIDTH/8-1:0]  s04_axis_tkeep,
  input wire                                s04_axis_tlast,

  input wire                                s05_axis_tvalid,
  output wire                               s05_axis_tready,
  input wire  [C_AXIS05_TDATA_WIDTH-1:0]    s05_axis_tdata,
  input wire  [C_AXIS05_TDATA_WIDTH/8-1:0]  s05_axis_tkeep,
  input wire                                s05_axis_tlast,

  input wire                                s06_axis_tvalid,
  output wire                               s06_axis_tready,
  input wire  [C_AXIS06_TDATA_WIDTH-1:0]    s06_axis_tdata,
  input wire  [C_AXIS06_TDATA_WIDTH/8-1:0]  s06_axis_tkeep,
  input wire                                s06_axis_tlast,

  input wire                                s07_axis_tvalid,
  output wire                               s07_axis_tready,
  input wire  [C_AXIS07_TDATA_WIDTH-1:0]    s07_axis_tdata,
  input wire  [C_AXIS07_TDATA_WIDTH/8-1:0]  s07_axis_tkeep,
  input wire                                s07_axis_tlast,

  input wire                                m_axis_aclk,
  output wire                               m_axis_tvalid,
  input  wire                               m_axis_tready,
  output wire [C_AXIS08_TDATA_WIDTH-1:0]    m_axis_tdata,
  output wire [C_AXIS08_TDATA_WIDTH/8-1:0]  m_axis_tkeep,
  output wire                               m_axis_tlast

);

localparam integer LP_NUM_LOOPS = C_AXIS00_TDATA_WIDTH/C_SORTER_BIT_WIDTH;
/////////////////////////////////////////////////////////////////////////////
// Variables
/////////////////////////////////////////////////////////////////////////////
parameter L = 4;

// FIFO_EMPTY 
// input signals
wire [C_SORTER_BIT_WIDTH-1:0] 	    in_fifo [0:2*L-1];
wire [2*L-1:0]                      write_fifo;
wire [2*L-1:0]                      fifo_read;
// output signals
wire [C_SORTER_BIT_WIDTH-1:0]         out_fifo [0:2*L-1];
wire [2*L-1:0]                      fifo_full;
wire [2*L-1:0]                      fifo_empty;

// IFIFO16 signals
wire                                o_out_fifo_write;
wire                                fifo_out_full;
wire                                fifo_out_empty;
wire [4*C_SORTER_BIT_WIDTH-1:0]     o_data;
wire [4*C_SORTER_BIT_WIDTH-1:0]     out_fifo_item;

wire read_fifo_out;

// data & controls for s00_axis
wire                                ready00; 
wire                                ready00_delay;
wire                                ready00_delay_1;
wire                                ready00_delay_2;
reg [C_AXIS00_TDATA_WIDTH-1:0]      s00_axis_tdata_stored;  
reg                                 write_fifo_reg_00;
reg [4:0]                           counter_00;
// data & controls for s01_axis
wire                                ready01; 
wire                                ready01_delay;
wire                                ready01_delay_1;
wire                                ready01_delay_2;
reg [C_AXIS01_TDATA_WIDTH-1:0]      s01_axis_tdata_stored;  
reg                                 write_fifo_reg_01;
reg [4:0]                           counter_01; 
// data & controls for s02_axis
wire                                ready02; 
wire                                ready02_delay;
wire                                ready02_delay_1;
wire                                ready02_delay_2;
reg [C_AXIS02_TDATA_WIDTH-1:0]      s02_axis_tdata_stored; 
reg                                 write_fifo_reg_02; 
reg [4:0]                           counter_02; 
// data & controls for s03_axis
wire                                ready03; 
wire                                ready03_delay;
wire                                ready03_delay_1;
wire                                ready03_delay_2;
reg [C_AXIS03_TDATA_WIDTH-1:0]      s03_axis_tdata_stored; 
reg                                 write_fifo_reg_03; 
reg [4:0]                           counter_03; 
// data & controls for s04_axis
wire                                ready04; 
wire                                ready04_delay;
wire                                ready04_delay_1;
wire                                ready04_delay_2;
reg [C_AXIS04_TDATA_WIDTH-1:0]      s04_axis_tdata_stored; 
reg                                 write_fifo_reg_04; 
reg [4:0]                           counter_04; 
// data & controls for s05_axis
wire                                ready05; 
wire                                ready05_delay;
wire                                ready05_delay_1;
wire                                ready05_delay_2;
reg [C_AXIS05_TDATA_WIDTH-1:0]      s05_axis_tdata_stored; 
reg                                 write_fifo_reg_05; 
reg [4:0]                           counter_05; 
// data & controls for s06_axis
wire                                ready06; 
wire                                ready06_delay;
wire                                ready06_delay_1;
wire                                ready06_delay_2;
reg [C_AXIS06_TDATA_WIDTH-1:0]      s06_axis_tdata_stored;
reg                                 write_fifo_reg_06;  
reg [4:0]                           counter_06; 
// data & controls for s07_axis
wire                                ready07; 
wire                                ready07_delay;
wire                                ready07_delay_1;
wire                                ready07_delay_2;
reg [C_AXIS07_TDATA_WIDTH-1:0]      s07_axis_tdata_stored;  
reg                                 write_fifo_reg_07;
reg [4:0]                           counter_07;  

/////////////////////////////////////////////////////////////////////////////
// Merger Logic
/////////////////////////////////////////////////////////////////////////////
assign read_fifo_out = ~fifo_out_empty;

// prepare data for leaf 00
assign ready00 = s00_axis_tvalid & (counter_00 == 5'd1);
assign in_fifo[0] = s00_axis_tdata_stored[C_SORTER_BIT_WIDTH-1:0];
assign write_fifo[0] = write_fifo_reg_00;

register #(.N(1))   register_ready00_inst_0(.clk(s_axis_aclk), .d(ready00), .q(ready00_delay));
register #(.N(1))   register_ready00_inst_1(.clk(s_axis_aclk), .d(ready00_delay), .q(ready00_delay_1));
register #(.N(1))   register_ready00_inst_2(.clk(s_axis_aclk), .d(ready00_delay_1), .q(ready00_delay_2));


always @(posedge s_axis_aclk)
begin
    if(ready00_delay_2)
    begin
        s00_axis_tdata_stored <= s00_axis_tdata;
    end
    else
    begin
        if (~fifo_full[0])
        begin
            s00_axis_tdata_stored <= (s00_axis_tdata_stored >> C_SORTER_BIT_WIDTH);
        end
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_fifo_reg_00 <= 0;
    end
    else if(ready00_delay_2 && (~fifo_full[0]))
    begin
        write_fifo_reg_00 <= 1;
    end
    else if((~fifo_full[0]) && (counter_00 <= 5'd16))
    begin
        write_fifo_reg_00 <= 1;
    end
    else
    begin
         write_fifo_reg_00 <= 0;
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        counter_00 <= 5'd31;
    end
    else if(ready00_delay_2)
    begin
        if(fifo_full[0])
        begin
            counter_00 <= 5'd17;
        end
        else
        begin 
            counter_00 <= 5'd16;
        end
    end
    else if(counter_00 != 0)
    begin
        if(fifo_full[0])
        begin
            counter_00 <= counter_00;
        end
        else if(s00_axis_tvalid)
        begin
            counter_00 <= counter_00 - 1;
        end
        else
        begin
            counter_00 <= counter_00;
        end
    end
    else
    begin
        counter_00 <= counter_00;
    end
end

assign s00_axis_tready = ready00;

// prepare data for leaf 01
assign ready01 = s01_axis_tvalid & (counter_01 == 5'd1);
assign in_fifo[1] = s01_axis_tdata_stored[C_SORTER_BIT_WIDTH-1:0];
assign write_fifo[1] = write_fifo_reg_01;

register #(.N(1))   register_ready01_inst_0(.clk(s_axis_aclk), .d(ready01), .q(ready01_delay));
register #(.N(1))   register_ready01_inst_1(.clk(s_axis_aclk), .d(ready01_delay), .q(ready01_delay_1));
register #(.N(1))   register_ready01_inst_2(.clk(s_axis_aclk), .d(ready01_delay_1), .q(ready01_delay_2));

always @(posedge s_axis_aclk)
begin
    if(ready01_delay_2)
    begin
        s01_axis_tdata_stored <= s01_axis_tdata;
    end
    else
    begin 
        if (~fifo_full[1])
        begin
            s01_axis_tdata_stored <= (s01_axis_tdata_stored >> C_SORTER_BIT_WIDTH);
        end
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_fifo_reg_01 <= 0;
    end
    else if(ready01_delay_2 && (~fifo_full[1]))
    begin
        write_fifo_reg_01 <= 1;
    end
    else if((~fifo_full[1]) && (counter_01 <= 5'd16))
    begin
        write_fifo_reg_01 <= 1;
    end
    else
    begin
         write_fifo_reg_01 <= 0;
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        counter_01 <= 5'd31;
    end
    else if(ready01_delay_2)
    begin
        if(fifo_full[1])
        begin
            counter_01 <= 5'd17;
        end
        else
        begin 
            counter_01 <= 5'd16;
        end
    end
    else if(counter_01 != 0)
    begin
        if(fifo_full[1])
        begin
            counter_01 <= counter_01;
        end
        else if(s01_axis_tvalid)
        begin
            counter_01 <= counter_01 - 1;
        end
        else
        begin
            counter_01 <= counter_01;
        end
    end
    else
    begin
        counter_01 <= counter_01;
    end
end

assign s01_axis_tready = ready01;

// prepare data for leaf 02
assign ready02 = s02_axis_tvalid & (counter_02 == 5'd1);
assign in_fifo[2] = s02_axis_tdata_stored[C_SORTER_BIT_WIDTH-1:0];
assign write_fifo[2] = write_fifo_reg_02;

register #(.N(1))   register_ready02_inst_0(.clk(s_axis_aclk), .d(ready02), .q(ready02_delay));
register #(.N(1))   register_ready02_inst_1(.clk(s_axis_aclk), .d(ready02_delay), .q(ready02_delay_1));
register #(.N(1))   register_ready02_inst_2(.clk(s_axis_aclk), .d(ready02_delay_1), .q(ready02_delay_2));

always @(posedge s_axis_aclk)
begin
    if(ready02_delay_2)
    begin
        s02_axis_tdata_stored <= s02_axis_tdata;
    end
    else
    begin
        if (~fifo_full[2])
        begin
            s02_axis_tdata_stored <= (s02_axis_tdata_stored >> C_SORTER_BIT_WIDTH);
        end
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_fifo_reg_02 <= 0;
    end
    else if(ready02_delay_2 && (~fifo_full[2]))
    begin
        write_fifo_reg_02 <= 1;
    end
    else if((~fifo_full[2]) && (counter_02 <= 5'd16))
    begin
        write_fifo_reg_02 <= 1;
    end
    else
    begin
         write_fifo_reg_02 <= 0;
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        counter_02 <= 5'd31;
    end
    else if(ready02_delay_2)
    begin
        if(fifo_full[2])
        begin
            counter_02 <= 5'd17;
        end
        else
        begin 
            counter_02 <= 5'd16;
        end
    end
    else if(counter_02 != 0)
    begin
        if(fifo_full[2])
        begin
            counter_02 <= counter_02;
        end
        else if(s02_axis_tvalid)
        begin
            counter_02 <= counter_02 - 1;
        end
        else
        begin
            counter_02 <= counter_02;
        end
    end
    else
    begin
        counter_02 <= counter_02;
    end
end

assign s02_axis_tready = ready02;

// prepare data for leaf 03
assign ready03 = s03_axis_tvalid & (counter_03 == 5'd1);
assign in_fifo[3] = s03_axis_tdata_stored[C_SORTER_BIT_WIDTH-1:0];
assign write_fifo[3] = write_fifo_reg_03;

register #(.N(1))   register_ready03_inst_0(.clk(s_axis_aclk), .d(ready03), .q(ready03_delay));
register #(.N(1))   register_ready03_inst_1(.clk(s_axis_aclk), .d(ready03_delay), .q(ready03_delay_1));
register #(.N(1))   register_ready03_inst_2(.clk(s_axis_aclk), .d(ready03_delay_1), .q(ready03_delay_2));

always @(posedge s_axis_aclk)
begin
    if(ready03_delay_2)
    begin
        s03_axis_tdata_stored <= s03_axis_tdata;
    end
    else
    begin
        if (~fifo_full[3])
        begin
            s03_axis_tdata_stored <= (s03_axis_tdata_stored >> C_SORTER_BIT_WIDTH);
        end
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_fifo_reg_03 <= 0;
    end
    else if(ready03_delay_2 && (~fifo_full[3]))
    begin
        write_fifo_reg_03 <= 1;
    end
    else if((~fifo_full[3]) && (counter_03 <= 5'd16))
    begin
        write_fifo_reg_03 <= 1;
    end
    else
    begin
         write_fifo_reg_03 <= 0;
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        counter_03 <= 5'd31;
    end
    else if(ready03_delay_2)
    begin
        if(fifo_full[3])
        begin
            counter_03 <= 5'd17;
        end
        else
        begin 
            counter_03 <= 5'd16;
        end
    end
    else if(counter_03 != 0)
    begin
        if(fifo_full[3])
        begin
            counter_03 <= counter_03;
        end
        else if(s03_axis_tvalid)
        begin
            counter_03 <= counter_03 - 1;
        end
        else
        begin
            counter_03 <= counter_03;
        end
    end
    else
    begin
        counter_03 <= counter_03;
    end
end

assign s03_axis_tready = ready03;

// prepare data for leaf 04
assign ready04 = s04_axis_tvalid & (counter_04 == 5'd1);
assign in_fifo[4] = s04_axis_tdata_stored[C_SORTER_BIT_WIDTH-1:0];
assign write_fifo[4] = write_fifo_reg_04;

register #(.N(1))   register_ready04_inst_0(.clk(s_axis_aclk), .d(ready04), .q(ready04_delay));
register #(.N(1))   register_ready04_inst_1(.clk(s_axis_aclk), .d(ready04_delay), .q(ready04_delay_1));
register #(.N(1))   register_ready04_inst_2(.clk(s_axis_aclk), .d(ready04_delay_1), .q(ready04_delay_2));

always @(posedge s_axis_aclk)
begin
    if(ready04_delay_2)
    begin
        s04_axis_tdata_stored <= s04_axis_tdata;
    end
    else
    begin
        if (~fifo_full[4])
        begin
            s04_axis_tdata_stored <= (s04_axis_tdata_stored >> C_SORTER_BIT_WIDTH);
        end
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_fifo_reg_04 <= 0;
    end
    else if(ready04_delay_2 && (~fifo_full[4]))
    begin
        write_fifo_reg_04 <= 1;
    end
    else if((~fifo_full[4]) && (counter_04 <= 5'd16))
    begin
        write_fifo_reg_04 <= 1;
    end
    else
    begin
         write_fifo_reg_04 <= 0;
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        counter_04 <= 5'd31;
    end
    else if(ready04_delay_2)
    begin
        if(fifo_full[4])
        begin
            counter_04 <= 5'd17;
        end
        else
        begin 
            counter_04 <= 5'd16;
        end
    end
    else if(counter_04 != 0)
    begin
        if(fifo_full[4])
        begin
            counter_04 <= counter_04;
        end
        else if(s04_axis_tvalid)
        begin
            counter_04 <= counter_04 - 1;
        end
        else
        begin
            counter_04 <= counter_04;
        end
    end
    else
    begin
        counter_04 <= counter_04;
    end
end

assign s04_axis_tready = ready04;

// prepare data for leaf 05
assign ready05 = s05_axis_tvalid & (counter_05 == 5'd1);
assign in_fifo[5] = s05_axis_tdata_stored[C_SORTER_BIT_WIDTH-1:0];
assign write_fifo[5] = write_fifo_reg_05;

register #(.N(1))   register_ready05_inst_0(.clk(s_axis_aclk), .d(ready05), .q(ready05_delay));
register #(.N(1))   register_ready05_inst_1(.clk(s_axis_aclk), .d(ready05_delay), .q(ready05_delay_1));
register #(.N(1))   register_ready05_inst_2(.clk(s_axis_aclk), .d(ready05_delay_1), .q(ready05_delay_2));

always @(posedge s_axis_aclk)
begin
    if(ready05_delay_2)
    begin
        s05_axis_tdata_stored <= s05_axis_tdata;
    end
    else
    begin
        if (~fifo_full[5])
        begin
            s05_axis_tdata_stored <= (s05_axis_tdata_stored >> C_SORTER_BIT_WIDTH);
        end
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_fifo_reg_05 <= 0;
    end
    else if(ready05_delay_2 && (~fifo_full[5]))
    begin
        write_fifo_reg_05 <= 1;
    end
    else if((~fifo_full[5]) && (counter_05 <= 5'd16))
    begin
        write_fifo_reg_05 <= 1;
    end
    else
    begin
         write_fifo_reg_05 <= 0;
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        counter_05 <= 5'd31;
    end
    else if(ready05_delay_2)
    begin
        if(fifo_full[5])
        begin
            counter_05 <= 5'd17;
        end
        else
        begin 
            counter_05 <= 5'd16;
        end
    end
    else if(counter_05 != 0)
    begin
        if(fifo_full[5])
        begin
            counter_05 <= counter_05;
        end
        else if(s05_axis_tvalid)
        begin
            counter_05 <= counter_05 - 1;
        end
        else
        begin
            counter_05 <= counter_05;
        end
    end
    else
    begin
        counter_05 <= counter_05;
    end
end

assign s05_axis_tready = ready05;

// prepare data for leaf 06
assign ready06 = s06_axis_tvalid & (counter_06 == 5'd1);
assign in_fifo[6] = s06_axis_tdata_stored[C_SORTER_BIT_WIDTH-1:0];
assign write_fifo[6] = write_fifo_reg_06;

register #(.N(1))   register_ready06_inst_0(.clk(s_axis_aclk), .d(ready06), .q(ready06_delay));
register #(.N(1))   register_ready06_inst_1(.clk(s_axis_aclk), .d(ready06_delay), .q(ready06_delay_1));
register #(.N(1))   register_ready06_inst_2(.clk(s_axis_aclk), .d(ready06_delay_1), .q(ready06_delay_2));

always @(posedge s_axis_aclk)
begin
    if(ready06_delay_2)
    begin
        s06_axis_tdata_stored <= s06_axis_tdata;
    end
    else
    begin
        if (~fifo_full[6])
        begin
            s06_axis_tdata_stored <= (s06_axis_tdata_stored >> C_SORTER_BIT_WIDTH);
        end
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_fifo_reg_06 <= 0;
    end
    else if(ready06_delay_2 && (~fifo_full[6]))
    begin
        write_fifo_reg_06 <= 1;
    end
    else if((~fifo_full[6]) && (counter_06 <= 5'd16))
    begin
        write_fifo_reg_06 <= 1;
    end
    else
    begin
         write_fifo_reg_06 <= 0;
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        counter_06 <= 5'd31;
    end
    else if(ready06_delay_2)
    begin
        if(fifo_full[6])
        begin
            counter_06 <= 5'd17;
        end
        else
        begin 
            counter_06 <= 5'd16;
        end
    end
    else if(counter_06 != 0)
    begin
        if(fifo_full[6])
        begin
            counter_06 <= counter_06;
        end
        else if(s06_axis_tvalid)
        begin
            counter_06 <= counter_06 - 1;
        end
        else
        begin
            counter_06 <= counter_06;
        end
    end
    else
    begin
        counter_06 <= counter_06;
    end
end

assign s06_axis_tready = ready06;

// prepare data for leaf 07
assign ready07 = s07_axis_tvalid & (counter_07 == 5'd1);
assign in_fifo[7] = s07_axis_tdata_stored[C_SORTER_BIT_WIDTH-1:0];
assign write_fifo[7] = write_fifo_reg_07;

register #(.N(1))   register_ready07_inst_0(.clk(s_axis_aclk), .d(ready07), .q(ready07_delay));
register #(.N(1))   register_ready07_inst_1(.clk(s_axis_aclk), .d(ready07_delay), .q(ready07_delay_1));
register #(.N(1))   register_ready07_inst_2(.clk(s_axis_aclk), .d(ready07_delay_1), .q(ready07_delay_2));

always @(posedge s_axis_aclk)
begin
    if(ready07_delay_2)
    begin
        s07_axis_tdata_stored <= s07_axis_tdata;
    end
    else
    begin
        if (~fifo_full[7])
        begin
            s07_axis_tdata_stored <= (s07_axis_tdata_stored >> C_SORTER_BIT_WIDTH);
        end
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_fifo_reg_07 <= 0;
    end
    else if(ready07_delay_2 && (~fifo_full[7]))
    begin
        write_fifo_reg_07 <= 1;
    end
    else if((~fifo_full[7]) && (counter_07 <= 5'd16))
    begin
        write_fifo_reg_07 <= 1;
    end
    else
    begin
         write_fifo_reg_07 <= 0;
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        counter_07 <= 5'd31;
    end
    else if(ready07_delay_2)
    begin
        if(fifo_full[0])
        begin
            counter_07 <= 5'd17;
        end
        else
        begin 
            counter_07 <= 5'd16;
        end
    end
    else if(counter_07 != 0)
    begin
        if(fifo_full[0])
        begin
            counter_07 <= counter_07;
        end
        else if(s07_axis_tvalid)
        begin
            counter_07 <= counter_07 - 1;
        end
        else
        begin
            counter_07 <= counter_07;
        end
    end
    else
    begin
        counter_07 <= counter_07;
    end
end

assign s07_axis_tready = ready07;

// Merger tree function
genvar 		   fifo_index;
generate
    for (fifo_index = 0; fifo_index < 2*L; fifo_index = fifo_index + 1) begin : IN
    FIFO_EMPTY fifo(.i_clk(s_axis_aclk),
            .i_item(in_fifo[fifo_index] ),
            .i_write(write_fifo[fifo_index]),
            .o_item(out_fifo[fifo_index]),
            .i_read(fifo_read[fifo_index]),
            .empty(fifo_empty[fifo_index]),
            .full(fifo_full[fifo_index]),
            .overrun(),
            .underrun());	 
    end // block: IN
endgenerate

IFIFO16 #(128) fifo_out(.i_clk(s_axis_aclk),
		    .i_data(o_data),
		    .i_enq(o_out_fifo_write),
		    .o_data(out_fifo_item),
		    .i_deq(read_fifo_out),
		    .o_empty(fifo_out_empty),
		    .o_full(fifo_out_full));

MERGER_TREE_P4_L4 dut (.i_clk(s_axis_aclk),
            .i_fifo({out_fifo[7], out_fifo[6], out_fifo[5], out_fifo[4], 
                out_fifo[3], out_fifo[2], out_fifo[1], out_fifo[0]}),
            .i_fifo_empty(fifo_empty),			  
            .i_fifo_out_ready(~fifo_out_full | read_fifo_out),
            .o_fifo_read(fifo_read),		  
            .o_out_fifo_write(o_out_fifo_write),
            .o_data(o_data));	

// signals for write
reg [C_AXIS08_TDATA_WIDTH-1:0]      data_out;
wire                                data_valid;
reg [2:0]                           write_counter;

always @(posedge s_axis_aclk)
begin
    if(read_fifo_out && (o_data != 0))
    begin
        case(write_counter)
            3'd0: 
            begin
                data_out <= {(C_AXIS08_TDATA_WIDTH-4*C_SORTER_BIT_WIDTH)'d0, o_data[4*C_SORTER_BIT_WIDTH-1:0]};
            end
            3'd1:
            begin
                data_out <= {(C_AXIS08_TDATA_WIDTH-8*C_SORTER_BIT_WIDTH)'d0, o_data[4*C_SORTER_BIT_WIDTH-1:0], data_out[4*C_SORTER_BIT_WIDTH-1:0]};
            end
            3'd2:
            begin
                data_out <= {(C_AXIS08_TDATA_WIDTH-12*C_SORTER_BIT_WIDTH)'d0, o_data[4*C_SORTER_BIT_WIDTH-1:0], data_out[8*C_SORTER_BIT_WIDTH-1:0]};
            end
            3'd3:
            begin
                data_out <= {o_data[4*C_SORTER_BIT_WIDTH-1:0], data_out[12*C_SORTER_BIT_WIDTH-1:0]};
            end
            3'd4:
            begin
                data_out <= {(C_AXIS08_TDATA_WIDTH-4*C_SORTER_BIT_WIDTH)'d0, o_data[4*C_SORTER_BIT_WIDTH-1:0]};
            end
            default:
            begin
                data_out <= data_out;
            end
        endcase
    end
end

always @(posedge s_axis_aclk)
begin
    if(s_axis_areset)
    begin
        write_counter <= 3'd0;
    end
    else if(read_fifo_out && (o_data != 0))
    begin
        if(write_counter == 4)
        begin
            write_counter <= 1;
        end
        else
        begin
            write_counter <= write_counter + 1;
        end 
    end
    else
    begin 
        if (write_counter == 4 && m_axis_tready)
        begin
            write_counter <= 3'd0;
        end
        else 
        begin
            write_counter <= write_counter;
        end
    end
end

assign data_valid = (write_counter == 4);
assign m_axis_tdata = data_out;
assign m_axis_tvalid = data_valid;
assign m_axis_tkeep = s00_axis_tkeep;
assign m_axis_tlast = s00_axis_tlast;


endmodule

`default_nettype wire
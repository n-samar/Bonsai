`timescale 1ps / 1ps

module register #(
    parameter integer N = 1
)
(
    input   wire                clk,
    input	wire    [N-1:0]	    d, 
    output	wire    [N-1:0]	    q
);

reg  [N-1:0]	q_reg;

always @(posedge clk)
	begin
		q_reg <= d;
	end

assign q = q_reg;

endmodule
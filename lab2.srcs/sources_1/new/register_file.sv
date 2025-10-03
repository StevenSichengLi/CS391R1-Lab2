`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2025 03:17:38 PM
// Design Name: 
// Module Name: register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file #(
    parameter WIDTH = 32,
    parameter NUM_REGS = 16
)(
    input  wire clk,
    input  wire we,
    input  wire [WIDTH-1:0] d_in,
    input  wire [4 :0] rd_sel,
    input  wire [4 :0] rs_sel,
    input  wire [4 :0] rt_sel,
    output wire [WIDTH-1:0] rs,
    output wire [WIDTH-1:0] rt
);

    reg [WIDTH-1:0] the_regs [0:31]; // 32 Regs.
    assign rs = the_regs[rs_sel[0:4]];
    assign rt = the_regs[rt_sel[0:4]];
    always @ (posedge clk) begin
    if (we)
    the_regs[rd_sel[4:0]] <= d_in;

endmodule

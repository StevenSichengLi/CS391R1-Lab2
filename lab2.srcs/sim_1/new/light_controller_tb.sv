`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2025 01:28:44 PM
// Design Name: 
// Module Name: light_controller_tb
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

module light_controller_tb;
    reg clk, rst, button;           
    wire [2:0] light_state;         

    parameter N = 300_000_000;

    light_controller #(N) uut (
        .clk(clk),
        .rst(rst),
        .button(button),
        .light_state(light_state)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; button = 0;

        // release rst after clock cycles
        repeat(2) @(posedge clk); rst = 0;

        // Press button
        button = 1;
        repeat(30) @(posedge clk);  // hold enough cycles to see cycling

        // Release button we should see it turn off
        button = 0;
        repeat(5) @(posedge clk);

        // Press again
        button = 1;
        repeat(8) @(posedge clk);
        button = 0;

        #20 $finish;
    end

    initial begin
        $monitor("t=%0t  clk=%b  btn=%b  light_state=%0d",
                 $time, clk, button, light_state);
    end
endmodule 

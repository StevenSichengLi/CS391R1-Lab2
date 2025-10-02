`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2025 12:10:09 PM
// Design Name: 
// Module Name: light_controller
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


module light_controller #(parameter N = 300_000_000)(
    input  wire clk, rst, button,
    output reg  [2:0] light_state
    );
    
    // indicator value, if button pressed before, then it is 1 else 0
    reg button_prev;
    
    // large enough for N (N:how long each color stays on) 
    reg [31:0] count;          

    // run if clock is incremented or button is reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            button_prev <= 1'b0;
            light_state <= 3'd0;
            count       <= 0;
        end
        else begin
            // if the button is pressed the frist time
            if (button && !button_prev) begin
                // turn light on (color 1)
                light_state <= 3'd1;
                count       <= 0;
            end

            // else if the button is held down
            else if (button) begin
                // if we are at the end of the cycle
                if (count == N-1) begin
                    count <= 0;
                    // if we are at the end of the light cycle, we wrap around
                    if (light_state == 3'd7)
                        light_state <= 3'd1;
                    // else we increment
                    else
                        light_state <= light_state + 3'd1;
                end
                // if we haven't reached the time limit
                else begin
                    count <= count + 1;
                end
            end

            // if we release the button
            else begin
                // reset everything and turn the light off
                light_state <= 3'd0;
                count       <= 0;
            end

            // Update previous button status
            button_prev <= button;
        end
    end
endmodule


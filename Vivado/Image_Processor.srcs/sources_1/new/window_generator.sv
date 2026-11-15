`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2026 10:32:56 PM
// Design Name: 
// Module Name: window_generator
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


module window_generator(
        input logic clk, rst, en,
        input logic [3:0] din,
        output logic [3:0] p0, p1, p2, p3, p4, p5, p6, p7, p8
    );
    
    logic [319:0] x;
    logic [3:0] row1, row2;

    line_buffer buffer_1 (.clk, .we(en), .addr(x), .din(din), .dout(row1));
    line_buffer buffer_2 (.clk, .we(en), .addr(x), .din(row1), .dout(row2));

    always_ff @(posedge clk) begin
        if (rst) 
            x <= 0;
        else if (en) begin
            x <= (x == 319) ? 0 : x + 1;
            // Shift the three columns left and bring in the new one
            p0 <= p1;   p1 <= p2;   p2 <= row2;
            p3 <= p4;   p4 <= p5;   p5 <= row1;
            p6 <= p7;   p7 <= p8;   p8 <= din;
        end
    end
    
endmodule

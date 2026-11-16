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
    
    logic [9:0] x, x_next;
    logic [3:0] row1, row2;
    
    assign x_next = (x == 10'd639) ? 10'd0 : x + 10'd1;

    line_buffer buffer_1 (.clk, .we(en), .waddr(x), .raddr(x_next), .din(din), .dout(row1));
    line_buffer buffer_2 (.clk, .we(en), .waddr(x), .raddr(x_next), .din(row1), .dout(row2));

    always_ff @(posedge clk) begin
        if (rst) 
            x <= 0;
        else if (en) begin
            x <= x_next;
            // Shift the three columns left and bring in the new one
            p0 <= p1;   p1 <= p2;   p2 <= row2;
            p3 <= p4;   p4 <= p5;   p5 <= row1;
            p6 <= p7;   p7 <= p8;   p8 <= din;
        end
    end
    
endmodule

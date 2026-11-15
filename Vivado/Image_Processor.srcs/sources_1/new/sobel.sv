`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2026 09:42:55 PM
// Design Name: 
// Module Name: sobel
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


module sobel(
        input logic [3:0] p0, p1, p2, p3, p4, p5, p6, p7, p8,
        output logic edge_out
    );
    
    logic signed [7:0] Gx, Gy;
    logic [7:0] Ax, Ay, mag;

    assign Gx = (p2 + 2*p5 + p8) - (p0 + 2*p3 + p6);
    assign Gy = (p6 + 2*p7 + p8) - (p0 + 2*p1 + p2);
    assign Ax = Gx[7] ? -Gx : Gx;
    assign Ay = Gy[7] ? -Gy : Gy;
    assign mag = Ax + Ay;
    assign edge_out = (mag > 8'd24);
    
endmodule

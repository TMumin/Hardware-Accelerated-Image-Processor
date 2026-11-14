`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 10:42:09 PM
// Design Name: 
// Module Name: grayscale
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


module grayscale(
        input logic [3:0] r, g, b,
        output logic [3:0] z
    );
    
    logic [11:0] sum;
    assign sum = r*77 + g*150 + b*29;
    assign z = sum[11:8];
    
endmodule

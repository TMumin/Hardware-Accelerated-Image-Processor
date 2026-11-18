`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2026 10:35:30 PM
// Design Name: 
// Module Name: gaussian
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


module gaussian(
        input logic [3:0] p0, p1, p2, p3, p4, p5, p6, p7, p8,
        output logic [3:0] weight
    );
    
    logic signed [7:0] weight_raw;
    assign weight_raw = p0 + 2*p1 + p2 + 2*p3 + 4*p4 + 2*p5 + p6 + 2*p7 + p8;
    assign weight = weight_raw >> 4;
    
endmodule

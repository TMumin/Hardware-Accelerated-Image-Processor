`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2026 11:22:55 PM
// Design Name: 
// Module Name: sharpen
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


module sharpen(
        input logic [3:0] p0, p1, p2, p3, p4, p5, p6, p7, p8,
        output logic [3:0] weight
    );
    
    logic signed [7:0] weight_raw;
    assign weight_raw = 0*p0 + -1*p1 + 0*p2 + -1*p3 + 5*p4 + -1*p5 + 0*p6 + -1*p7 + 0*p8;
    assign weight = (weight_raw < 0) ? 0 : (weight_raw > 4'd15) ? 4'd15: weight_raw[3:0];
    
endmodule

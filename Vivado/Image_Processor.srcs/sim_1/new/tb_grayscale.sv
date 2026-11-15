`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 10:47:27 PM
// Design Name: 
// Module Name: tb_grayscale
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


module tb_grayscale();
    timeunit 10ns;
	timeprecision 1ns;
    
    logic [3:0] r, g, b, z;
    grayscale dut (.*);

    initial begin
        {r,g,b} = 12'h000; 
        #10; 
        $display("black: z=%0d (expect 0)", z);
        {r,g,b} = 12'hF00; 
        #10; 
        $display("red: z=%0d (expect 4)", z);
        {r,g,b} = 12'h0F0; 
        #10; 
        $display("green: z=%0d (expect 8)", z);
        {r,g,b} = 12'h00F; 
        #10; 
        $display("blue: z=%0d (expect 1)", z);
        {r,g,b} = 12'hFFF; 
        #10; 
        $display("white: z=%0d (expect 15)", z);
        $finish;
    end
    
endmodule

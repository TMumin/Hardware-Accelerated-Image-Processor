`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2026 11:36:35 PM
// Design Name: 
// Module Name: tb_sharpen
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


module tb_sharpen();
    timeunit 10ns;
	timeprecision 1ns;
    
    logic [3:0] p0, p1, p2, p3, p4, p5, p6, p7, p8;
    logic [3:0] weight;
    sharpen dut (.*);

    initial begin
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd8,4'd8,4'd8,4'd8,4'd8,4'd8,4'd8,4'd8,4'd8}; 
        #10; 
        $display("flat: weight=%0d (expect 8)", weight);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd8,4'd7,4'd8,4'd7,4'd8,4'd7,4'd8,4'd7,4'd8}; 
        #10; 
        $display("mid detail: weight=%0d (expect 12)", weight);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd0,4'd0,4'd0,4'd0,4'd15,4'd0,4'd0,4'd0,4'd0}; 
        #10; 
        $display("bright center: weight=%0d (expect 15)", weight);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd15,4'd15,4'd15,4'd15,4'd0,4'd15,4'd15,4'd15,4'd15}; 
        #10; 
        $display("dark center: weight=%0d (expect 0)", weight);
        $finish;
    end
    
endmodule

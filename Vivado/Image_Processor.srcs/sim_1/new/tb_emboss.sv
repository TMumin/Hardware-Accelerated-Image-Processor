`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2026 11:44:29 PM
// Design Name: 
// Module Name: tb_emboss
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


module tb_emboss();
    timeunit 10ns;
	timeprecision 1ns;
    
    logic [3:0] p0, p1, p2, p3, p4, p5, p6, p7, p8;
    logic [3:0] weight;
    emboss dut (.*);

    initial begin
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd12,4'd12,4'd12,4'd12,4'd12,4'd12,4'd12,4'd12,4'd12}; 
        #10; 
        $display("flat 12: weight=%0d (expect 15)", weight);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd4,4'd4,4'd4,4'd4,4'd4,4'd4,4'd4,4'd4,4'd4}; 
        #10; 
        $display("flat 4: weight=%0d (expect 12)", weight);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd0,4'd0,4'd0,4'd0,4'd0,4'd15,4'd0,4'd15,4'd15}; 
        #10; 
        $display("bright bottom-right: weight=%0d (expect 15)", weight);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd15,4'd15,4'd0,4'd15,4'd0,4'd0,4'd0,4'd0,4'd0}; 
        #10; 
        $display("bright top-left: weight=%0d (expect 0)", weight);
        $finish;
    end
    
endmodule

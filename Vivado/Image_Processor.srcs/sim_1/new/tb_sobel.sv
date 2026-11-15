`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2026 09:51:39 PM
// Design Name: 
// Module Name: tb_sobel
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


module tb_sobel();
    timeunit 10ns;
	timeprecision 1ns;
    
    logic [3:0] p0, p1, p2, p3, p4, p5, p6, p7, p8;
    logic edge_out;
    sobel dut (.*);

    initial begin
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd0,4'd0,4'd0,4'd0,4'd0,4'd0,4'd0,4'd0,4'd0}; 
        #10; 
        $display("Gx=%0d Gy=%0d mag=%0d", dut.Gx, dut.Gy, dut.mag);
        $display("flat window: edge_out=%0d (expect 0)", edge_out);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd0,4'd0,4'd10,4'd0,4'd0,4'd10,4'd0,4'd0,4'd10}; 
        #10; 
        $display("Gx=%0d Gy=%0d mag=%0d", dut.Gx, dut.Gy, dut.mag);
        $display("vertical edge: edge_out=%0d (expect 1)", edge_out);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd0,4'd0,4'd0,4'd0,4'd0,4'd0,4'd10,4'd10,4'd10}; 
        #10; 
        $display("Gx=%0d Gy=%0d mag=%0d", dut.Gx, dut.Gy, dut.mag);
        $display("horizontal edge: edge_out=%0d (expect 1)", edge_out);
        {p0,p1,p2,p3,p4,p5,p6,p7,p8} = {4'd0,4'd0,4'd0,4'd0,4'd10,4'd10,4'd0,4'd10,4'd10}; 
        #10; 
        $display("Gx=%0d Gy=%0d mag=%0d", dut.Gx, dut.Gy, dut.mag);
        $display("diagonal edge: edge_out=%0d (expect 1)", edge_out);
        $finish;
    end
   
endmodule

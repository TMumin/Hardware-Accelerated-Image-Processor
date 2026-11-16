`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2026 12:22:56 AM
// Design Name: 
// Module Name: tb_window_generator
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


module tb_window_generator();
    timeunit 10ns;
	timeprecision 1ns;
	
    logic       clk = 0, rst, en;
    logic [3:0] din;
    logic [3:0] p0, p1, p2, p3, p4, p5, p6, p7, p8;

    window_generator dut (.*);
    always #5 clk = ~clk;

    logic [3:0]  img [5][640];
    logic [35:0] got, expd;
    int          errors = 0;

    task check(input int r, c);
        if (r >= 2 && c >= 2) begin
            got  = {p0,p1,p2,p3,p4,p5,p6,p7,p8};
            expd = {img[r-2][c-2], img[r-2][c-1], img[r-2][c],
                    img[r-1][c-2], img[r-1][c-1], img[r-1][c],
                    img[r  ][c-2], img[r  ][c-1], img[r  ][c]};
            if (got !== expd) begin
                errors++;
                if (errors <= 5)
                    $display("MISMATCH (r=%0d, c=%0d): got %h, expected %h", r, c, got, expd);
            end
        end
    endtask

    task push(input int r, c);
        din = img[r][c];
        en  = 1;
        @(posedge clk); #1;      // window registers update on this edge
        check(r, c);
    endtask

    initial begin
        for (int y = 0; y < 5; y++)
            for (int x = 0; x < 640; x++)
                img[y][x] = $urandom_range(0, 15);

        rst = 1; en = 0; din = 0;
        repeat (3) @(posedge clk);
        #1 rst = 0;

        for (int y = 0; y < 5; y++) begin
            for (int x = 0; x < 640; x++)
                push(y, x);
            en = 0;
            repeat (8) @(posedge clk);   // blanking gap
            #1;
        end

        if (errors == 0) $display("PASS: all windows match");
        else             $display("FAIL: %0d mismatches", errors);
        $finish;
    end

endmodule

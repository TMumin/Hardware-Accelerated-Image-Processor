`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2026 12:00:11 AM
// Design Name: 
// Module Name: image_rom
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


module image_rom (
    input  logic        clk,
    input  logic [16:0] addr, addr_w,
    output logic [11:0] data, data_w
);
    (* ram_style = "block" *) logic [11:0] mem [0:76799];

    initial $readmemh("image.mem", mem);

    always_ff @(posedge clk) begin
        data <= mem[addr];   // 1 cycle of read latency
        data_w <= mem[addr_w];   // 1 cycle of read latency
    end
endmodule

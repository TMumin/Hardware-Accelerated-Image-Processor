`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 09:44:45 PM
// Design Name: 
// Module Name: top_level
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


module top_level(
    input logic Clk,
    input logic reset_rtl_0,
    
    //USB signals
    input logic [0:0] gpio_usb_int_tri_i,
    output logic gpio_usb_rst_tri_o,
    input logic usb_spi_miso,
    output logic usb_spi_mosi,
    output logic usb_spi_sclk,
    output logic usb_spi_ss,
    
    //UART
    input logic uart_rtl_0_rxd,
    output logic uart_rtl_0_txd,
    
    //HDMI
    output logic hdmi_tmds_clk_n,
    output logic hdmi_tmds_clk_p,
    output logic [2:0]hdmi_tmds_data_n,
    output logic [2:0]hdmi_tmds_data_p
    );
    
    logic [31:0] keycode0_gpio, keycode1_gpio;
    logic clk_25MHz, clk_125MHz, clk, clk_100MHz;
    logic locked;
    logic [9:0] drawX, drawY;

    logic hsync, vsync, vde;
    logic [3:0] red_raw, green_raw, blue_raw;
    logic reset_ah;
    
    logic hsync_d, vsync_d, vde_d;
    logic [3:0] red_filtered, green_filtered, blue_filtered;
    
    assign reset_ah = reset_rtl_0;
    
    always_ff @ (posedge clk_25MHz) begin
        hsync_d <= hsync;
        vsync_d <= vsync;
        vde_d <= vde;
    end
    
    mb_block mb_block_i (
        .clk_100MHz(Clk),
        .gpio_usb_int_tri_i(gpio_usb_int_tri_i),
        .gpio_usb_keycode_0_tri_o(keycode0_gpio),
        .gpio_usb_keycode_1_tri_o(keycode1_gpio),
        .gpio_usb_rst_tri_o(gpio_usb_rst_tri_o),
        .reset_rtl_0(~reset_ah), //Block designs expect active low reset, all other modules are active high
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd),
        .usb_spi_miso(usb_spi_miso),
        .usb_spi_mosi(usb_spi_mosi),
        .usb_spi_sclk(usb_spi_sclk),
        .usb_spi_ss(usb_spi_ss)
    );
        
    //clock wizard configured with a 1x and 5x clock for HDMI
    clk_wiz_0 clk_wiz (
        .clk_out1(clk_25MHz),
        .clk_out2(clk_125MHz),
        .reset(reset_ah),
        .locked(locked),
        .clk_in1(Clk)
    );
    
    //VGA Sync signal generator
    vga_controller vga (
        .pixel_clk(clk_25MHz),
        .reset(reset_ah),
        .hs(hsync),
        .vs(vsync),
        .active_nblank(vde),
        .drawX(drawX),
        .drawY(drawY)
    );    

    //Real Digital VGA to HDMI converter
    hdmi_tx_0 vga_to_hdmi (
    
        //Clocking and Reset
        .pix_clk(clk_25MHz),
        .pix_clkx5(clk_125MHz),
        .pix_clk_locked(locked),
        .rst(reset_ah),
        
        //Color and Sync Signals
        .red(red_filtered),
        .green(green_filtered),
        .blue(blue_filtered),
        .hsync(hsync_d),
        .vsync(vsync_d),
        .vde(vde_d),
        
        //aux Data (unused)
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //Differential outputs
        .TMDS_CLK_P(hdmi_tmds_clk_p),          
        .TMDS_CLK_N(hdmi_tmds_clk_n),          
        .TMDS_DATA_P(hdmi_tmds_data_p),         
        .TMDS_DATA_N(hdmi_tmds_data_n)          
    );
    
    logic [16:0] addr;
    logic [11:0] pix;

    assign addr = drawY[9:1] * 320 + drawX[9:1];
    
    assign red_raw = pix[11:8];
    assign green_raw = pix[7:4];
    assign blue_raw = pix[3:0];
    
    //Image Rom Module
    image_rom image_rom_i(
        .clk(clk_25MHz),
        .addr(addr),
        .data(pix)
    );
    
    logic [3:0] gray;
    
    //Grayscale Module
    grayscale grayscale_i(
        .r(red_raw),
        .g(green_raw),
        .b(blue_raw),
        .z(gray)
    );
    
    //Filter selection MUX
    logic [7:0] keycode, keycode_meta, keycode_last;
    
    always_comb begin
        unique case (keycode_last)
            8'h14: {red_filtered, green_filtered, blue_filtered} = {red_raw, green_raw, blue_raw};
            8'h1a: {red_filtered, green_filtered, blue_filtered} = {gray, gray, gray};
            default: {red_filtered, green_filtered, blue_filtered} = {red_raw, green_raw, blue_raw};
        endcase
    end
    
    always_ff @(posedge clk_25MHz) begin
        keycode_meta <= keycode0_gpio[7:0];
        keycode <= keycode_meta;
    
        if (reset_ah)
            keycode_last <= 8'h14;
        else if (keycode == 8'h14 || keycode == 8'h1a)
            keycode_last <= keycode;
    end
    
    
endmodule

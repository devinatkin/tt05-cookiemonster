`timescale 1ns/1ps

module vga_controller(
    input wire clk,
    input wire rst_n,
    input wire enable,
    input wire [1:0] red_pixel_in,
    input wire [1:0] green_pixel_in,
    input wire [1:0] blue_pixel_in,
    output wire hs,
    output wire vs,
    output wire [9:0] xcoor,
    output wire [9:0] ycoor,
    output wire display_active,
    output wire [1:0] red_pixel_out,
    output wire [1:0] green_pixel_out,
    output wire [1:0] blue_pixel_out
);

    wire active;
    wire [1:0] red_pixel;
    wire [1:0] green_pixel;
    wire [1:0] blue_pixel;

    wire [9:0] x;
    wire [9:0] y;

    // VGA Timing Generator
    vga_timing_gen vga_timing(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .hs(hs),
        .vs(vs),
        .x(x),
        .y(y),
        .active(active)
    );

    // RGB Active Output Control
    rgb_active output_control(
        .active(active),
        .red_pixel(red_pixel),
        .green_pixel(green_pixel),
        .blue_pixel(blue_pixel),
        .vga_out({red_pixel_out, green_pixel_out, blue_pixel_out})
    );

    // VGA Coordinate Calculator
    VGA_Coord_Calc xy_calc (
        .x(x),
        .y(y),
        .clk(clk),
        .rst_n(rst_n),
        .xcoor(xcoor),
        .ycoor(ycoor)
    );

    assign red_pixel = red_pixel_in;
    assign green_pixel = green_pixel_in;
    assign blue_pixel = blue_pixel_in;
    assign display_active = active;
endmodule

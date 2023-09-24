`timescale 1ns / 1ps

module tb_vga_ram_display;

    // Declare signals
    reg clk;
    reg rst_n;
    reg [9:0] xcoor;
    reg [9:0] ycoor;
    wire [1:0] red;
    wire [1:0] green;
    wire [1:0] blue;

    // Instantiate the vga_ram_display module
    vga_ram_display uut (
        .clk(clk),
        .rst_n(rst_n),
        .xcoor(xcoor),
        .ycoor(ycoor),
        .red(red),
        .green(green),
        .blue(blue)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        xcoor = 0;
        ycoor = 0;

        // Apply reset
        #10 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;

        // Test coordinates inside the center square
        xcoor = 130; ycoor = 50;
        #10;
        $display("Inside square: Red=%b, Green=%b, Blue=%b", red, green, blue);

        // Test coordinates outside the center square
        xcoor = 600; ycoor = 450;
        #10;
        $display("Outside square: Red=%b, Green=%b, Blue=%b", red, green, blue);

        // End simulation
        $finish;
    end

endmodule

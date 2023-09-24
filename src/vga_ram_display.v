`timescale 1ns/1ps

module vga_ram_display (
    input clk,          // Clock signal
    input rst_n,        // Active-low reset signal
    input [9:0] xcoor,  // X-coordinate on VGA frame
    input [9:0] ycoor,  // Y-coordinate on VGA frame
    output reg [1:0] red,   // Red color output
    output reg [1:0] green, // Green color output
    output reg [1:0] blue   // Blue color output
);

    // Declare signals for RAM
    reg [3:0] x_ram;
    reg [3:0] y_ram;
    reg write_enable = 0; // No write operation in this example
    reg write_data = 0;   // No data to write in this example
    wire read_data;

    // Instantiate the 16x16 RAM
    ram_16x16 ram_inst (
        .clk(clk),
        .rst_n(rst_n),
        .x(x_ram),
        .y(y_ram),
        .write_enable(write_enable),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Calculate the center square coordinates
    always @(posedge clk) begin
        if (xcoor >= 192 && xcoor < 448 && ycoor >= 112 && ycoor < 368) begin
            x_ram <= (((xcoor)-120)/16);
            y_ram <= ((ycoor-40)/16);
        end
    end

    // Generate VGA output
    always @(posedge clk) begin
        if (xcoor >= 120 && xcoor < 520 && ycoor >= 40 && ycoor < 440) begin
            // Inside the center square
            if (read_data) begin
                red <= 2'b11; // White
                green <= 2'b11;
                blue <= 2'b11;
            end else begin
                red <= 2'b00; // Black
                green <= 2'b00;
                blue <= 2'b00;
            end
        end else begin
            // Outside the center square
            red <= 2'b11; // White
            green <= 2'b11;
            blue <= 2'b11;
        end
    end

endmodule

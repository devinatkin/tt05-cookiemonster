`timescale 1ns/1ps

module ram_16x16 (
    input clk,          // Clock signal
    input rst_n,        // Active-low reset signal
    input [3:0] x,      // X-coordinate
    input [3:0] y,      // Y-coordinate
    input write_enable, // Write enable signal for write port
    input write_data,   // Data to write
    output reg read_data // Data read from RAM
);

    // Declare a 16x16 RAM as a 2D array
    reg [0:0] ram [15:0][15:0];

    // Write port
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset RAM to all zeros
            integer i, j;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    ram[i][j] <= 1'b0;
                end
            end
        end else if (write_enable) begin
            // Write data to RAM at location (x, y)
            ram[x][y] <= write_data;
        end
    end

    // Read port
    always @(posedge clk) begin
        // Read data from RAM at location (x, y)
        read_data <= ram[x][y];
    end

endmodule

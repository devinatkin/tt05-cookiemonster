`timescale 1ns / 1ps

module tb_ram_16x16;

    // Declare signals
    reg clk;
    reg rst_n;
    reg [3:0] x;
    reg [3:0] y;
    reg write_enable;
    reg write_data;
    wire read_data;

    // Instantiate the RAM module
    ram_16x16 uut (
        .clk(clk),
        .rst_n(rst_n),
        .x(x),
        .y(y),
        .write_enable(write_enable),
        .write_data(write_data),
        .read_data(read_data)
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
        x = 4'b0;
        y = 4'b0;
        write_enable = 0;
        write_data = 0;

        // Apply reset
        #10 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;

        // Write data to RAM
        x = 4'b0001; y = 4'b0010; write_enable = 1; write_data = 1;
        #10;

        // Read data from RAM
        x = 4'b0001; y = 4'b0010; write_enable = 0;
        #10;
        $display("Read data at (1, 2): %b", read_data);

        // Write data to another location in RAM
        x = 4'b0100; y = 4'b0101; write_enable = 1; write_data = 1;
        #10;

        // Read data from the new location
        x = 4'b0100; y = 4'b0101; write_enable = 0;
        #10;
        $display("Read data at (4, 5): %b", read_data);

        // End simulation
        $finish;
    end

endmodule

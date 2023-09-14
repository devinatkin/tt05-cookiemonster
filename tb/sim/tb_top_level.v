`timescale 1ns/1ps

module tb_tt_um_devinatkin_cookiemonster;

    reg [7:0] ui_in;           // Input switches
    wire [7:0] uo_out;         // 7-segment display output
    reg [7:0] uio_in;          // Bidirectional IOs: Input
    wire [7:0] uio_out;        // Bidirectional IOs: Output
    wire [7:0] uio_oe;         // Bidirectional IOs: Output Enable
    reg ena;                   // Enable signal
    reg clk;                   // Clock
    reg rst_n;                 // Reset_n

    // Instantiate the DUT (Device Under Test)
    tt_um_devinatkin_cookiemonster DUT (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock generation
    // A 50 MHz clock has a period of 20ns (1/50e6 = 20e-9)
    always begin
        #10 clk = ~clk;  // Invert the clock every 10ns, giving a 20ns period (50 MHz)
    end

    // VCD file for GTKWave
    initial begin
        $dumpfile("top.vcd");
        $dumpvars(0, tb_tt_um_devinatkin_cookiemonster);
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        ena = 0;
        ui_in = 8'b00000000;
        uio_in = 8'b00000000;

        // Apply reset
        #20 rst_n = 1;

        // Enable the design
        ena = 1;

        // Run for some cycles to observe randomness
        #200;


        $display("Starting test sequence");
        $display("No test sequence implemented");
        $finish;
    end
endmodule

`timescale 1ns / 1ps

module tb_lfsr_64bit;

    reg clk;
    reg rst_n;
    reg en;
    wire [15:0] rnd_number;

    // Instantiate the lfsr_64bit module
    lfsr_64bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .rnd_number(rnd_number)
    );

    // Clock Generation
    always begin
        #5 clk = ~clk;
    end

    // VCD file for GTKWave
    initial begin
        $dumpfile("lfsr_64bit.vcd");
        $dumpvars(0, tb_lfsr_64bit);
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        en = 0;

        // Apply reset
        rst_n = 0;
        #10;
        
        // De-assert reset and enable LFSR
        rst_n = 1;
        en = 1;

        // Run for some cycles to observe randomness
        #200;

        // Disable and observe
        en = 0;
        #50;

        // Re-enable and observe
        en = 1;
        #150;

        // End of test
        $finish;
    end

endmodule

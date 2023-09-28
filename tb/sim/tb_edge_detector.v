module tb_edge_detector();

    // Declare signals
    reg clk;
    reg rst_n;
    reg signal_in;
    wire rising_out;
    wire falling_out;

    // Instantiate the edge_detector module
    edge_detector uut (
        .clk(clk),
        .rst_n(rst_n),
        .signal_in(signal_in),
        .rising_out(rising_out),
        .falling_out(falling_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("tb_edge_detector.vcd");
        $dumpvars(0,tb_edge_detector);
    end

    // Testbench logic
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        signal_in = 0;

        // Apply reset
        #10 rst_n = 1;

        // Test rising edge detection
        #100 signal_in = 1;
        #100 signal_in = 0;
        #100 signal_in = 1;

        // Test falling edge detection
        #100 signal_in = 0;
        #100 signal_in = 1;
        #100 signal_in = 0;

        // End simulation
        $finish;
    end

    // Monitor output signals
    initial begin
        $monitor("At time %t, rising_out = %b, falling_out = %b", $time, rising_out, falling_out);
    end

endmodule

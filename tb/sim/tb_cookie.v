`timescale 1ns / 1ps

module tb_cookie();

    reg clk;  // Clock signal
    reg rst_n; // Active-low reset signal
    reg en;  // Enable signal
    reg run;  // Run signal
    reg display;  // Display out signal (Pulse to display the crumb)
    reg input_bit;  // Input to the shift register
    reg display_shift_in;  // Display input to the shift register
    wire output_bit; // Output from the shift register
    wire display_shift_out; // Display output from the shift register

    // Instantiate the module
    cookie uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .run(run),
        .display(display),
        .input_bit(input_bit),
        .display_shift_in(display_shift_in),
        .output_bit(output_bit),
        .display_shift_out(display_shift_out)
    );

    // Clock Generation
    always begin
        #5 clk = ~clk;
    end

    // Test Scenarios
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        en = 0;
        run = 0;
        display = 0;
        input_bit = 0;
        display_shift_in = 0;

        // Apply Reset
        rst_n = 0;
        #10;
        rst_n = 1;

        // Enable the cookie and run Conway's game of life rules
        en = 1;
        run = 1;
        // Assuming you have some way of checking the internal state, you could inject a known pattern here and verify the next state.
        #10;
        
        // Test display functionality
        run = 0;
        display = 1;
        #10;
        
        // Test shift register functionality
        run = 0;
        display = 0;
        input_bit = 1;
        display_shift_in = 1;
        #10;

        // Validate output matches input
        // Assuming you have some way of checking the internal state or output bits

        $finish;
    end
endmodule

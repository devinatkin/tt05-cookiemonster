`timescale 1ns / 1ps

module tb_crumb();

    reg clk;  // Clock signal
    reg rst_n; // Active-low reset signal
    reg en;  // Enable signal
    reg run;  // Run signal
    reg display;  // Display out signal (Pulse to display the crumb)
    reg [7:0] nearest_neighbors; // Input bits from the nearest neighbors
    reg in_shift;  // Shift signal
    wire out_shift;  // Output bit to the shift register
    wire [1:0] state; // Output indicating the crumb state
    reg display_shift_in;
    wire display_shift_out;

    // Instantiate the module
    crumb uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .run(run),
        .display(display),
        .nearest_neighbors(nearest_neighbors),
        .in_shift(in_shift),
        .out_shift(out_shift),
        .state(state),
        .display_shift_in(display_shift_in),
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
        nearest_neighbors = 8'b0;
        in_shift = 0;
        display_shift_in = 0;

        // Apply Reset
        rst_n = 0;
        #10;
        rst_n = 1;

        // Enable the crumb and run Conway's game of life rules
        en = 1;
        run = 1;
        nearest_neighbors = 8'b00101100; // 2 alive neighbors
        #10;
        $display("state should be dead: %b", state);
        
        nearest_neighbors = 8'b01101100; // 3 alive neighbors
        #10;
        $display("state should be alive: %b", state);
        
        nearest_neighbors = 8'b11101100; // 5 alive neighbors
        #10;
        $display("state should be dead: %b", state);

        // Disable Conway's game of life and test as shift register
        run = 0;
        in_shift = 1;
        #10;
        $display("Out shift should match in_shift: %b", out_shift);

        $finish;
    end
endmodule

`timescale 1ns/1ps

module edge_detector (
    input wire clk,          // Clock input
    input wire rst_n,        // Active-low reset
    input wire signal_in,    // Signal to detect edges on
    output reg rising_out,   // Output for rising edge detection
    output reg falling_out   // Output for falling edge detection
);

    // Internal signal to hold previous state
    reg signal_in_prev;

    // Always block triggered on the positive edge of clk or negative edge of rst_n
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset condition
            rising_out <= 1'b0;
            falling_out <= 1'b0;
            signal_in_prev <= 1'b0;
        end else begin
            // Edge detection logic
            rising_out <= (signal_in && !signal_in_prev);
            falling_out <= (!signal_in && signal_in_prev);

            // Update previous state of signal_in
            signal_in_prev <= signal_in;
        end
    end

endmodule

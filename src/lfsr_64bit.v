`timescale 1ns / 1ps

module lfsr_64bit (
    input wire clk,      // Clock signal
    input wire rst_n,    // Active-low reset signal
    input wire en,       // Enable signal
    output reg [15:0] rnd_number  // 16-bit Random number output
);

    reg [63:0] lfsr;  // 64-bit Linear Feedback Shift Register

    // Polynomial for 64-bit LFSR based on maximum-length sequence properties.
    // The polynomial chosen is: x^64 + x^4 + x^3 + x + 1
    // Feedback term is XOR of bit 63, 3, 2, and 0.
    wire feedback = lfsr[63] ^ lfsr[3] ^ lfsr[2] ^ lfsr[0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr <= 64'h1;  // Non-zero initial state
            rnd_number <= 16'h0;
        end else if (en) begin
            lfsr <= {lfsr[62:0], feedback};  // Shift and apply feedback
            rnd_number <= lfsr[15:0];        // Take lower 16 bits as output random number
        end
    end

endmodule

`timescale 1ns/1ps

// 256-bit SISO Shift Register Implementation in Verilog
module shift_register_256(
    input wire clk,        // Clock Signal
    input wire rst_n,      // Active-Low Reset
    input wire en,         // Enable Signal
    input wire din,        // 1-bit Data Input
    input wire shift_dir,  // Shift Direction (0 for left, 1 for right)
    output reg dout        // 1-bit Data Output
);

    // Initialize the 256-bit internal shift register
    reg [255:0] shift_reg = 256'd0;

    // Clock Sensitive Process
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset the shift register when reset signal is active
            shift_reg <= 256'd0;
        end else if (en) begin
            // Perform shift operation when enabled
            if (shift_dir == 0) begin
                // Left-Shift Operation
                shift_reg <= {shift_reg[254:0], din};
            end else begin
                // Right-Shift Operation
                shift_reg <= {din, shift_reg[255:1]};
            end
            dout <= shift_dir ? shift_reg[0] : shift_reg[255];
        end
    end

endmodule

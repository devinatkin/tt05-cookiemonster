`timescale 1ns / 1ps

module crumb(
input wire clk,         // Clock signal
input wire rst_n,       // Active-low reset signal
input wire en,          // Enable signal
input wire rbit,        // Random bit
output reg clk_o,       // Clock output
output reg rst_no,      // Reset output
output reg en_o,        // Enable output
output reg rbit_o       // Random bit output

);

always@(posedge clk) begin
    if (!rst_n) begin           // Reset Event
        clk_o <= 1'b0;          // Reset clock
        rst_no <= 1'b0;         // Reset reset
        rbit_o <= 1'b0;         // Reset random bit
        en_o <= 1'b0;           // Reset enable
    end else if (en) begin
        clk_o <= ~clk_o;
        rst_no <= ~rst_no;
        rbit_o <= rbit;
        en_o <= en;
    end
end

endmodule
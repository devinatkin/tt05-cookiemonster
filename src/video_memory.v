`timescale 1ns/1ps

module fifo_1bit_256depth (
    input clk,          // Clock signal
    input enable,       // Enable signal
    input rst_n,        // Reset (Active Low)
    input data_in,      // 1-bit data input
    output reg data_out // 1-bit data output
);

  reg [255:0] fifo_memory; // Internal FIFO memory, 256 entries each 1-bit wide
  reg [7:0] wr_ptr = 8'h0; // Write pointer
  reg [7:0] rd_ptr = 8'h0; // Read pointer
  reg empty = 1;           // FIFO empty flag
  reg full  = 0;           // FIFO full flag
  
  // Update FIFO status and pointers
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_ptr <= 8'h0;
      rd_ptr <= 8'h0;
      empty <= 1;
      full <= 0;
    end else if (enable) begin
      if (!full) begin
        fifo_memory[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
      end

      if (!empty) begin
        data_out <= fifo_memory[rd_ptr];
        rd_ptr <= rd_ptr + 1;
      end

      full <= (wr_ptr == rd_ptr - 1) || (wr_ptr == 255 && rd_ptr == 0);
      empty <= (wr_ptr == rd_ptr);
    end
  end
endmodule

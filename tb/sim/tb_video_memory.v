module tb_fifo_1bit_256depth();

  reg clk;
  reg enable;
  reg rst_n;
  reg data_in;
  wire data_out;

  // Instantiate the FIFO module
  fifo_1bit_256depth uut (
    .clk(clk),
    .enable(enable),
    .rst_n(rst_n),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    enable = 0;
    rst_n = 0;
    data_in = 1'b0;

    // Apply reset
    #10 rst_n = 0;
    #10 rst_n = 1;
    
    // Test Case 1: Write to FIFO and read back
    enable = 1;
    data_in = 1'b1;
    #10;
    $display("Data out after write-read operation 1: %b", data_out);
    
    // Test Case 2: Write another value to FIFO and read back
    data_in = 1'b0;
    #10;
    $display("Data out after write-read operation 2: %b", data_out);

    // Finish simulation
    $finish;
  end

endmodule

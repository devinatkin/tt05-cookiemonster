// Testbench for 256-bit SISO Shift Register
module tb_shift_register_256;

  reg clk;                // Clock Signal
  reg rst_n;              // Active-Low Reset
  reg en;                 // Enable Signal
  reg din;                // 1-bit Data Input
  reg shift_dir;          // Shift Direction (0 for left, 1 for right)
  wire dout;              // 1-bit Data Output

  // Instantiate the shift_register_256 module
  shift_register_256 uut (
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .din(din),
    .shift_dir(shift_dir),
    .dout(dout)
  );

  // Clock Generation
  always begin
    #5 clk = ~clk;
  end

// VCD file for GTKWave
initial begin
    $dumpfile("shift_register_sim.vcd");
    $dumpvars(0,tb_shift_register_256);
end

  // Test Sequence
  initial begin
    // Initialize Signals
    clk = 0;
    rst_n = 0;
    en = 0;
    din = 0;
    shift_dir = 0;

    // Apply Reset
    #10 rst_n = 1;

    // Test Left Shift
    en = 1;
    shift_dir = 0;
    #10 din = 1; // Test input 1
    #10 din = 0;
    #10 din = 1;
    #10 din = 0;
    #3000;

    // Test Right Shift
    shift_dir = 1;
    #10 din = 0;
    #10 din = 1;
    #10 din = 0;
    // ... Add more test vectors

    // Complete Test
    $finish;
  end

endmodule

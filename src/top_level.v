`timescale 1ns/1ps

module tt_um_devinatkin_cookiemonster
(
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire [15:0] rnd_number;

    // Instantiate the lfsr_64bit module
    lfsr_64bit rng (
        .clk(clk),
        .rst_n(rst_n),
        .en(ena),
        .rnd_number(rnd_number)
    );

    cookie machine (
        .clk(clk),
        .rst_n(rst_n),
        .en(ena),
        .rbit(rnd_number[0]),
        .rbit_o(uo_out[0])
    );

    assign uio_oe = 8'b11111111;    // Enable all IOs as outputs
    assign uio_out = rnd_number[7:0];   // Set all IOs to the random number
    assign uo_out[7:1] = 7'b0000000;    // Set all outputs to 0
    
endmodule
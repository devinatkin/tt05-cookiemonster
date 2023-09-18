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
    wire run;
    wire display;
    wire input_bit;
    wire display_shift_in;
    wire output_bit;
    wire display_shift_out;

    // Instantiate the lfsr_64bit module
    lfsr_64bit rng (
        .clk(clk),
        .rst_n(rst_n),
        .en(ena),
        .rnd_number(rnd_number)
    );

    cookie cookie_monster (
        .clk(clk),
        .rst_n(rst_n),
        .en(ena),
        .run(run),
        .display(display),
        .input_bit(input_bit),
        .display_shift_in(display_shift_in),
        .output_bit(output_bit),
        .display_shift_out(display_shift_out)
    );

    assign uio_oe = 8'b11111111;    // Enable all IOs as outputs
    assign uio_out = rnd_number[7:0];   // Set all IOs to the random number
    assign uo_out[7:3] = 7'b0000000;    // Set all outputs to 0
    assign run = ui_in[0];              // Set the run signal to the first input
    assign display = ui_in[1];          // Set the display signal to the second input
    assign input_bit = ui_in[2];        // Set the input bit to the third input
    assign display_shift_in = ui_in[3]; // Set the display shift in to the fourth input
    assign uo_out[1] = output_bit;      // Set the output bit to the second output
    assign uo_out[2] = display_shift_out;   // Set the display shift out to the third output
    assign uo_out[0] = 1'b1;    // Set the display shift in to the first output
endmodule
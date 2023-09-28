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
    wire videodata_out;
    wire videodata_in;

    wire hs;
    wire vs;

    wire [9:0] x;
    wire [9:0] y;

    wire [9:0] xcoor;
    wire [9:0] ycoor;

    wire [1:0] red;
    wire [1:0] green;
    wire [1:0] blue;

    wire [1:0] red_pixel_out;
    wire [1:0] green_pixel_out;
    wire [1:0] blue_pixel_out;

    wire active;
    wire write_enable;
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

    // Instantiate the vga_ram_display module
    vga_ram_display video_memory (
        .clk(clk),
        .rst_n(rst_n),
        .xcoor(xcoor),
        .ycoor(ycoor),
        .write_enable(write_enable),
        .write_data(videodata_in),
        .red(red),
        .green(green),
        .blue(blue)
    );

    vga_controller vga_ctrl_instance(
        .clk(clk),
        .rst_n(rst_n),
        .enable(ena),
        .red_pixel_in(red),
        .green_pixel_in(green),
        .blue_pixel_in(blue),
        .hs(hs),
        .vs(vs),
        .display_active(active)
        .xcoor(xcoor),
        .ycoor(ycoor),
        .red_pixel_out(red_pixel_out),
        .green_pixel_out(green_pixel_out),
        .blue_pixel_out(blue_pixel_out)
    );

    assign videodata_in = rnd_number [4];
    assign uio_oe = 8'b11111111;    // Enable all IOs as outputs
    assign uio_out[7:2] = rnd_number[7:2];   // Set all IOs to the random number
    assign uo_out[1:0] = red_pixel_out; // Set the red pixel to the first two outputs
    assign uo_out[3:2] = green_pixel_out;   // Set the green pixel to the third and fourth outputs
    assign uo_out[5:4] = blue_pixel_out;    // Set the blue pixel to the fifth and sixth outputs
    assign run = ui_in[0];              // Set the run signal to the first input
    assign display = ui_in[1];          // Set the display signal to the second input
    assign input_bit = ui_in[2];        // Set the input bit to the third input
    assign display_shift_in = ui_in[3]; // Set the display shift in to the fourth input
    assign uo_out[6] = output_bit;      // Set the output bit to the second output
    assign uo_out[7] = display_shift_out;   // Set the display shift out to the third output
    assign uio_out[0] = hs;             // Set the horizontal sync to the first IO
    assign uio_out[1] = vs;             // Set the vertical sync to the second IO
endmodule
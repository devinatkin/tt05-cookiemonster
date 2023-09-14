`timescale 1ns / 1ps

module cookie (
    input wire clk,      // Clock signal
    input wire rst_n,    // Active-low reset signal
    input wire en,       // Enable signal
    input wire rbit,     // Random bit input
    output reg rbit_o    // Random bit output
);

    wire [3:0] clk_int [3:0];
    wire [3:0] rst_n_int [3:0];
    wire [3:0] en_int [3:0];
    wire [3:0] rbit_int [3:0];

    assign rbit_o = rbit_int[3][3];

    // Manually instantiate the corner crumb module
    crumb u00 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .rbit(rbit),
        .clk_o(clk_int[0][0]),
        .rst_no(rst_n_int[0][0]),
        .en_o(en_int[0][0]),
        .rbit_o(rbit_int[0][0])
    );

    // First row (i = 0)
    crumb u01 (.clk(clk_int[0][0]), .rst_n(rst_n_int[0][0]), .en(en_int[0][0]), .rbit(rbit_int[0][0]), .clk_o(clk_int[0][1]), .rst_no(rst_n_int[0][1]), .en_o(en_int[0][1]), .rbit_o(rbit_int[0][1]));
    crumb u02 (.clk(clk_int[0][1]), .rst_n(rst_n_int[0][1]), .en(en_int[0][1]), .rbit(rbit_int[0][1]), .clk_o(clk_int[0][2]), .rst_no(rst_n_int[0][2]), .en_o(en_int[0][2]), .rbit_o(rbit_int[0][2]));
    crumb u03 (.clk(clk_int[0][2]), .rst_n(rst_n_int[0][2]), .en(en_int[0][2]), .rbit(rbit_int[0][2]), .clk_o(clk_int[0][3]), .rst_no(rst_n_int[0][3]), .en_o(en_int[0][3]), .rbit_o(rbit_int[0][3]));

    // Second row (i = 1)
    crumb u10 (.clk(clk_int[0][0]), .rst_n(rst_n_int[0][0]), .en(en_int[0][0]), .rbit(rbit_int[0][0]), .clk_o(clk_int[1][0]), .rst_no(rst_n_int[1][0]), .en_o(en_int[1][0]), .rbit_o(rbit_int[1][0]));
    crumb u11 (.clk(clk_int[1][0]), .rst_n(rst_n_int[1][0]), .en(en_int[1][0]), .rbit(rbit_int[1][0]), .clk_o(clk_int[1][1]), .rst_no(rst_n_int[1][1]), .en_o(en_int[1][1]), .rbit_o(rbit_int[1][1]));
    crumb u12 (.clk(clk_int[1][1]), .rst_n(rst_n_int[1][1]), .en(en_int[1][1]), .rbit(rbit_int[1][1]), .clk_o(clk_int[1][2]), .rst_no(rst_n_int[1][2]), .en_o(en_int[1][2]), .rbit_o(rbit_int[1][2]));
    crumb u13 (.clk(clk_int[1][2]), .rst_n(rst_n_int[1][2]), .en(en_int[1][2]), .rbit(rbit_int[1][2]), .clk_o(clk_int[1][3]), .rst_no(rst_n_int[1][3]), .en_o(en_int[1][3]), .rbit_o(rbit_int[1][3]));

    // Third row (i = 2)
    crumb u20 (.clk(clk_int[1][0]), .rst_n(rst_n_int[1][0]), .en(en_int[1][0]), .rbit(rbit_int[1][0]), .clk_o(clk_int[2][0]), .rst_no(rst_n_int[2][0]), .en_o(en_int[2][0]), .rbit_o(rbit_int[2][0]));
    crumb u21 (.clk(clk_int[2][0]), .rst_n(rst_n_int[2][0]), .en(en_int[2][0]), .rbit(rbit_int[2][0]), .clk_o(clk_int[2][1]), .rst_no(rst_n_int[2][1]), .en_o(en_int[2][1]), .rbit_o(rbit_int[2][1]));
    crumb u22 (.clk(clk_int[2][1]), .rst_n(rst_n_int[2][1]), .en(en_int[2][1]), .rbit(rbit_int[2][1]), .clk_o(clk_int[2][2]), .rst_no(rst_n_int[2][2]), .en_o(en_int[2][2]), .rbit_o(rbit_int[2][2]));
    crumb u23 (.clk(clk_int[2][2]), .rst_n(rst_n_int[2][2]), .en(en_int[2][2]), .rbit(rbit_int[2][2]), .clk_o(clk_int[2][3]), .rst_no(rst_n_int[2][3]), .en_o(en_int[2][3]), .rbit_o(rbit_int[2][3]));

    // Fourth row (i = 3)
    crumb u30 (.clk(clk_int[2][0]), .rst_n(rst_n_int[2][0]), .en(en_int[2][0]), .rbit(rbit_int[2][0]), .clk_o(clk_int[3][0]), .rst_no(rst_n_int[3][0]), .en_o(en_int[3][0]), .rbit_o(rbit_int[3][0]));
    crumb u31 (.clk(clk_int[3][0]), .rst_n(rst_n_int[3][0]), .en(en_int[3][0]), .rbit(rbit_int[3][0]), .clk_o(clk_int[3][1]), .rst_no(rst_n_int[3][1]), .en_o(en_int[3][1]), .rbit_o(rbit_int[3][1]));
    crumb u32 (.clk(clk_int[3][1]), .rst_n(rst_n_int[3][1]), .en(en_int[3][1]), .rbit(rbit_int[3][1]), .clk_o(clk_int[3][2]), .rst_no(rst_n_int[3][2]), .en_o(en_int[3][2]), .rbit_o(rbit_int[3][2]));
    crumb u33 (.clk(clk_int[3][2]), .rst_n(rst_n_int[3][2]), .en(en_int[3][2]), .rbit(rbit_int[3][2]), .clk_o(clk_int[3][3]), .rst_no(rst_n_int[3][3]), .en_o(en_int[3][3]), .rbit_o(rbit_int[3][3]));

endmodule

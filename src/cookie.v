`timescale 1ns / 1ps

module cookie (
    input wire clk,      // Clock signal
    input wire rst_n,    // Active-low reset signal
    input wire en,       // Enable signal
    input wire rbit,      // Random bit input
    output reg rbit_o    // Random bit output
);

    wire [3:0] clk_int [3:0];
    wire [3:0] rst_n_int [3:0];
    wire [3:0] en_int [3:0];
    wire [3:0] rbit_int [3:0];

    assign rbit_o = rbit_int[3][3];
    // The corner module
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

    // Generate 4x4 array of 'crumb' modules
    genvar i, j;
    generate
        for (i = 0; i < 4; i = i + 1) begin : rows
            for (j = 0; j < 4; j = j + 1) begin : cols
                if ((i != 0) || (j != 0)) begin : not_corner
                    crumb uij (
                        .clk((i == 0) ? clk_int[i][j-1] : clk_int[i-1][j]),
                        .rst_n((i == 0) ? rst_n_int[i][j-1] : rst_n_int[i-1][j]),
                        .en((i == 0) ? en_int[i][j-1] : en_int[i-1][j]),
                        .rbit((i == 0) ? rbit_int[i][j-1] : rbit_int[i-1][j]),
                        .clk_o(clk_int[i][j]),
                        .rst_no(rst_n_int[i][j]),
                        .en_o(en_int[i][j]),
                        .rbit_o(rbit_int[i][j])
                    );
                end : not_corner
            end : cols
        end : rows
    endgenerate

endmodule

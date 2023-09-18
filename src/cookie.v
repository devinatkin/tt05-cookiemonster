`timescale 1ns / 1ps

module cookie (
    input wire clk,         // Clock signal
    input wire rst_n,       // Active-low reset signal
    input wire en,          // Enable signal
    input wire run,         // Run signal
    input wire display,     // Display out signal (Pulse to display the crumb)
    input wire input_bit,   // Input to the shift register
    input wire display_shift_in, // Display input to the shift register
    output reg output_bit,       // Output from the shift register
    output reg display_shift_out // Display output from the shift register
);

    wire[256:0] shift_values;
    wire[256:0] display_shift_values;
    wire[1:0] state_values [255:0];
    assign shift_values[0] = input_bit;
    assign display_shift_values[0] = display_shift_in;
    assign display_shift_out = display_shift_values[255];
    assign output_bit = shift_values[255];
    generate
        genvar i, j;
        for(i = 0; i < 16; i=i+1) begin
            for(j = 0; j < 16; j=j+1) begin
                localparam idx = (i * 16) + j;
                localparam y_cor = i;
                localparam x_cor = j;
                wire left_element;
                wire right_element;
                wire up_element;
                wire down_element;
                wire up_left_element;
                wire up_right_element;
                wire down_left_element;
                wire down_right_element;

                if(x_cor > 0) begin // If the x coordinate is greater than 0 then the left element is the element to the left of the current element
                    assign left_element = state_values[idx - 1][0];
                end else begin
                    assign left_element = 1'b0;
                end
                if(x_cor < 15) begin // If the x coordinate is less than 15 then the right element is the element to the right of the current element
                    assign right_element = state_values[idx + 1][0];
                end else begin
                    assign right_element = 1'b0;
                end
                if(y_cor > 0) begin // If the y coordinate is greater than 0 then the up element is the element above the current element
                    assign up_element = state_values[idx - 16][0];
                    if(x_cor > 0) begin // If the x coordinate is greater than 0 then the up left element is the element above and to the left of the current element
                        assign up_left_element = state_values[idx - 17][0];
                    end else begin
                        assign up_left_element = 1'b0;
                    end
                    if(x_cor < 15) begin // If the x coordinate is less than 15 then the up right element is the element above and to the right of the current element
                        assign up_right_element = state_values[idx - 15][0];
                    end else begin
                        assign up_right_element = 1'b0;
                    end
                end else begin
                    assign up_element = 1'b0;
                    assign up_left_element = 1'b0;
                    assign up_right_element = 1'b0;
                end
                if(y_cor < 15) begin // If the y coordinate is less than 15 then the down element is the element below the current element
                    assign down_element = state_values[idx + 16][0];
                    if(x_cor > 0) begin // If the x coordinate is greater than 0 then the down left element is the element below and to the left of the current element
                        assign down_left_element = state_values[idx + 15][0];
                    end else begin
                        assign down_left_element = 1'b0;
                    end
                    if(x_cor < 15) begin // If the x coordinate is less than 15 then the down right element is the element below and to the right of the current element
                        assign down_right_element = state_values[idx + 17][0];
                    end else begin
                        assign down_right_element = 1'b0;
                    end
                end else begin
                    assign down_left_element = 1'b0;
                    assign down_right_element = 1'b0;
                    assign down_element = 1'b0;
                end
                crumb crumb_inst(
                    .clk(clk),
                    .rst_n(rst_n),
                    .en(en),
                    .run(run),
                    .display(display),
                    .nearest_neighbors({left_element,right_element,up_element,down_element,up_left_element,up_right_element,down_left_element,down_right_element}),
                    //.nearest_neighbors({(x_cor > 0) ? state_values[idx - 1][0] : 1'b0, (x_cor < 15) ? state_values[idx + 1][0]: 1'b0, (y_cor > 15) ? state_values[idx -16][0]: 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}),
                    .in_shift(shift_values[idx]),
                    .out_shift(shift_values[idx + 1]),
                    .state(state_values[idx]),
                    .display_shift_in(display_shift_values[idx]),
                    .display_shift_out(display_shift_values[idx + 1])
                );
            end
        end
    endgenerate

endmodule

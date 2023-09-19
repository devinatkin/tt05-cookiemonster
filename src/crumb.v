`timescale 1ns / 1ps

module crumb(
input wire clk,         // Clock signal
input wire rst_n,       // Active-low reset signal
input wire en,          // Enable signal
input wire run,         // Run signal
input wire display,     // Display out signal (Pulse to display the crumb)
input wire [7:0] nearest_neighbors, // Input bits from the nearest neighbors
input wire in_shift,       // Shift signal
output reg out_shift,   // Output bit to the shift register
output reg [1:0] state, // output indicating if the crumb state
input wire display_shift_in,
output reg display_shift_out
);

reg[1:0] crumb_state; // Internal State Register for the crumb
// Bit 0: 0 = Dead, 1 = Alive

reg [3:0] alive_cells; // Internal Register for the number of alive cells
reg prev_display; // Internal Register for the previous display signal
always@(posedge clk) begin
    if (!rst_n) begin           // Reset Event
        crumb_state[0] <= 1'b0;
        out_shift <= 1'b0;
        state <= 1'b0;
        alive_cells <= 4'b0;
        display_shift_out <= 1'b0;
        prev_display <= 1'b0;
    end else if (en) begin
        prev_display <= display; // Store the previous display signal

        if(display) begin
            // If the rising edge of the display signal is detected then the crumb state will be displayed
            if(!prev_display) begin
                display_shift_out <= crumb_state[0];
            end else begin
                display_shift_out <= display_shift_in;
            end
        end else if(run) begin // If the run signal is high then run the crumbs state
            // Display Shift Register to output to the display
            // IF the cell is a Conways game of life cell
            alive_cells <= nearest_neighbors[0] + nearest_neighbors[1] + nearest_neighbors[2] + nearest_neighbors[3] + nearest_neighbors[4] + nearest_neighbors[5] + nearest_neighbors[6] + nearest_neighbors[7];
            if (crumb_state[0]) begin // If the crumb is alive
                if (alive_cells < 2 || alive_cells > 3) begin // If the crumb is alive and has less than 2 or more than 3 neighbors
                    crumb_state[0] <= 1'b0; // The crumb dies
                    state <= 1'b0;
                end else begin // If the crumb is alive and has 2 or 3 neighbors
                    crumb_state[0] <= 1'b1; // The crumb lives
                    state <= 1'b1;
                end
            end else begin // If the crumb is dead
                if (alive_cells == 3) begin // If the crumb is dead and has 3 neighbors
                    crumb_state[0] <= 1'b1; // The crumb lives
                    state <= 1'b1;
                end else begin // If the crumb is dead and has less than 3 or more than 3 neighbors
                    crumb_state[0] <= 1'b0; // The crumb dies
                    state <= 1'b0;
                end
            end
        end else begin // If the run signal is low then the crumb will behave as a shift register
        
            crumb_state[0] <= in_shift;
            out_shift <= crumb_state[0];
            display_shift_out <= crumb_state[0];
        end
    end
end

endmodule

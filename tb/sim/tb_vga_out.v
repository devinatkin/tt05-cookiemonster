`timescale 1ns/1ps

module tb_vga_out();

    reg clk = 0;            // Clock signal initialization
    reg rst_n = 1;              // Reset signal initialization
    integer outfile;        // Output file handle
    wire [9:0] x;
    wire [9:0] y;
    wire hs;
    wire vs;
    wire [9:0] xcoor;
    wire [9:0] ycoor;
    wire [1:0] red;
    wire [1:0] green;
    wire [1:0] blue;

    wire [1:0] red_pixel_out;
    wire [1:0] green_pixel_out;
    wire [1:0] blue_pixel_out;

    reg write_enable;
    reg write_data;

    // Instantiate the vga_ram_display module
    vga_ram_display video_memory (
        .clk(clk),
        .rst_n(rst_n),
        .xcoor(xcoor),
        .ycoor(ycoor),
        .write_enable(write_enable),
        .write_data(write_data),
        .red(red),
        .green(green),
        .blue(blue)
    );

    // Task for writing simulation results to an output file
    task write_to_file (input integer sim_time, input reg hs, input reg vs, input reg [1:0] red, input reg [1:0] green, input reg [1:0] blue);
        begin
            $fwrite(outfile, "%0d ns: %b %b %b %b %b\n", sim_time, hs, vs, red, green, blue);
        end
    endtask

    // Call the write_to_file task on every clock edge
    always @(posedge clk) begin
        write_to_file($realtime, hs, vs, red_pixel_out, green_pixel_out, blue_pixel_out);
    end

        // Simulation Initialization
    initial begin
        outfile = $fopen("vga_out.txt", "w");
        $dumpfile ("vga_out.vcd");
        $dumpvars (0, tb_vga_out);
        #1;
    end

    initial begin
        #10;
        rst_n = 0;
        write_enable = 1'b0;
        write_data = 1'b0;
        #800;
        rst_n = 1;
        write_enable = 1'b1;
        write_data = 1'b1;
        #10000000;
        write_data = 1'b0;
        write_enable = 1'b0;
        //Wait for 6 frames to be generated before ending the simulation (60 frames = 1 second)
        #100000000;

        $finish;
    end

        // Clock generation: 25 MHz
    always #20 clk = ~clk;

    vga_controller vga_ctrl_instance(
        .clk(clk),
        .rst_n(rst_n),
        .enable(1'b1),
        .red_pixel_in(red),
        .green_pixel_in(green),
        .blue_pixel_in(blue),
        .hs(hs),
        .vs(vs),
        .xcoor(xcoor),
        .ycoor(ycoor),
        .red_pixel_out(red_pixel_out),
        .green_pixel_out(green_pixel_out),
        .blue_pixel_out(blue_pixel_out)
    );

endmodule
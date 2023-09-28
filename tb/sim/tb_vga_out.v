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
    reg data;
    wire rising_out_active;
    wire falling_out_active;
    wire active;

    wire rising_out_xcoor;
    wire falling_out_xcoor;

    wire rising_out_ycoor;
    wire falling_out_ycoor;

    wire changing_coors;
    assign changing_coors = rising_out_xcoor || rising_out_ycoor || falling_out_xcoor || falling_out_ycoor; // Slow Clock for writing to RAM
    assign write_enable = !active;

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

    edge_detector display_load (
        .clk(clk),
        .rst_n(rst_n),
        .signal_in(active),
        .rising_out(rising_out_active),
        .falling_out(falling_out_active)
    );

    edge_detector xcoor_change (
        .clk(clk),
        .rst_n(rst_n),
        .signal_in(xcoor[0]),
        .rising_out(rising_out_xcoor),
        .falling_out(falling_out_xcoor)
    );

    edge_detector ycoor_change (
        .clk(changing_coors),
        .rst_n(rst_n),
        .signal_in(ycoor[0]),
        .rising_out(rising_out_ycoor),
        .falling_out(falling_out_ycoor)
    );

    shift_register_256 uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(1'b1),
        .din(data),
        .shift_dir(1'b0),
        .dout(write_data)
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

        #800;
        rst_n = 1;
        while(active == 1) begin
            #1;
        end
        while (active == 0) begin
            if(xcoor == 2 && ycoor == 2) begin
                data = 1;
            end
            else begin
                data = 0;
            end
        end

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
        .display_active(active),
        .red_pixel_out(red_pixel_out),
        .green_pixel_out(green_pixel_out),
        .blue_pixel_out(blue_pixel_out)
    );

endmodule
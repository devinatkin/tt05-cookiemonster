`timescale 1ns / 1ps

module tb_cookie();

    reg clk_tb;
    reg rst_n_tb;
    reg en_tb;
    reg rbit_tb;
    
    // Instantiate the DUT (Device Under Test)
    cookie uut (
        .clk(clk_tb),
        .rst_n(rst_n_tb),
        .en(en_tb),
        .rbit(rbit_tb)
    );
    
    // Clock Generation
    always begin
        #5 clk_tb = ~clk_tb;
    end
    
    // VCD file for GTKWave
    initial begin
        $dumpfile("cookie.vcd");
        $dumpvars(0, tb_cookie);
    end


    // Test Procedure
    initial begin
        // Initialize signals
        clk_tb = 0;
        rst_n_tb = 0;
        en_tb = 0;
        rbit_tb = 0;
        
        // Apply reset
        #10 rst_n_tb = 1;
        #10 rst_n_tb = 0;
        
        // Remove reset and start testing
        #10 rst_n_tb = 1;
        
        // Test Case 1: Disable the functionality
        en_tb = 0;
        #20;
        
        // Test Case 2: Enable the functionality
        en_tb = 1;
        #20;
        
        // Test Case 3: Provide a random bit
        rbit_tb = 1;
        #20;
        
        // More test cases can be added here
        
        $finish;  // End of simulation
    end
    
endmodule

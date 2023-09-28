# Compile the Verilog files
iverilog -Wall -g2012 -o vga_out '..\src\shift_register_256.v' '..\src\edge_detector.v' '..\src\video_memory.v' '..\src\vga_ram_display.v' '..\src\vga_timing.v' '..\src\vga_coord_calc.v' '..\src\vga_controller.v' '..\src\rgb_active.v' '..\src\pwm_module.v' 'sim\tb_vga_out.v'

# Run the simulation to generate the VCD file
vvp vga_out

# Optional: Open the VCD file with GTKWave
gtkwave vga_out.vcd

# Remove the temporary simulation executable
Remove-Item vga_out

# Compile the Verilog files
iverilog -Wall -g2012 -o vga_ram_display '..\src\video_memory.v' '..\src\vga_ram_display.v' 'sim\tb_vga_ram_display.v'

# Run the simulation to generate the VCD file
vvp vga_ram_display

# Optional: Open the VCD file with GTKWave
gtkwave vga_ram_display.vcd

# Remove the temporary simulation executable
Remove-Item vidmem_sim

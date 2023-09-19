# Compile the Verilog files
iverilog -Wall -g2012 -o vidmem_sim '..\src\video_memory.v' 'sim\tb_video_memory.v'

# Run the simulation to generate the VCD file
vvp vidmem_sim

# Optional: Open the VCD file with GTKWave
gtkwave vidmem_64bit.vcd

# Remove the temporary simulation executable
Remove-Item vidmem_sim

# Compile the Verilog files
iverilog -Wall -g2012 -o lfsr_sim '..\src\lfsr_64bit.v' 'sim\tb_lfsr_64bit.v'

# Run the simulation to generate the VCD file
vvp lfsr_sim

# Optional: Open the VCD file with GTKWave
gtkwave lfsr_64bit.vcd

# Remove the temporary simulation executable
Remove-Item lfsr_sim

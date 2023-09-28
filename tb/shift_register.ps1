# Compile the Verilog files
iverilog -Wall -g2012 -o tb_shift_register_256 '..\src\shift_register_256.v' 'sim\tb_shift_register_256.v'

# Run the simulation to generate the VCD file
vvp tb_shift_register_256

# Optional: Open the VCD file with GTKWave
gtkwave shift_register_sim.vcd

# Remove the temporary simulation executable
Remove-Item shift_register_sim

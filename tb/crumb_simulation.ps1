# Compile the Verilog files
iverilog -Wall -g2012 -o crumb_sim '..\src\crumb.v' 'sim\tb_crumb.v'

# Run the simulation to generate the VCD file
vvp crumb_sim

# Optional: Open the VCD file with GTKWave
gtkwave crumb.vcd

# Remove the temporary simulation executable
Remove-Item crumb_sim
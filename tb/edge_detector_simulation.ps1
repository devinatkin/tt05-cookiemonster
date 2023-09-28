# Compile the Verilog files
iverilog -Wall -g2012 -o tb_edge_detector '..\src\edge_detector.v' 'sim\tb_edge_detector.v'

# Run the simulation to generate the VCD file
vvp tb_edge_detector

# Optional: Open the VCD file with GTKWave
gtkwave tb_edge_detector.vcd

# Remove the temporary simulation executable
Remove-Item tb_edge_detector

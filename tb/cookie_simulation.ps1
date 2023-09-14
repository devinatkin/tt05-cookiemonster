# Compile the Verilog files
iverilog -Wall -g2012 -o cookie_sim '..\src\crumb.v' '..\src\cookie.v' 'sim\tb_cookie.v'

# Run the simulation to generate the VCD file
vvp cookie_sim

# Optional: Open the VCD file with GTKWave
gtkwave cookie.vcd

# Remove the temporary simulation executable
Remove-Item cookie_sim
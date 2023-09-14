iverilog -Wall -g2012 -o tb_sim ..\src\top_level.v sim\tb_top_level.v ..\src\lfsr_64bit.v ..\src\cookie.v ..\src\crumb.v
vvp tb_sim
rm tb_sim
iverilog -Wall -g2012 -o tb_sim ..\src\top_level.v sim\tb_top_level.v ..\src\lfsr_64bit.v ..\src\cookie.v ..\src\crumb.v ..\src\pwm_module.v ..\src\vga_controller.v ..\src\vga_coord_calc.v ..\src\video_memory.v ..\src\rgb_active.v ..\src\vga_timing.v
vvp tb_sim
rm tb_sim
# Main Clock				
set_property PACKAGE_PIN P17 [get_ports clk100]
set_property IOSTANDARD LVCMOS33 [get_ports clk100]				

# BTN 
set_property PACKAGE_PIN R11 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN R15 [get_ports btn_ColorExtract]
set_property IOSTANDARD LVCMOS33 [get_ports btn_ColorExtract]

#led
set_property PACKAGE_PIN F6 [get_ports Config_Done]
set_property IOSTANDARD LVCMOS33 [get_ports Config_Done]
# SW
set_property PACKAGE_PIN N4 [get_ports Move_EN]
set_property PACKAGE_PIN V17 [get_ports sw_ColorClear]
set_property IOSTANDARD LVCMOS33 [get_ports Move_EN]
set_property IOSTANDARD LVCMOS33 [get_ports sw_ColorClear]

#OV7725 Data signals 
set_property PACKAGE_PIN E17 [get_ports {OV7725_D[7]}]
set_property PACKAGE_PIN D17 [get_ports {OV7725_D[6]}]
set_property PACKAGE_PIN H14 [get_ports {OV7725_D[5]}]
set_property PACKAGE_PIN G14 [get_ports {OV7725_D[4]}]
set_property PACKAGE_PIN F15 [get_ports {OV7725_D[3]}]
set_property PACKAGE_PIN F16 [get_ports {OV7725_D[2]}]
set_property PACKAGE_PIN H16 [get_ports {OV7725_D[1]}]
set_property PACKAGE_PIN G16 [get_ports {OV7725_D[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OV7725_D[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OV7725_D[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OV7725_D[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OV7725_D[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OV7725_D[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OV7725_D[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OV7725_D[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OV7725_D[0]}]
#OV7725 Control signals 
set_property PACKAGE_PIN J13 [get_ports OV7725_HREF]
set_property PACKAGE_PIN D15 [get_ports OV7725_PCLK]
set_property PACKAGE_PIN H17 [get_ports OV7725_SIOC]
set_property PACKAGE_PIN G17 [get_ports OV7725_SIOD]
set_property PACKAGE_PIN K13 [get_ports OV7725_VSYNC]
set_property PACKAGE_PIN C15 [get_ports OV7725_XCLK]
set_property IOSTANDARD LVCMOS33 [get_ports OV7725_HREF]
set_property IOSTANDARD LVCMOS33 [get_ports OV7725_PCLK]
set_property IOSTANDARD LVCMOS33 [get_ports OV7725_SIOC]
set_property IOSTANDARD LVCMOS33 [get_ports OV7725_SIOD]
set_property IOSTANDARD LVCMOS33 [get_ports OV7725_VSYNC]
set_property IOSTANDARD LVCMOS33 [get_ports OV7725_XCLK]
#IIC port"OV7725_SIOD" must be pulled up
set_property PULLUP true [get_ports OV7725_SIOD]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets OV7725_PCLK]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets OV7725_VSYNC]

#PWM signal for 2 servos
set_property PACKAGE_PIN B11 [get_ports pwm_out_y]
set_property PACKAGE_PIN A11 [get_ports pwm_out_x]
set_property IOSTANDARD LVCMOS33 [get_ports pwm_out_y]
set_property IOSTANDARD LVCMOS33 [get_ports pwm_out_x]

# VGA signals
set_property PACKAGE_PIN E7 [get_ports {vga_blue[3]}]
set_property PACKAGE_PIN E5 [get_ports {vga_blue[2]}]
set_property PACKAGE_PIN E6 [get_ports {vga_blue[1]}]
set_property PACKAGE_PIN C7 [get_ports {vga_blue[0]}]
set_property PACKAGE_PIN D8 [get_ports {vga_green[3]}]
set_property PACKAGE_PIN A5 [get_ports {vga_green[2]}]
set_property PACKAGE_PIN A6 [get_ports {vga_green[1]}]
set_property PACKAGE_PIN B6 [get_ports {vga_green[0]}]
set_property PACKAGE_PIN B7 [get_ports {vga_red[3]}]
set_property PACKAGE_PIN C5 [get_ports {vga_red[2]}]
set_property PACKAGE_PIN C6 [get_ports {vga_red[1]}]
set_property PACKAGE_PIN F5 [get_ports {vga_red[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[0]}]
set_property PACKAGE_PIN D7 [get_ports vga_hsync]
set_property PACKAGE_PIN C4 [get_ports vga_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports vga_hsync]
set_property IOSTANDARD LVCMOS33 [get_ports vga_vsync]

#XADC signal
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
set_property IOSTANDARD LVCMOS33 [get_ports vauxp2]
set_property IOSTANDARD LVCMOS33 [get_ports vauxn2]
set_property IOSTANDARD LVCMOS33 [get_ports vauxp3]
set_property IOSTANDARD LVCMOS33 [get_ports vauxn3]
set_property IOSTANDARD LVCMOS33 [get_ports vauxp10]
set_property IOSTANDARD LVCMOS33 [get_ports vauxn10]
set_property IOSTANDARD LVCMOS33 [get_ports vauxp11]
set_property IOSTANDARD LVCMOS33 [get_ports vauxn11]
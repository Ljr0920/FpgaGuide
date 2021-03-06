# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir F:/fpga_xilinx/fpga/2016.10.24/myself/lab3_div_clk/lab3_div_clk.cache/wt [current_project]
set_property parent.project_path F:/fpga_xilinx/fpga/2016.10.24/myself/lab3_div_clk/lab3_div_clk.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog -library xil_defaultlib {
  F:/fpga_xilinx/fpga/2016.10.24/myself/sources/lab3/divo_clk.v
  F:/fpga_xilinx/fpga/2016.10.24/myself/sources/lab3/dive_clk.v
  F:/fpga_xilinx/fpga/2016.10.24/myself/sources/lab3/div_clk.v
}
read_xdc F:/fpga_xilinx/fpga/2016.10.24/myself/sources/lab3/constr/IO.xdc
set_property used_in_implementation false [get_files F:/fpga_xilinx/fpga/2016.10.24/myself/sources/lab3/constr/IO.xdc]

synth_design -top div_clk -part xc7a35tcsg324-1
write_checkpoint -noxdef div_clk.dcp
catch { report_utilization -file div_clk_utilization_synth.rpt -pb div_clk_utilization_synth.pb }

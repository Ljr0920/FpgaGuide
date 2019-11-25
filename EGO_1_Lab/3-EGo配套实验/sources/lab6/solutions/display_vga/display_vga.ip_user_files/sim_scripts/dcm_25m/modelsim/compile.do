vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../display_vga.srcs/sources_1/ip/dcm_25m/dcm_25m_clk_wiz.v" \
"../../../../display_vga.srcs/sources_1/ip/dcm_25m/dcm_25m.v" \


vlog -work xil_defaultlib "glbl.v"


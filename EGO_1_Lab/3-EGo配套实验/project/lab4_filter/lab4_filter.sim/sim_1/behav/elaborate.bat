@echo off
set xv_path=D:\\software\\vivado\\2015.4\\bin
call %xv_path%/xelab  -wto 170e78ff55054aafbbef73437e813e92 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L dist_mem_gen_v8_0_9 -L unisims_ver -L unimacro_ver -L secureip --snapshot FIR_tb_behav xil_defaultlib.FIR_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

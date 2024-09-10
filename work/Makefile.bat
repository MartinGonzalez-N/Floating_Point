@echo off
call C:\Xilinx\Vivado\2023.1\settings64.bat

if "%1"=="sim" (goto ana)
if "%1"=="waves" (goto waves)


 :ana
	echo Making ana...
	
	call xvlog -sv -f list.f -L UVM 
	if "%1"=="ana" (exit /B 0)
	
:elab
	echo Making elab...
	call xelab -debug typical -relax "%2" 
	if "%1"=="elab" (exit /B 0)
	
:sim
	echo Making sim...
	:: call xsim work.tb_vivado -runall tb_vivado_axi
	::-wdb dump.sdb
	call xsim work."%2" -testplusarg "file_arg=%3" -tclbatch "wave.tcl" -wdb dump.sdb
	if "%1"=="sim" (exit /B 0)

:waves
	echo Loading waves...
	call vivado -mode batch -source wave_load.tcl
	if "%1"=="waves" (exit /B 0)

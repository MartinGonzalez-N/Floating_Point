@echo off
call C:\Xilinx\Vivado\2023.1\settings64.bat

if "%1"=="sim" (goto ana)
if "%1"=="waves" (goto waves)
if "%1"=="compile" (goto compile)

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
	call xsim work."%2" -testplusarg "seed_arg=%3" -tclbatch "wave.tcl" -wdb dump.sdb
	if "%1"=="sim" (exit /B 0)

:waves
	echo Loading waves...
	call vivado -mode batch -source wave_load.tcl
	if "%1"=="waves" (exit /B 0)

:: To compile a verilog file:
::    >> makefile.bat compile path\my_verilog_file.sv
::    >> .\Makefile.bat compile ../rtl/misc/mult_16bits.v 
:: To run sim:
::    >> makefile.bat sim top_module_name seed_value
:compile
    echo Compiling specified Verilog file...
    if "%2"=="" (
        echo Error: No Verilog file specified.
        exit /B 1
    )
    call xvlog -sv "%2" -L UVM 
    echo Compilation complete.
    exit /B 0
	
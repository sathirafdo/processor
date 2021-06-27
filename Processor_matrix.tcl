# Copyright (C) 2020  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details, at
# https://fpgasoftware.intel.com/eula.

# Quartus Prime: Generate Tcl File for Project
# File: Processor_matrix.tcl
# Generated on: Sun Jun 27 10:20:34 2021

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "Processor_matrix"]} {
		puts "Project Processor_matrix is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists Processor_matrix]} {
		project_open -revision Processor_matrix Processor_matrix
	} else {
		project_new -revision Processor_matrix Processor_matrix
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone IV E"
	set_global_assignment -name DEVICE auto
	set_global_assignment -name TOP_LEVEL_ENTITY Full_System_Copy
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 18.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "19:08:45  JUNE 19, 2021"
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.0 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name EDA_TEST_BENCH_ENABLE_STATUS TEST_BENCH_MODE -section_id eda_simulation
	set_global_assignment -name EDA_NATIVELINK_SIMULATION_TEST_BENCH Memory_AR_DR_CU_tb -section_id eda_simulation
	set_global_assignment -name EDA_TEST_BENCH_NAME ALU_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id ALU_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME ALU_tb -section_id ALU_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME R_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id R_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME R_tb -section_id R_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME DR_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id DR_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME DR_tb -section_id DR_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME AC_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id AC_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME AC_tb -section_id AC_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME Data_bus_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id Data_bus_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME Data_bus_tb -section_id Data_bus_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME PC_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id PC_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME PC_tb -section_id PC_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME IR_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id IR_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME IR_tb -section_id IR_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME Control_Unit_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id Control_Unit_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME Control_Unit_tb -section_id Control_Unit_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME Memory_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id Memory_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME Memory_tb -section_id Memory_tb
	set_global_assignment -name EDA_TEST_BENCH_NAME Memory_AR_DR_CU_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id Memory_AR_DR_CU_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME Memory_AR_DR_CU_tb -section_id Memory_AR_DR_CU_tb
	set_global_assignment -name VERILOG_FILE Register_File.v
	set_global_assignment -name VERILOG_FILE Full_System_Copy.v
	set_global_assignment -name VERILOG_FILE Full_System.v
	set_global_assignment -name VERILOG_FILE Control_Unit.v
	set_global_assignment -name VERILOG_FILE IR.v
	set_global_assignment -name VERILOG_FILE PC.v
	set_global_assignment -name VERILOG_FILE Data_bus.v
	set_global_assignment -name VERILOG_FILE AC.v
	set_global_assignment -name VERILOG_FILE DR.v
	set_global_assignment -name VERILOG_FILE AR.v
	set_global_assignment -name VERILOG_FILE ALU.v
	set_global_assignment -name QIP_FILE MemoryQ.qip
	set_global_assignment -name QIP_FILE Ins_Memory.qip
	set_global_assignment -name EDA_TEST_BENCH_NAME Register_file_tb -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id Register_file_tb
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME Register_file_tb -section_id Register_file_tb
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name EDA_TEST_BENCH_FILE ALU_tb.v -section_id ALU_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE R_tb.v -section_id R_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE DR_tb.v -section_id DR_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE AC_tb.v -section_id AC_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE Data_bus_tb.v -section_id Data_bus_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE PC_tb.v -section_id PC_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE IR_tb.v -section_id IR_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE Control_Unit_tb.v -section_id Control_Unit_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE Memory_tb.v -section_id Memory_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE Memory_AR_DR_CU_tb.v -section_id Memory_AR_DR_CU_tb
	set_global_assignment -name EDA_TEST_BENCH_FILE Register_file_tb.v -section_id Register_file_tb
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Including default assignments
	set_global_assignment -name TIMING_ANALYZER_MULTICORNER_ANALYSIS ON -family "Cyclone IV E"
	set_global_assignment -name TIMING_ANALYZER_REPORT_WORST_CASE_TIMING_PATHS ON -family "Cyclone IV E"
	set_global_assignment -name TIMING_ANALYZER_CCPP_TRADEOFF_TOLERANCE 0 -family "Cyclone IV E"
	set_global_assignment -name TDC_CCPP_TRADEOFF_TOLERANCE 0 -family "Cyclone IV E"
	set_global_assignment -name TIMING_ANALYZER_DO_CCPP_REMOVAL ON -family "Cyclone IV E"
	set_global_assignment -name DISABLE_LEGACY_TIMING_ANALYZER OFF -family "Cyclone IV E"
	set_global_assignment -name SYNTH_TIMING_DRIVEN_SYNTHESIS ON -family "Cyclone IV E"
	set_global_assignment -name SYNCHRONIZATION_REGISTER_CHAIN_LENGTH 2 -family "Cyclone IV E"
	set_global_assignment -name SYNTH_RESOURCE_AWARE_INFERENCE_FOR_BLOCK_RAM ON -family "Cyclone IV E"
	set_global_assignment -name OPTIMIZE_HOLD_TIMING "ALL PATHS" -family "Cyclone IV E"
	set_global_assignment -name OPTIMIZE_MULTI_CORNER_TIMING ON -family "Cyclone IV E"
	set_global_assignment -name AUTO_DELAY_CHAINS ON -family "Cyclone IV E"
	set_global_assignment -name CRC_ERROR_OPEN_DRAIN OFF -family "Cyclone IV E"
	set_global_assignment -name USE_CONFIGURATION_DEVICE OFF -family "Cyclone IV E"
	set_global_assignment -name ENABLE_OCT_DONE OFF -family "Cyclone IV E"

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}

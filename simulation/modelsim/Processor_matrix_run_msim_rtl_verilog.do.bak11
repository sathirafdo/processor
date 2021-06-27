transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/Register_File.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/Full_System_Copy.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/Control_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/IR.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/PC.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/Data_bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/AC.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/DR.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/AR.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/MemoryQ.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/Ins_Memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/user/Desktop/Semester\ 6B/Jayathu/sathira_processor {C:/Users/user/Desktop/Semester 6B/Jayathu/sathira_processor/Memory_AR_DR_CU_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Memory_AR_DR_CU_tb

add wave *
view structure
view signals
run -all

transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/Register_File.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/Full_System_Copy.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/Control_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/IR.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/PC.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/Data_bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/AC.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/DR.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/AR.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/MemoryQ.v}
vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/Ins_Memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/sathiralanka/Desktop/Processor\ code {C:/Users/sathiralanka/Desktop/Processor code/Memory_AR_DR_CU_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Memory_AR_DR_CU_tb

add wave *
view structure
view signals
run -all

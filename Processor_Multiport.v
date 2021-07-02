module Processor_Multiport 
#(
    parameter reg_width =12,
    parameter  reg_count= 16,
    parameter reg_file_count =11,
    parameter IR_width=12,
    parameter Im_width=8,
    parameter current_PC_value = 12'b000000000000,
    parameter data_mem_size =4096,
    parameter  port_count =2
)
(
    input wire start,
    input wire clk,reset
);

localparam betap_reset1 = 12'd900 , 
            gammap_reset1= 12'd1600;

localparam  betap_reset2 =  12'd1225,
            gammap_reset2 = 12'd1925;

//TODO  1. add signal to iindicate end of opearation
//      2. add AR to mem logic (whick ar to mem to choose out of the 2 whrn both are given)



wire [reg_width-1:0] InsM_datain,DM_datain1,DM_datain2;
//these wires are not necesary .should be alwasy grounded
wire [reg_width-1:0] im_data_sig;
wire im_wren_sig;

wire clk1,clk2;  //yo yo control the cores separately

wire [reg_count - 1:0] read_en1, write_en1;
wire Zflag1,PC_Inc1;
wire [IR_width - 1:0] opcode1;
wire [2:0] alu_op1;
wire mem_write1;
wire [1:0] mem_read1;
wire [reg_width-1:0] PC_to_AR1;
wire [reg_width-1:0] AR_to_mem1,DR_out1,bus_dataout1,ALU_result1,Register_file_out1,AC_out1;

wire [reg_count - 1:0] read_en2, write_en2;
wire Zflag2,PC_Inc2;
wire [IR_width - 1:0] opcode2;
wire [2:0] alu_op2;
wire mem_write2;
wire [1:0] mem_read2;
wire [reg_width-1:0] PC_to_AR2;
wire [reg_width-1:0] AR_to_mem2,DR_out2,bus_dataout2,ALU_result2,Register_file_out2,AC_out2;



Processor_Core #(.reg_width(reg_width),.reg_count(reg_count),.IR_width(IR_width),
                    .Im_width(Im_width),.current_PC_value(current_PC_value),
                    .betap_reset(betap_reset1),.gammap_reset(gammap_reset1)) core1 (
            .clk(clk1),.reset(reset),.start(start),
            .read_en(read_en1), 
            .write_en(write_en1),
            .Zflag(Zflag1),
            .PC_Inc(PC_Inc1),
            .opcode(opcode1),
            .alu_op(alu_op1),
            .mem_write(mem_write1),
            .mem_read(mem_read1),
            .PC_to_AR(PC_to_AR1),
            .AR_to_mem(AR_to_mem1), 
            .InsM_datain(InsM_datain),
            .DM_datain(DM_datain1),
            .DR_out(DR_out1),
            .bus_dataout(bus_dataout1),
            .ALU_result(ALU_result1),
            .AC_out(AC_out1),
            .Register_file_out(Register_file_out1));

Processor_Core #(.reg_width(reg_width),.reg_count(reg_count),.IR_width(IR_width),
                    .Im_width(Im_width),.current_PC_value(current_PC_value),
                    .betap_reset(betap_reset2),.gammap_reset(gammap_reset2)) core2 (
            .clk(clk2),.reset(reset),.start(start),
            .read_en(read_en2), 
            .write_en(write_en2),
            .Zflag(Zflag2),
            .PC_Inc(PC_Inc2),
            .opcode(opcode2),
            .alu_op(alu_op2),
            .mem_write(mem_write2),
            .mem_read(mem_read2),
            .PC_to_AR(PC_to_AR2),
            .AR_to_mem(AR_to_mem2),
            .InsM_datain(InsM_datain),
            .DM_datain(DM_datain2),
            .DR_out(DR_out2),
            .bus_dataout(bus_dataout2),
            .ALU_result(ALU_result2),
            .AC_out(AC_out2),
            .Register_file_out(Register_file_out2));

//TODO remove this memory
MemoryQ	MemoryQ_inst (
            .address ( AR_to_mem1 ), //todo add logic to take from both cores
            .clock ( clk ),
            .data ( DR_out1 ),
            .wren ( mem_write1 ),
            .q ( DM_datain ));

Ins_Memory	Ins_Memory_inst (
            .address (AR_to_mem1[(Im_width-1):0] ), //todo add logic to ake adress from both cores
            .clock ( clk ),
            .data ( im_data_sig ),//not necessary grounded
            .wren ( im_wren_sig ),//not necessary grounded set alwasy zero to disable writing always
            .q ( InsM_datain ));

Multiport_ram #(.mem_size(data_mem_size), .mem_width(reg_width), .port_count(port_count) ) u_Multiport_ram (
    .clk                     ( clk                         ),
    .reset                   ( reset                       ),
    .address1                ( AR_to_mem1 ),
    .address2                ( AR_to_mem2 ),
    .datain1                 ( DR_out1 ),
    .datain2                 ( DR_out2 ),
    .mem_write1              ( mem_write1                  ),
    .mem_write2              ( mem_write2                  ),
    .dataout1                ( DM_datain1 ),
    .dataout2                ( DM_datain2 )
);


assign clk1 = clk;
assign clk2 = clk ; 

endmodule //Processor
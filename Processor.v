module Processor 
#(
    
)
(
    input wire start,
    input wire clk,reset


)

wire [reg_count - 1:0] read_en1, write_en1;
wire Zflag1,PC_Inc1;
wire [IR_width - 1:0] opcode1;
wire [2:0] alu_op1;
wire mem_write1;
wire [1:0] mem_read1;
wire [reg_width-1:0] PC_to_AR1;
wire [reg_width-1:0] AR_to_mem1,InsM_datain1,DR_out1,bus_dataout1,DM_datain1,ALU_result1,Register_file_out1,AC_out1;

wire [reg_count - 1:0] read_en2, write_en2;
wire Zflag,PC_Inc2;
wire [IR_width - 1:0] opcode2;
wire [2:0] alu_op2;
wire mem_write2;
wire [1:0] mem_read2;
wire [reg_width-1:0] PC_to_AR2;
wire [reg_width-1:0] AR_to_mem2,InsM_datain2,DR_out2,bus_dataout2,DM_datain2,ALU_result2,Register_file_out2,AC_out2;

Processor_Core #(.reg_width(reg_width),.reg_count(reg_count), .IR_width(IR_width),.Im_width(Im_width),
    .current_PC_value(current_PC_value), .betap_reset(betap_reset), .gammap_reset(gammap_reset)) core1 (
            .clk(clk),.reset(reset),.start(start),
            .read_en(read_en), 
            .write_en(write_en),
            .Zflag(Zflag),
            .PC_Inc(PC_Inc),
            .opcode(opcode),
            .alu_op(alu_op),
            .mem_write(mem_write),
            .mem_read(mem_read),
            .PC_to_AR(PC_to_AR),
            .AR_to_mem(AR_to_mem),
            .InsM_datain(InsM_datain),
            .DM_datain(DM_datain),
            .DR_out(DR_out),
            .bus_dataout(bus_dataout),
            .ALU_result(ALU_result),
            .AC_out(AC_out),
            .Register_file_out(Register_file_out));













endmodule //Processor
module Processor_Dynamic
#(
    parameter reg_width =12,
    parameter  reg_count= 16,
    parameter reg_file_count =11,
    parameter IR_width=12,
    parameter Im_width=8,
    parameter current_PC_value = 12'b000000000000,
    parameter data_mem_size =4096,
    parameter  core_count =2
)
(
    input wire start,
    input wire clk,reset,
    output wire [core_count-1:0] endop_signal
);



wire [reg_width-1:0] InsM_datain;
wire [reg_width-1:0] DM_datain [(core_count-1):0];

wire [reg_width-1:0] AR_to_mem [(core_count-1):0];
wire [reg_width-1:0] DR_out [(core_count-1):0];
wire mem_write [(core_count-1):0];

//these wires are not necesary .should be alwasy grounded
wire [reg_width-1:0] im_data_sig;
wire im_wren_sig;

//for demonstration
wire [reg_count - 1:0] read_en [(core_count-1):0];
wire [reg_count - 1:0] write_en [(core_count-1):0];
wire [(core_count-1):0] Zflag;
wire [(core_count-1):0] PC_Inc;
wire [IR_width - 1:0] opcode [(core_count-1):0];
wire [2:0] alu_op [(core_count-1):0];
wire [1:0] mem_read [(core_count-1):0];
wire [reg_width-1:0] PC_to_AR [(core_count-1):0];
wire [reg_width-1:0] bus_dataout [(core_count-1):0];
wire [reg_width-1:0] ALU_result [(core_count-1):0];
wire [reg_width-1:0] Register_file_out[(core_count-1):0];
wire [reg_width-1:0] AC_out [(core_count-1):0];



genvar i;
generate
    for (i=0; i<core_count; i=i+1) begin : core_generate_identifier

    Processor_Core #(.reg_width(reg_width),.reg_count(reg_count),.IR_width(IR_width),
                    .Im_width(Im_width),.current_PC_value(current_PC_value)
                    , .core_number(i)) corei (
            .clk(clk),.reset(reset),.start(start),
            .mem_write(mem_write[i]),
            .AR_to_mem(AR_to_mem[i]), 
            .InsM_datain(InsM_datain),
            .DM_datain(DM_datain[i]),
            .DR_out(DR_out[i]),
            .endop_signal(endop_signal[i]),

            .read_en(read_en[i]), 
            .write_en(write_en[i]),
            .Zflag(Zflag[i]),
            .PC_Inc(PC_Inc[i]),
            .opcode(opcode[i]),
            .alu_op(alu_op[i]),
            .mem_read(mem_read[i]),
            .PC_to_AR(PC_to_AR[i]),
            .bus_dataout(bus_dataout[i]),
            .ALU_result(ALU_result[i]),
            .AC_out(AC_out[i]),
            .Register_file_out(Register_file_out[i]));

end 
endgenerate

//Removed memoryQ
wire [reg_width-1:0] AR_to_mem_final;
assign AR_to_mem_final = AR_to_mem[0];

Ins_Memory	Ins_Memory_inst (
            .address (AR_to_mem_final[(Im_width-1):0] ), //same instruction is accessed by all cores at a given time
            .clock ( clk ),
            .data ( im_data_sig ),//not necessary grounded
            .wren ( im_wren_sig ),//not necessary grounded set alwasy zero to disable writing always
            .q ( InsM_datain ));

//TODO very important code multiport dynamic ram 
Multiport_ram #(.mem_size(data_mem_size), .mem_width(reg_width), .port_count(core_count) ) u_Multiport_ram (
    .clk                     ( clk),
    .reset                   ( reset),
    .address1                ( AR_to_mem[0] ),
    .address2                ( AR_to_mem[1]),
    .datain1                 ( DR_out[0] ),
    .datain2                 ( DR_out[1] ),
    .mem_write1              ( mem_write[0]),
    .mem_write2              ( mem_write[1]),
    .dataout1                ( DM_datain[0] ),
    .dataout2                ( DM_datain[1] )
);

endmodule //Processor_dynamic
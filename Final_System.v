module Final_System #(
    parameter reg_width =12,
    parameter  reg_count= 16,
    parameter reg_file_count =11,
    parameter IR_width=12,
    parameter Im_width=8,
    parameter current_PC_value = 12'b000000000000,
    parameter data_mem_size =4096,
    parameter  core_count =2,
    parameter addr_width =12
) (
    input wire start,
    input wire clk,reset,
    output wire [core_count-1:0] endop_signal
);


wire [reg_width-1:0] InsM_datain;
wire [(addr_width*core_count-1):0] address;
wire [reg_width*core_count-1:0] datain;
wire [(reg_width*core_count-1):0] dataout;
wire [(core_count-1):0] mem_write;

Processor_Dynamic#(.reg_width(reg_width),.reg_count(reg_count),.reg_file_count(reg_file_count),
                .IR_width(IR_width),.Im_width(Im_width),.current_PC_value(current_PC_value),
                .data_mem_size(data_mem_size),.core_count(core_count),.addr_width(addr_width)) Dynamic_CPU(
        .start(start),
        .clk(clk),.reset(reset),
        .endop_signal(endop_signal),
        .InsM_datain(InsM_datain),
        .address(address),
        .datain(datain),
        .dataout(dataout),
        .mem_write(mem_write));



//these wires are not necesary .should be alwasy grounded
wire [reg_width-1:0] im_data_sig;
wire im_wren_sig;

wire [reg_width-1:0] AR_to_mem_final;
assign AR_to_mem_final = address[11 :0];//TODO parameterize gain

Ins_Memory	Ins_Memory_inst (
            .address (AR_to_mem_final[(Im_width-1):0] ), //same instruction is accessed by all cores at a given time
            .clock ( clk ),
            .data ( im_data_sig ),//not necessary grounded
            .wren ( im_wren_sig ),//not necessary grounded set alwasy zero to disable writing always
            .q ( InsM_datain ));


Multiport_Dynamic_ram #(.mem_size(data_mem_size),.mem_width(reg_width),.addr_width(addr_width),.port_count(core_count)) u_Dynamic_ram(
    .clk(clk),
    .reset(reset),
    .address(address),
    .datain(datain),
    .mem_write(mem_write),     
    .dataout(dataout)
);

endmodule
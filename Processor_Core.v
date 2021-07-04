//Module Processor_Core

module Processor_Core
#(

    parameter reg_width =12,
    parameter  reg_count= 16,
    parameter reg_file_count =11,
    parameter IR_width=12,
    parameter Im_width=8,
    parameter current_PC_value = 12'b000000000000,
    parameter betap_reset =  12'd900,
    parameter gammap_reset = 12'd1600,
    parameter core_number = 0
)

(
    input wire start,
    input wire clk,reset,

    //For demonstration purposes
    output wire Zflag,PC_Inc,
    output wire [IR_width - 1:0] opcode,
    output wire [2:0] alu_op,
    output wire [reg_count - 1:0] read_en, write_en, 
    output wire [1:0] mem_read, //this signal goes to dr so no need to output in actual system
    output wire [reg_width-1:0] PC_to_AR, bus_dataout,ALU_result,Register_file_out,AC_out,
    
    //actual necessarry wires
    output wire [reg_width-1:0] AR_to_mem,DR_out,
    output wire mem_write,   
    input wire [reg_width-1:0] InsM_datain,DM_datain,
    output wire endop_signal
    
);

localparam trash= 12'bz;
localparam ALU_op_width = 3;




wire [reg_width-1:0] dataout,
AC_to_ALU;

wire [reg_width-1:0] im_data_sig;
wire im_wren_sig;
wire [10:0] re,we;
assign re = read_en[14:4]; 
assign we = write_en[14:4];

Register_File #(.reg_count(reg_file_count), .reg_width(reg_width), .betap_reset(betap_reset), .gammap_reset(gammap_reset), .core_number(core_number)) RF_unit 
            (.read_en(read_en[14:4]),
            .write_en(write_en[14:4]),
            .clk(clk),
            .reset(reset),
            .datain(bus_dataout),
            .dataout(Register_file_out));

ALU #(.reg_width(reg_width)) ALU_unit 
            (.clk(clk),
            .reset(reset),
            .ALU_Operation(alu_op),
            .AC(AC_to_ALU),
            .Bus(bus_dataout),
            .result(ALU_result)); //moving z flag to ac


DR #(.reg_width(reg_width)) DR_unit 
            (.writeEn_frBus(write_en[15]),
            .writeEn_frDM(mem_read[0]),
            .writeEn_frInsM(mem_read[1]),
            .clk(clk),
            .reset(reset),
            .bus_datain(bus_dataout),
            .DM_datain(DM_datain),
            .InsM_datain(InsM_datain),
            .dataout(DR_out));

PC #(.reg_width(reg_width),.current_PC_value(current_PC_value)) PC_unit 
            (.write_en(write_en[1]),
            .increment(PC_Inc),
            .clk(clk),
            .reset(reset),
            .bus_data_in(bus_dataout),
            .AR_data_out(PC_to_AR));

AC #(.reg_width(reg_width)) AC_unit 
            (.write_en(write_en[0]),
            .AC_in(ALU_result),
            .clk(clk),
            .reset(reset),
            .ALU(AC_to_ALU),
            .bus_out(AC_out),
            .Zflag(Zflag)); //moving z flag to ac


AR #(.reg_width(reg_width)) AR_unit 
            (.write_en(write_en[2]), 
            .PC_en(read_en[1]), 
            .clk(clk), 
            .reset(reset), 
            .pc_datain(PC_to_AR), 
            .bus_datain(bus_dataout), 
            .dataout(AR_to_mem));


IR #(.IR_width(IR_width)) IR_unit 
            (.write_en(write_en[3]),
            .clk(clk),
            .reset(reset),
            .bus_data(bus_dataout),
            .dataout(opcode));


//PC AR IR outputs are not necessary for the databus as no other 
//register takes their data through the bus
Data_bus #(.Reg_count(reg_count), .reg_width(reg_width)) DB_unit 
            (.read_en(read_en),
            .reset(reset),
            .AC(AC_out),
            .DR(DR_out),
            .Register_file(Register_file_out),
            .dataout(bus_dataout));


Control_Unit #( .IR_width(IR_width),.Reg_count(reg_count)) CU (
            .Zflag(Zflag),
            .start( start),
            .opcode(opcode),
            .reset(reset),
            .clk(clk),
            .alu_op(alu_op),
            .read_en(read_en),
            .write_en(write_en),
            .mem_write(mem_write),
            .PC_Inc(PC_Inc),
            .mem_read(mem_read),
            .endop_signal(endop_signal));



endmodule



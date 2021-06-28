`timescale 1ps/1ps

module Memory_AR_DR_CU_tb;

localparam CLK_PERIOD = 10,
           IR_width = 12,
           reg_count = 16,
           reg_width = 12,
           Im_width = 8,
           current_PC_value = 12'b000000000000,
           betap_reset =  12'd900,
           gammap_reset = 12'd1600;
           
           

reg clk,reset,start;

initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

wire [reg_count - 1:0] read_en, write_en;
wire Zflag,PC_Inc;
wire [IR_width - 1:0] opcode;
wire [2:0] alu_op;
wire mem_write;
wire [1:0] mem_read;
wire [reg_width-1:0] PC_to_AR;
wire [reg_width-1:0] AR_to_mem,InsM_datain,DR_out,bus_dataout,DM_datain,ALU_result,Register_file_out,AC_out;
/*reg start, Zflag; // if reset = 1(active high)
reg[IR_width - 1:0] opcode; //opcode to IR
wire [2:0] alu_op;
wire [Reg_count - 1:0] read_en, write_en;
wire mem_write;
wire PC_Inc;
wire [1:0] mem_read;

reg [(reg_width-1):0] pc_datain;

wire [(reg_width-1):0] bus_datain;

wire [(reg_width-1):0] AR_dataout;
wire [(reg_width-1):0] DR_dataout;

wire [(reg_width-1):0] DM_datain,InsM_datain ;
wire [(Im_width-1):0] AR_datain ;

reg [(reg_width-1):0] im_data_sig;
reg im_wren_sig;

Control_Unit #( .IR_width(IR_width),.Reg_count(Reg_count)) CU (
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
                .mem_read(mem_read));  


AR #(.reg_width(reg_width)) AR_unit (
                .write_en(write_en[2]), 
                .PC_en(read_en[1]), .clk(clk), 
                .reset(reset), 
                .pc_datain(pc_datain), 
                .bus_datain(bus_datain), 
                .dataout(AR_dataout));


DR #(.reg_width(reg_width)) DR_unit (
                .writeEn_frBus(write_en[15]), 
                .writeEn_frDM(mem_read[0]), 
                .writeEn_frInsM(mem_read[1]),
                .clk(clk), 
                .reset(reset),
                .bus_datain(bus_datain), 
                .DM_datain(DM_datain), 
                .InsM_datain(InsM_datain), 
                .dataout(DR_dataout));

//Data Memory
MemoryQ	MemoryQ_inst (
	.address ( AR_dataout ),
	.clock ( clk ),
	.data ( DR_dataout ),
	.wren ( mem_write ),
	.q ( DM_datain )
	);

Ins_Memory	Ins_Memory_inst (
	.address ( AR_dataout[(Im_width-1):0] ),
	.clock ( clk ),
	.data ( im_data_sig ),//not necessary grounded
	.wren ( im_wren_sig ),//not necessary grounded set alwasy zero to disable writing always
	.q ( InsM_datain )
	);*/

    Full_System_Copy #(.reg_width(reg_width),.reg_count(reg_count), .IR_width(IR_width),.Im_width(Im_width),
    .current_PC_value(current_PC_value), .betap_reset(betap_reset), .gammap_reset(gammap_reset)) system (
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


initial begin
    
    @(posedge clk);
    reset =1'b1;

    @(posedge clk);
    #(CLK_PERIOD*4/5);
    reset =1'b0;
    start = 1'b1;

    @(posedge clk);
    start = 1'b0;

    
    
    /*@(posedge clk); // AC <= DR
    #(CLK_PERIOD*4/5);
    start = 1'b1;
    pc_datain = 8'b000000000;

    @(posedge clk); //DR<- M ; PC<- PC+1;ins Read
    #(CLK_PERIOD*4/5);
    im_wren_sig = 1'b0;
    pc_datain = pc_datain + 8'b000000001;

    @(posedge clk);//IR<- DR ; AR<-PC ;
    #(CLK_PERIOD*4/5);

    @(posedge clk);
    #(CLK_PERIOD*4/5);

    @(posedge clk); // AC <= DR
    #(CLK_PERIOD*4/5);
    

    @(posedge clk); //DR<- M ; PC<- PC+1;ins Read
    #(CLK_PERIOD*4/5);
    im_wren_sig = 1'b0;
    pc_datain = pc_datain + 8'b000000001;

    @(posedge clk);//IR<- DR ; AR<-PC ;
    #(CLK_PERIOD*4/5);*/

end
endmodule
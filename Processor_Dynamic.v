module Processor_Dynamic
#(
    parameter reg_width =12,
    parameter  reg_count= 16,
    parameter reg_file_count =11,
    parameter IR_width=12,
    parameter Im_width=8,
    parameter current_PC_value = 12'b000000000000,
    parameter data_mem_size =4096,
    parameter  core_count =2,
    parameter addr_width =12
)
(
    input wire start,
    input wire clk,reset,
    input wire [reg_width-1:0] InsM_datain,
    output wire [core_count-1:0] endop_signal,
    output wire [(addr_width*core_count-1):0] address,
    output wire [reg_width*core_count-1:0] datain,   
    input wire [(reg_width*core_count-1):0] dataout,
    output wire [(core_count-1):0] mem_write
);


//for demonstration wires removed 

wire [reg_width-1:0] DM_datain [(core_count-1):0];
wire [reg_width-1:0] AR_to_mem [(core_count-1):0];
wire [reg_width-1:0] DR_out [(core_count-1):0];


genvar j;
generate        
for (j = 0; j < core_count ; j=j+1) begin  : conversion     
  assign address[(j+1)*addr_width -1 -:addr_width] = AR_to_mem[j];
  assign datain [(j+1)*reg_width -1 -:reg_width]  =  DR_out[j];
  assign DM_datain[j]  = dataout[(j+1)*reg_width -1 -:reg_width];
end
endgenerate 


genvar i;
generate
    for (i=0; i<core_count; i=i+1) begin : core_generate_identifier

    Processor_Core #(.reg_width(reg_width),.reg_count(reg_count),.IR_width(IR_width),
                     .Im_width(Im_width),.current_PC_value(current_PC_value),
                     .core_number(i)) corei (
                     .clk(clk),.reset(reset),.start(start),
                     .mem_write(mem_write[i]),
                     .AR_to_mem(AR_to_mem[i]), 
                     .InsM_datain(InsM_datain),
                     .DM_datain(DM_datain[i]),
                     .DR_out(DR_out[i]),
                     .endop_signal(endop_signal[i]));

        end 
endgenerate

endmodule //Processor_dynamic
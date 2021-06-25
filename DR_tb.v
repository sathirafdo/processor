`timescale 1ps/1ps

module DR_tb;

localparam CLK_PERIOD = 10,
           reg_width = 12;

reg clk,reset;
initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

reg writeEn_frBus, writeEn_frDM, writeEn_frInsM; // read from bus, data memory and instruction memory
    //output bus_write,dM, // write to bus and data memory -always on ports
reg [(reg_width-1):0] bus_datain, DM_datain, InsM_datain;
wire [(reg_width-1):0] dataout;

DR #(.reg_width(reg_width)) unit (.writeEn_frBus(writeEn_frBus), .writeEn_frDM(writeEn_frDM), .writeEn_frInsM(writeEn_frInsM),.clk(clk), .reset(reset),
.bus_datain(bus_datain), .DM_datain(DM_datain), .InsM_datain(InsM_datain), .dataout(dataout));



initial begin

    @(posedge clk);
        
    
    @(posedge clk);
        reset <= 1'b1;

    @(posedge clk); //bus write
        #(CLK_PERIOD*4/5);
        writeEn_frBus = 1'b1;      
        writeEn_frDM =1'b0; 
        writeEn_frInsM=1'b0;  
        bus_datain = 12'b111000001000;
        DM_datain = 12'b100000000011;
        InsM_datain = 12'b100000000000;
        reset = 1'b0;


    @(posedge clk); // PC_en write
        #(CLK_PERIOD*4/5);
        writeEn_frDM =1'b1; 
        writeEn_frBus =1'b0;
        writeEn_frInsM=1'b0;
        DM_datain = 12'b111111111011;
        bus_datain = 12'b00000001000;
        InsM_datain = 12'b100010001110;
        reset = 1'b0;

    @(posedge clk); // PC_en write
        #(CLK_PERIOD*4/5);
        writeEn_frDM =1'b0; 
        writeEn_frBus =1'b0;
        writeEn_frInsM=1'b1;
        InsM_datain = 12'b000000000001;
        DM_datain = 12'b111111111011;
        bus_datain = 12'b00000001000;
        reset = 1'b0;


end
endmodule
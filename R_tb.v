`timescale 1ps/1ps

module R_tb;

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



reg write_en,PC_en;
reg [(reg_width-1):0] pc_datain;
reg [reg_width-1:0] bus_datain;
wire [(reg_width-1):0] dataout;

//
AR #(.reg_width(reg_width)) unit (.write_en(write_en), .PC_en(PC_en), .clk(clk), .reset(reset), .pc_datain(pc_datain), .bus_datain(bus_datain), .dataout(dataout));


initial begin
    
    @(posedge clk);
        reset <= 1'b1;

    @(posedge clk); //bus write
        #(CLK_PERIOD*4/5);
        write_en = 1'b1; 
        PC_en = 1'b0;          
        bus_datain = 12'b111000001000;
        pc_datain = 12'b111111111011;
        reset = 1'b0;

    @(posedge clk); // PC_en write
        #(CLK_PERIOD*4/5);
        write_en = 1'b1; 
        PC_en = 1'b1;       
        pc_datain = 12'b111111111000;
        bus_datain = 12'b111011001000;
        reset = 1'b0;

end


endmodule
`timescale 1ps/1ps

module AC_tb;

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



reg write_en;
reg [(reg_width-1):0] AC_in;
wire [reg_width-1:0] ALU;
wire [(reg_width-1):0] bus_out;

//
AC #(.reg_width(reg_width)) unit (.write_en(write_en), .AC_in(AC_in), .clk(clk), .reset(reset), .ALU(ALU), .bus_out(bus_out));


initial begin
    
    @(posedge clk);
        reset <= 1'b1;

    @(posedge clk); //bus write
        #(CLK_PERIOD*4/5);
        write_en = 1'b1;                 
        AC_in = 12'b111000001000;        
        reset = 1'b0;

    

end


endmodule
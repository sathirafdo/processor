`timescale 1ps/1ps

module IR_tb;

localparam CLK_PERIOD = 10,
           IR_width = 12;

reg clk,reset;
initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

reg write_en;
reg [(IR_width-1):0] bus_data;
wire [(IR_width-1):0] dataout;

//
IR #(.IR_width(IR_width)) unit (.write_en(write_en),.clk(clk), .reset(reset), .bus_data(bus_data), .dataout(dataout));


initial begin
    
    @(posedge clk);
        reset = 1'b1;

    @(posedge clk);
        #(CLK_PERIOD*4/5);
        write_en=1'b1;
        bus_data = 12'b111111111111;
        reset = 1'b0;

    @(posedge clk);
        #(CLK_PERIOD*4/5);
        write_en=1'b1;
        bus_data = 12'b110000000011;
        reset = 1'b1;

end

endmodule
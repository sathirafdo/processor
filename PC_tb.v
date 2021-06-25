`timescale 1ps/1ps

module PC_tb;

localparam CLK_PERIOD = 10,
           current_PC_value = 12'b000000000000,
           reg_width = 12;

reg clk,reset;
initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end



reg write_en, increment;// PC_Inc = increment
reg [(reg_width-1):0] bus_data_in; // data from bus
wire [(reg_width-1):0] AR_data_out; // data out to AR

//
PC #(.reg_width(reg_width),.current_PC_value(current_PC_value)) unit (.write_en(write_en), .increment(increment), .clk(clk), .reset(reset), .bus_data_in(bus_data_in), .AR_data_out(AR_data_out));


initial begin
    
    @(posedge clk);
        reset <= 1'b1;

    @(posedge clk); //bus write
        #(CLK_PERIOD*4/5);
        write_en = 1'b1;                  
        bus_data_in = 12'b111000001000;        
        reset = 1'b0;

    @(posedge clk); // PC_en write
        #(CLK_PERIOD*4/5);
        write_en = 1'b0;                
        increment = 1'b1;
        reset = 1'b0;

end


endmodule
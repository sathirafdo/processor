`timescale 1ps/1ps

module Full_System_tb;

localparam CLK_PERIOD = 10,
           IR_width = 12,
           reg_count = 16,
           reg_width = 12,
           Im_width = 8,
           current_PC_value = 12'b000000000000;
           
           

reg clk,reset,start;

initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

    Full_System #(.reg_width(reg_width),.reg_count(reg_count), .IR_width(IR_width),.Im_width(Im_width),.current_PC_value(current_PC_value))
    system (.clk(clk),.reset(reset),.start(start));


initial begin
    
    @(posedge clk);
    reset =1'b1;

    @(posedge clk);
    #(CLK_PERIOD*4/5);
    reset =1'b0;
    start = 1'b1;

end
endmodule
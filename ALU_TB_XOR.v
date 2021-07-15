`timescale 1ps/1ps;

module ALU_TB_XOR;

localparam  CLK_PERIOD = 10,
            reg_width = 12;

reg clk;
initial begin
    clk = 0;
    forever begin
        #(CLK_PERIOD/2);
        clk = ~clk;
    end
end

reg reset;
reg [2:0] ALU_Operation;
reg [reg_width-1:0] AC,Bus;
wire [reg_width-1:0] result;

ALU #(.reg_width(reg_width)) alu_unit (.clk(clk), .reset(reset),
                                        .ALU_Operation(ALU_Operation),
                                        .AC(AC),
                                        .Bus(Bus),
                                        .result(result));

initial begin
    @(posedge clk);
    // reset = 1'b1;

    @(posedge clk);
    #(CLK_PERIOD*4/5);
    // reset = 1'b0;
    ALU_Operation = 3'b111;
    Bus = 12'b000011001000;
    AC = 12'b000011001100;

end

endmodule //ALU_TB_XOR
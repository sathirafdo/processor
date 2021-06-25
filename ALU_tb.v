`timescale 1ps/1ps

module ALU_tb;

localparam CLK_PERIOD = 10,
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
wire Zflag;
 
ALU #(.reg_width(reg_width)) unit (.clk(clk), .reset(reset), .ALU_Operation(ALU_Operation), .AC(AC), .Bus(Bus), .result(result), .Zflag(Zflag));

initial begin
    
    @(posedge clk);
        reset = 1'b1;

    @(posedge clk); //Pass
        #(CLK_PERIOD*4/5);
        reset = 1'b0;
        ALU_Operation = 3'b001;
        Bus = 12'b000011000000;

    @(posedge clk); //Add
        #(CLK_PERIOD*4/5);
        reset = 1'b0;
        ALU_Operation = 3'b010;
        Bus = 12'b000011001000;
        AC = 12'b010000000010; // output 010011001010

    @(posedge clk); //Sub Zflag = 0
        #(CLK_PERIOD*4/5);
        reset = 1'b0;
        ALU_Operation = 3'b011;
        AC = 12'b000000001000;
        Bus = 12'b000000000101;  //output 000000000011 =3    Z=0

    @(posedge clk); //Sub Zflag = 1
        #(CLK_PERIOD*4/5);
        reset = 1'b0;
        ALU_Operation = 3'b011;
        AC = 12'b000000001000;
        Bus = 12'b000000001000; // output 000000000000 Z=1

    @(posedge clk); //Mul
        #(CLK_PERIOD*4/5);
        reset = 1'b0;
        ALU_Operation = 3'b100;
        AC = 12'b000000001000;
        Bus = 12'b000000001001; // output 00000100100

    @(posedge clk); //Plus1 
        #(CLK_PERIOD*4/5);
        reset = 1'b0;
        ALU_Operation = 3'b101;
        AC = 12'b000000001000;  //output 000000001001
        
    @(posedge clk); //Zero  
        #(CLK_PERIOD*4/5);
        reset = 1'b0;
        ALU_Operation = 3'b110; //output

    @(posedge clk); //Idle  
        #(CLK_PERIOD*4/5);
        reset = 1'b0;
        ALU_Operation = 3'b000; //output

end
endmodule
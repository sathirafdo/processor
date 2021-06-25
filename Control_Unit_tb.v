`timescale 1ps/1ps

module Control_Unit_tb;

localparam CLK_PERIOD = 10,
           IR_width = 12,
           Reg_count =16;

reg clk,reset;

initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

    reg Zflag, start;
    reg [(IR_width-1):0] opcode;

    wire [2:0] alu_op;
    wire [Reg_count - 1:0] read_en, write_en;
    wire mem_write, PC_Inc;
    wire [1:0] mem_read;
//
Control_Unit #( .IR_width(IR_width),.Reg_count(Reg_count)) unit (.Zflag(Zflag),.start( start),.opcode(opcode),
                .reset(reset),.clk(clk),.alu_op(alu_op), .read_en(read_en),.write_en(write_en),
                .mem_write(mem_write),.PC_Inc(PC_Inc),.mem_read(mem_read));


initial begin
    
    @(posedge clk);
        reset = 1'b1;

    @(posedge clk);
        reset = 1'b0;
        start = 1'b1;
    //f1 f2 

    @(posedge clk);
        #(CLK_PERIOD*2);

    @(posedge clk);//clr
        #(CLK_PERIOD*4/5);
        Zflag = 1'b1;
        start = 1'b0;
        opcode =12'd0;
        reset = 1'b0; // read_en = 16'b0 write_en = 
    //f1 f2 clr1

    @(posedge clk);
        #(CLK_PERIOD*3);

    @(posedge clk);//load
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd1;
        reset = 1'b0;
    //f1 f2 load1 load2

    @(posedge clk);
        #(CLK_PERIOD*4);

    @(posedge clk);//mul
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd2;
        reset = 1'b0;
        //f1 f2 mul1

    @(posedge clk);
        #(CLK_PERIOD*3);

    @(posedge clk);//add
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd3;
        reset = 1'b0;
        //f1 f2 add1

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk); //sub
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd4;
        reset = 1'b0;
         //f1 f2 sub1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk);//inc
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd5;
        reset = 1'b0;
         //f1 f2 inc1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk);//jump
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd6;
        reset = 1'b0;
        //f1 f2 jump1 jump2

    @(posedge clk);
        #(CLK_PERIOD*4);
       
     @(posedge clk);// JUMPZ
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd7;
        reset = 1'b0;
        //f1 f2 JUMPZY1 JUMPZY2 

    @(posedge clk);
        #(CLK_PERIOD*4);
       
    @(posedge clk);// JUMPZ
        #(CLK_PERIOD*4/5);
        Zflag = 1'b1;
        start = 1'b0;
        opcode =12'd7;
        reset = 1'b0;
         //f1 f2  JUMPZN1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk);//MVAC_total
        #(CLK_PERIOD*4/5);
        Zflag = 1'b1;
        start = 1'b1;
        opcode =12'd8;
        reset = 1'b0;
        //f1 f2 MVAC_total1

    @(posedge clk);
        #(CLK_PERIOD*3);
       
    @(posedge clk);//MVAC_alphap
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd9;
        reset = 1'b0;
         //f1 f2 MVAC_alphap1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk);//MVAC_betap
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd10;
        reset = 1'b0;
        //f1 f2 MVAC_betap1 

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk);//MVAC_gammap
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd11;
        reset = 1'b0;
        //f1 f2 MVAC_gammap1 

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk);//MVAC_R
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd12;
        reset = 1'b0;
        //f1 f2 MVAC_R1

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk);//MVAC_row
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd13;
        reset = 1'b0;
         //f1 f2 MVAC_row1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk);//MVAC_cAT
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd14;
        reset = 1'b0;
        //f1 f2 MVAC_cAT1

    @(posedge clk);
        #(CLK_PERIOD*3);
       
     @(posedge clk);//MVAC_cB
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd15;
        reset = 1'b0;
        //f1 f2 MVAC_cB1 

    @(posedge clk);
        #(CLK_PERIOD*3);
       
    @(posedge clk);//MVAC_rnow
        #(CLK_PERIOD*4/5);
        Zflag = 1'b1;
        start = 1'b0;
        opcode =12'd16;
        reset = 1'b0;
        //f1 f2 MVAC_rnow1

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk);//MVAC_cAtnow
        #(CLK_PERIOD*4/5);
        Zflag = 1'b1;
        start = 1'b1;
        opcode =12'd17;
        reset = 1'b0;
        //f1 f2 MVAC_cAtnow

    @(posedge clk);
        #(CLK_PERIOD*3);
       
    @(posedge clk);//MVAC_cBnow
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd18;
        reset = 1'b0;
        //f1 f2 MVAC_cBnow1

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk);//MOV_total
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd19;
        reset = 1'b0;
         //f1 f2  MOV_total1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk); // MOV_alphap
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd20;
        reset = 1'b0;
        //f1 f2  MOV_alphap1

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk); //MOV_betap
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd21;
        reset = 1'b0;
         //f1 f2 MOV_betap1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk); //MOV_gammap
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd22;
        reset = 1'b0;
        //f1 f2 MOV_gammap1

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk); //MOV_R1
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd23;
        reset = 1'b0;
        //f1 f2 MOV_R1

    @(posedge clk);
        #(CLK_PERIOD*3);
       
     @(posedge clk); //MOV_row 
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd24;
        reset = 1'b0;
        //f1 f2 MOV_row1 

    @(posedge clk);
        #(CLK_PERIOD*3);
       
    @(posedge clk); //MOV_cAT 
        #(CLK_PERIOD*4/5);
        Zflag = 1'b1;
        start = 1'b0;
        opcode =12'd25;
        reset = 1'b0;
        //f1 f2 MOV_cAT1 

    @(posedge clk);
        #(CLK_PERIOD*3);
       
    @(posedge clk);//MOV_cB
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd26;
        reset = 1'b0;
        //f1 f2 MOV_cB1 

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk);//MOV_rnow
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd27;
        reset = 1'b0;
        //f1 f2 MOV_rnow1

    @(posedge clk);
        #(CLK_PERIOD*3);
           
    @(posedge clk);//MOV_cAtnow
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd28;
        reset = 1'b0;
         //f1 f2 MOV_cAtnow1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk); //MOV_cBnow
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd29;
        reset = 1'b0;
         //f1 f2  MOV_cBnow1

    @(posedge clk);
        #(CLK_PERIOD*3);
          
    @(posedge clk);//STORE
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd30;
        reset = 1'b0;
        //f1 f2 STORE1 STORE2

    @(posedge clk);
        #(CLK_PERIOD*4);
           
    @(posedge clk); //LOAD_REG
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd31;
        reset = 1'b0;
        //f1 f2 LOAD_REG1 LOAD_REG2 LOAD_REG3

    @(posedge clk);
        #(CLK_PERIOD*5);
       
     @(posedge clk);//ENDOP
        #(CLK_PERIOD*4/5);
        Zflag = 1'b0;
        start = 1'b0;
        opcode =12'd32;
        reset = 1'b0;    
        //f1 f2 ENDOP1

    @(posedge clk);
        #(CLK_PERIOD*3);
                
    @(posedge clk);
        #(CLK_PERIOD*4/5);
        reset = 1'b1;

end

endmodule
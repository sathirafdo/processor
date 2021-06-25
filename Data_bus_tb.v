`timescale 1ps/1ps

module Data_bus_tb;

localparam CLK_PERIOD = 10,
           Reg_count = 16,
           reg_width = 12;

reg clk,reset;
initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

reg [(Reg_count-1):0]  read_en;

reg [(reg_width-1):0] AC,Register_file,DR;       //PC, IR AND AR remove 
wire  [(reg_width-1):0] dataout;


//
Data_bus #(.Reg_count(Reg_count), .reg_width(reg_width)) unit (.read_en(read_en), .reset(reset), .AC(AC), .DR(DR), .Register_file(Register_file), .dataout(dataout) );


initial begin
    
    @(posedge clk);
        reset <= 1'b1;
    

    @(posedge clk); // AC
        #(CLK_PERIOD*4/5);
        read_en = 16'b0000000000000001;        
        AC = 12'b111000001000;
        
        Register_file = 12'b111000001111;       
        DR = 12'b000110001000;
        reset = 1'b0;
         

        @(posedge clk);//R
        #(CLK_PERIOD*4/5);
        read_en = 16'b0000000000010000;        
        AC = 12'b111000001000;
        
        Register_file = 12'b111000001111;
        
        DR = 12'b000110001000;
        reset = 1'b0;

        @(posedge clk);//row
        #(CLK_PERIOD*4/5);
        read_en = 16'b0000000000100000;        
        AC = 12'b111000001000;
        
        Register_file = 12'b111000001111;
        
        DR = 12'b000110001000;
        reset = 1'b0;

        @(posedge clk);//cAT
        #(CLK_PERIOD*4/5);
        read_en = 16'b0000000001000000;        
        AC = 12'b111000001000;
        Register_file = 12'b111000001111;
        DR = 12'b000110001000;
        reset = 1'b0;

        @(posedge clk);//no input => Register file output
        #(CLK_PERIOD*4/5);
        read_en = 16'b0000000000000000;        
        AC = 12'b111000001000;
        Register_file = 12'b111000001111;
        DR = 12'b000110001000;
        reset = 1'b0;

         @(posedge clk);//DR
        #(CLK_PERIOD*4/5);
        read_en = 16'b1000000000000000;        
        AC = 12'b111000001000;
        Register_file = 12'b111000001111;
        DR = 12'b000110001000;
        reset = 1'b0;
       
        

end


endmodule
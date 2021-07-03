module Data_bus
#(
    parameter Reg_count = 16,
    parameter reg_width = 12
)
(
    input wire [(Reg_count-1):0]  read_en,
    input wire reset,
    input wire [(reg_width-1):0] AC,Register_file,DR,        
    output reg  [(reg_width-1):0] dataout
);

//reg [(reg_width-1):0] out;
/*localparam AC = 16'b0000000000000001,
           PC =  16'b0000000000000010,
           AR = 16'b0000000000000100,
           IR = 16'b0000000000001000,
           R = 16'b0000000000010000,
           row =  16'b0000000000100000,
           cAT= 16'b0000000001000000,
           cB = 16'b0000000010000000,
           rnow=16'b0000000100000000,
           cATnow= 16'b0000001000000000,
           cBnow = 16'b0000010000000000,
           alphap = 16'b0000100000000000,
           betap = 16'b0001000000000000,
           gammap = 16'b0010000000000000,
           Total = 16'b0100000000000000,
           DR = 16'b1000000000000000;*/          


//registers ususally change with the clock.try to make it combinational using assign statements and
//relevant if statements using ? : statements if there are issues with this 

always @(read_en,reset) //NOTE check this whether is combinational
begin
    if (reset) 
        dataout = 12'b000000000000;
    else
    begin
        if(read_en[0] == 1'b1)
            dataout = AC;
        else if (read_en[15] == 1'b1)
            dataout = DR;
        else
            dataout = Register_file; 
            //NOTE if there are issues implement each regier file regiter commands
            //and also implement the read all disable instance
            // in this implementation it assumes that the output of the bus is no needed by anyone
            //if read is diabled for all registers. THerefore it just provides the value of regiter file input as the output
    end     
end    
endmodule
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
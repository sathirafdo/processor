/* TODO

always@(dataout)
    memory = dataout

Updated in the processor

*/

module DR
#(
    parameter reg_width=12
)
(
    input wire writeEn_frBus, writeEn_frDM, writeEn_frInsM, // read from bus, data memory and instruction memory
    //output bus_write,dM, // write to bus and data memory -always on ports
    input wire [(reg_width-1):0] bus_datain, DM_datain, InsM_datain,
    input wire clk,reset,
    output reg [(reg_width-1):0] dataout
    // dataout will be connceted to bus and the data memory
    // they will decide which to choose
    //below four are the connections with control unit signals
    // writeEn_frBus => write_en
    // writeEn_frDM => mem_read > Data_M
    // writeEn_frInsM => mem_read > Ins_M
    
);

always @(posedge clk) begin

    if (reset)
        dataout = 12'b000000000000;

    else if(writeEn_frInsM)
        dataout = InsM_datain; 

    else if (writeEn_frDM)      //high priorty is given to data memory write enable/
        dataout = DM_datain;    //this is necessary for proper fucntionality of load reg 2 micro instruction

    else if (writeEn_frBus)
        dataout = bus_datain;
    /*always @(writeEn_frBus, writeEn_frDM, writeEn_frInsM,reset) begin

    if (reset)
        dataout = 12'b000000000000;

    else if(writeEn_frInsM)
        dataout = InsM_datain; 

    else if (writeEn_frDM)      //high priorty is given to data memory write enable/
        dataout = DM_datain;    //this is necessary for proper fucntionality of load reg 2 micro instruction

    else if (writeEn_frBus)
        dataout = bus_datain;*/



    
    //else  TO DO: Insert else if need
    
end

endmodule


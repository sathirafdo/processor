module PC 
#(parameter reg_width = 12 , parameter current_PC_value = 12'b000000000000) // current_PC_value needed to be hard coded
(
    input wire write_en, increment,// PC_Inc = increment
    input wire clk, reset,
    input wire [(reg_width-1):0] bus_data_in, // data from bus
    output reg [(reg_width-1):0] AR_data_out // data out to AR
);

reg [reg_width-1:0] trash;


always @(posedge clk)
begin
    if(reset)
        AR_data_out = current_PC_value;
    else if(increment)
        AR_data_out = AR_data_out + +12'b000000000001;
    else if(write_en)
        AR_data_out = bus_data_in;
    //else
        // //AR_data_out = trash;

end

endmodule //PC

module IR
#(
    parameter IR_width = 12
)

(
    input wire write_en,
    input wire clk,reset,
    input wire [(IR_width-1):0] bus_data, 
    output reg [(IR_width-1):0] dataout // data out to CU,CU decides to take data in or not,
                                        //always on path
);

localparam trash= 12'bz;

always @(posedge clk ) begin

    if (reset)
        dataout = 12'b000000000000;  

    else if(write_en) // take data from bus
        dataout = bus_data;

    //else
        //dataout = trash;             
    
end


endmodule
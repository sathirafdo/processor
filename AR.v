
module AR
#(
    parameter reg_width=12
   
)

(
    input wire write_en,PC_en,// PC_en => PC read enable which unblock the PC,AR dedicated path
    input wire clk,reset,
    input wire [(reg_width-1):0] pc_datain, 
    input wire [(reg_width-1):0] bus_datain, // datain from pc, bus processor 
    output reg [(reg_width-1):0] dataout //dataout to memory ( IR and Data)   // selecting which -
    //- memory to access will be done in memory

);



reg [reg_width-1:0] trash;

always @(posedge clk ) begin
    
    if(PC_en) // PC_en and write_en //PC is considerd 1st so even enabling AR along with pc en stores pc data in AR
        dataout = pc_datain;

    else if (write_en)
        dataout= bus_datain;
    
    else if (reset)
        dataout = 12'b000000000000;    

    // else
    //     dataout = trash;             
    
end


endmodule
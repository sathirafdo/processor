module AC 
#(parameter reg_width=12) //need to decide the bit size
(
    input wire clk,reset,write_en, // control unit // read en should be handled by bus
    input wire [(reg_width-1):0] AC_in, // ALU output
    output reg [reg_width-1:0] ALU, //ALU input
    output reg [reg_width-1:0] bus_out // to the bus

);

always @(posedge clk) 
begin

    if(reset)
        begin        
   
            ALU = 12'b000000000000;
            bus_out = 12'b000000000000;
        end
        
    else if (write_en)
    begin
        ALU = AC_in;
		bus_out = AC_in;
    end
    
end
endmodule
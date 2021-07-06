module Multiport_Dynamic_ram
#(
    parameter mem_size = 4096,
    parameter mem_width = 12,
    parameter addr_width =12,
    parameter port_count = 2

)

 (
    input clk,reset,
    input [(addr_width*port_count-1):0] address,
    input [mem_width*port_count-1:0] datain,
    input [port_count -1 : 0] mem_write,     
    output reg [(mem_width*port_count-1):0] dataout
);
    
    

    reg [mem_width - 1:0] test_memory [mem_size -1 :0];

    initial begin
        $display("Loading rom.");
        $readmemh("Memory_Init.dat", test_memory);
    end
    
wire [addr_width -1:0] addr_blocks [port_count -1 :0];
wire [mem_width -1:0] data_in_blocks [port_count -1 :0];
wire [mem_width -1:0] data_out_blocks [port_count -1 :0];

genvar j;
generate        
for (j = 0; j < port_count ; j=j+1) begin  : conversion     
  assign addr_blocks[j] = address [(j+1)*addr_width-1 -:addr_width];
  assign data_in_blocks[j] = datain [(j+1)*mem_width-1 -:mem_width];
//   assign data_out_blocks[j]= dataout[(j+1)*mem_width-1 -:mem_width];
end
endgenerate 


    integer i;
always @(posedge clk) 
    begin
        if (reset== 1'b1)
        begin
            dataout = {(mem_width*port_count-1){1'b0}};
            // dataout2 = 12'b000000000000;
            $display("inside reset");
        end
        else
            begin
                $display("inside reset else");
                $display("mem write is outside for loop %b",mem_write);

            for (i = 0; i < port_count; i=i+1 ) 
                begin
                    $display("iteration count %d",i);
                    $display("mem write is %b",mem_write);
                    if(mem_write[i] ==1'b1) 
                    begin
                        $display("write thorugh port %d",i);
                        test_memory[addr_blocks[i]] = data_in_blocks[i];
                    end 

                    dataout[(i+1)*mem_width-1 -:mem_width] = test_memory[addr_blocks[i]];  

                end
            end
    end
endmodule
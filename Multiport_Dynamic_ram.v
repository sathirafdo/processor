module Multiport_Dynamic_ram
#(
    parameter mem_size = 4096,
    parameter mem_width = 12,
    parameter port_count = 2

)

 (
    input clk,reset,
    input [mem_width-1:0] address1,address2,
    input [mem_width-1:0] datain1,datain2,
    input mem_write1,mem_write2,     
    output reg [mem_width-1:0] dataout1,dataout2
);
    
    integer i;

    reg [mem_width - 1:0] test_memory [mem_size -1 :0];

    initial begin
        $display("Loading rom.");
        $readmemh("Memory_Init.dat", test_memory);
    end

    always @(posedge clk) begin

        if (reset== 1'b1)
        begin
            dataout1 = 12'b000000000000;
            dataout2 = 12'b000000000000;
            $display("inside reset");
        end
        else
            begin
            if(mem_write1==1'b1)        
                test_memory[address1] = datain1;
            if(mem_write2==1'b1)         
                test_memory[address2] = datain2;

            dataout1 = test_memory[address1];
            dataout2 = test_memory[address2];    

            end   

    end


    
endmodule
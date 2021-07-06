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

    always @(posedge clk) begin
        integer i;
        if (reset== 1'b1)
        begin
            dataout = {(mem_width*port_count-1){1'b0}};
            // dataout2 = 12'b000000000000;
            $display("inside reset");
        end
        else
            begin
            for (i = 0; port_count -1 < i; i=i+1 ) begin
                 if(mem_write[i] ==1'b1)
                    test_memory[(address[(i+1)*addr_width-1 -:addr_width] = datain[(i+1)*mem_widthz-1 -:mem_width];
                // test_memory[address[(i+1)*addr_width -1 :i*addr_width]] = datain[(i+1)*mem_width -1 :i*mem_width];
                //dataout 
                //TODO !!!!!!!!!!!!!!!!!!!!!!!!!!! uncomment below part
                dataout[(i+1)*mem_width-1 -:mem_width] = test_memory[address[(i+1)*addr_width-1 -:addr_width]];
            end

            // if(mem_write1==1'b1)        
            //     test_memory[address1] = datain1;
            // if(mem_write2==1'b1)         
            //     test_memory[address2] = datain2;

            // dataout1 = test_memory[address1];
            // dataout2 = test_memory[address2];    

            end   

    end


    
endmodule
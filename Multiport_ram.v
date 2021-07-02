module Multiport_ram
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
    input fright,
    output reg [mem_width-1:0] dataout1,dataout2
);
    //TODO VERY IMPORTANT remove fright input port
    integer i;

    reg [mem_width - 1:0] test_memory [mem_size -1 :0];

    initial begin
        $display("Loading rom.");
        $readmemh("Memory_Init.dat", test_memory);
        //fd = $fopen("my_file.txt", "w");  
    end

    always @(posedge clk) begin
        
        //# 10;

        if (reset== 1'b1)
        begin
            // datain1 = 12'b000000000000;
            // datain2 = 12'b000000000000;
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

            

        /*if(fright==1'b1)
            begin
                for (i=0;i<mem_size;i=i+1)
                    $fwrite(fd,test_memory[i]);
                
                $fclose(fd);
            end */
        // dataout1 = 12'bx;
        // dataout2 = 12'bx;
        
        

    end


    
    

    
endmodule
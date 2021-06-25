`timescale 1ps/1ps

module Register_file_tb;

localparam CLK_PERIOD = 10,
           reg_count = 10+1,
           reg_width = 12;

reg clk;
initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

reg [reg_count-1:0] read_en, write_en;
reg reset;
reg [reg_width-1:0] datain;
wire [(reg_width-1):0] dataout;


//
Register_File #(.reg_count(reg_count), .reg_width(reg_width)) unit (.read_en(read_en), .write_en(write_en), .clk(clk), .reset(reset), .datain(datain), .dataout(dataout));


initial begin
    
    @(posedge clk);
        reset <= 1'b1;
    

    @(posedge clk);
        #(CLK_PERIOD*4/5);
        read_en = 11'b00000000000;
        write_en = 11'b00000000001; // write to R and Total
        datain = 12'b11100000100;
        reset = 1'b0;
        
    @(posedge clk);
        #(CLK_PERIOD*4/5); 
        read_en = 11'b00000000001; // read from R
        write_en = 11'b00000000000; 
        datain = 12'b11010000100;
        reset = 1'b0;
        
       
    

end


endmodule
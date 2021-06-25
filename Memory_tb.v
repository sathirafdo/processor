`timescale 1ps/1ps

module Memory_tb;

localparam CLK_PERIOD = 10;
           

reg clk;

initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end
reg [11:0] AR;
reg [11:0] address_sig;
reg [11:0] data_sig;
reg wren_sig;
wire [11:0] q_sig;
reg [11:0] DR;
integer i;

MemoryQ	MemoryQ_inst (
	.address ( address_sig ),
	.clock ( clk ),
	.data ( data_sig ),
	.wren ( wren_sig ),
	.q ( q_sig )
	);

initial begin

    /*@(posedge clk);
        address_sig = 12'b000000000000;
        wren_sig =1'b0;

    @(posedge clk);
        #(CLK_PERIOD*1);
    
    for (i=1;i<88;i=i+1)
        begin
        @(posedge clk);
        address_sig = address_sig + 12'b000000000001;
        wren_sig =1'b0;
        end*/
    @(posedge clk);
        //#(CLK_PERIOD*4/5);
        address_sig = 12'b000000000000;
        data_sig = 12'b000010101000;        
        wren_sig =1'b0;

    //@(posedge clk);
       // #(CLK_PERIOD*1);

    @(posedge clk);
        //#(CLK_PERIOD*4/5);
        address_sig = 12'b000000000001;
        data_sig = 12'b000000000000;
        wren_sig =1'b0;

    //@(posedge clk);
        //#(CLK_PERIOD*1)

    @(posedge clk);
        //#(CLK_PERIOD*4/5);
        address_sig = 12'b000000010000;
        data_sig = 12'b111100001111;        
        wren_sig =1'b1;

    //@(posedge clk);
        //#(CLK_PERIOD*1)

    @(posedge clk);
        //#(CLK_PERIOD*4/5);
        address_sig = 12'b000000000001;
        data_sig = 12'b000000000000;
        y = q_sig;
        wren_sig =1'b0;
end

endmodule
`timescale 1ps/1ps
module Processor_Multiport_tb;

// Processor Parameters
parameter CLK_PERIOD            = 10              ;
parameter reg_width         = 12              ;
parameter reg_count         = 16              ;
parameter reg_file_count    = 11              ;
parameter IR_width          = 12              ;
parameter Im_width          = 8               ;
parameter current_PC_value  = 12'b000000000000;

// Processor Inputs
reg   start                                = 0 ;
reg   clk                                  = 0 ;
reg   reset                                = 0 ;

// Processor Outputs


initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

Processor_Multiport #(
    .reg_width        ( reg_width        ),
    .reg_count        ( reg_count        ),
    .reg_file_count   ( reg_file_count   ),
    .IR_width         ( IR_width         ),
    .Im_width         ( Im_width         ),
    .current_PC_value ( current_PC_value ))
 u_Processor (
    .start                   ( start   ),
    .clk                     ( clk     ),
    .reset                   ( reset   )
);

initial begin
    
    @(posedge clk);
    reset =1'b1;

    @(posedge clk);
    #(CLK_PERIOD*4/5);
    reset =1'b0;
    start = 1'b1;

    @(posedge clk);
    start = 1'b0;
    
    // $finish;
end

endmodule
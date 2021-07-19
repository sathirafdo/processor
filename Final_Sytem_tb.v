`timescale 1ps/1ps
module Final_System_tb;

// Processor Parameters
parameter CLK_PERIOD        = 10              ;
parameter reg_width         = 12              ;
parameter reg_count         = 16              ;
parameter reg_file_count    = 11              ;
parameter IR_width          = 12              ;
parameter Im_width          = 8               ;
parameter current_PC_value  = 12'b000000000000; //IMPORTANT !!!
parameter core_count        = 4               ; //Remember to change the core count value in
                                                //dat and mif files when you change the core count

// Processor Inputs
reg   start                                = 0 ;
reg   clk                                  = 0 ;
reg   reset                                = 0 ;

// Processor Outputs
wire [core_count-1:0] endop_signal;

initial begin
    clk <= 0;
    forever begin
        #(CLK_PERIOD/2);
        clk <= ~clk;
    end
end

Final_System #(
    .reg_width        ( reg_width        ),
    .reg_count        ( reg_count        ),
    .reg_file_count   ( reg_file_count   ),
    .IR_width         ( IR_width         ),
    .Im_width         ( Im_width         ),
    .current_PC_value ( current_PC_value ),
    .core_count       (core_count       ))

 u_System (
    .start                   ( start   ),
    .clk                     ( clk     ),
    .reset                   ( reset   ),
    .endop_signal           (endop_signal)
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
always @(posedge clk) 
begin
    if (endop_signal[0]==1'b1)  //TODO link other core endop signals
        begin
        $display("Finishing");
        $stop;
        end
    
end


endmodule
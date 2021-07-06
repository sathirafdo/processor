`timescale  1ns / 1ps

module Multiport_Dynamic_ram_tb;

// Multiport_Dynamic_ram Parameters
parameter PERIOD      = 10  ;
parameter mem_size    = 4096;
parameter mem_width   = 12  ;
parameter addr_width  = 12  ;
parameter port_count  = 2   ;

// Multiport_Dynamic_ram Inputs
reg   clk                                  = 0 ;
reg   reset                                = 0 ;
reg   [(addr_width*port_count-1):0]  address = 0 ;
reg   [mem_width*port_count-1:0]  datain   = 0 ;
reg   [port_count -1 : 0]  mem_write       = 0 ;

// Multiport_Dynamic_ram Outputs
wire  [(mem_width*port_count-1):0]  dataout ;


initial begin
clk <= 0;
forever begin
    #(PERIOD/2);
    clk <= ~clk;
end
end

/*initial
begin
    #(PERIOD*2) rst_n  =  1;
end*/

Multiport_Dynamic_ram #(
    .mem_size   ( mem_size   ),
    .mem_width  ( mem_width  ),
    .addr_width ( addr_width ),
    .port_count ( port_count ))
 u_Multiport_Dynamic_ram (
    .clk                     ( clk                                      ),
    .reset                   ( reset                                    ),
    .address                 ( address    [((addr_width*port_count)-1):0] ),
    .datain                  ( datain    [((addr_width*port_count)-1):0] ),
    .dataout                 ( dataout    [((mem_width*port_count)-1):0]  ),
    .mem_write               ( mem_write  [port_count -1 : 0] )
);


initial
begin

    @(posedge clk);
        reset = 1'b1;

    @(posedge clk);
        reset = 1'b0;

    @(posedge clk);
        #(PERIOD);

    // @(posedge clk);
    // begin
    //     address1 = 12'b0;
    //     address2 = 12'b1;        
    // end

    @(posedge clk);
        begin
        address = 24'b000000000000000000000001;  //0
        mem_write = 2'b01;
        datain = 24'b000000000101111111111001;  
        end

    @(posedge clk);
        #(PERIOD);

    @(posedge clk);
        begin
        address = 24'b000000000000000000000001;  //0
        mem_write = 2'b00;
        datain = 24'b000000000101111111111001;  
        end

    @(posedge clk);
        #(PERIOD);
        
    @(posedge clk);
        begin
        address = 24'b000000000100000000001000;  //4
        mem_write = 2'b11;
        datain = 24'b000000000100000000001000;  //4
        end

    @(posedge clk);
        #(PERIOD);

    @(posedge clk);
        begin
         // A garbage value(not the datain) has been written even when mem_witite =1'b0
        mem_write = 1'b00;
        address = 24'b000000000000000000000001;  //0
  //2
        /*datain1 =  24'b011100000101111000001000;  //2
        
        // mem_write2 = 1'b0;
        // address2 = 12'b000000000011; //3
        // datain2  = 24'b011100000100000000001000; //3  */
    @(posedge clk);
        #(PERIOD);    
        end


    @(posedge clk);
        begin
        address = 24'b000000000111000000001100;  //7
                 
        end

    @(posedge clk);
        $stop; 


    
    //$finish;
end

endmodule

/*

module Multiport_Dynamic_ram_tb;

// Multiport_Dynamic_ram Parameters
parameter PERIOD      = 10  ;
parameter mem_size    = 4096;
parameter mem_width   = 12  ;
parameter addr_width  = 12  ;
parameter port_count  = 2   ;

// Multiport_Dynamic_ram Inputs
reg   clk                                  = 0 ;
reg   reset                                = 0 ;
reg   [(addr_width*port_count-1):0]  address = 0 ;
reg   [mem_width*port_count-1:0]  datain   = 0 ;
reg   [port_count -1 : 0]  mem_write       = 0 ;

// Multiport_Dynamic_ram Outputs
wire  [(mem_width*port_count-1):0]  dataout ;


initial begin
clk <= 0;
forever begin
    #(PERIOD/2);
    clk <= ~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

Multiport_Dynamic_ram #(
    .mem_size   ( mem_size   ),
    .mem_width  ( mem_width  ),
    .addr_width ( addr_width ),
    .port_count ( port_count ))
 u_Multiport_Dynamic_ram (
    .clk                     ( clk                                      ),
    .reset                   ( reset                                    ),
    .address                 ( address    [(addr_width*port_count-1):0] ),

    .dataout                 ( dataout    [(mem_width*port_count-1):0]  )
);

initial
begin

    $finish;
end

endmodule
*/

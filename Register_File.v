module Register_File
#(  parameter reg_count = 11, // Register files + R register
    parameter reg_width = 12,
    parameter core_number=0
)
(
    
    input wire [(reg_count-1):0] read_en, write_en, //control signals
    input wire clk,reset,
    input wire [(reg_width-1):0] datain, // data from bus
    output wire [(reg_width-1):0] dataout

);


reg [reg_width:0] trash; // trash value to assign at default case


reg [(reg_width-1):0] reg_set [(reg_count-1):0];

localparam  R = 0,
            row = 1,
            cAT= 2,
            cB = 3,
            rnow= 4,
            cATnow= 5,
            cBnow = 6,
            alphap = 7,
            betap = 8,
            gammap = 9,
            Total = 10;

localparam  R_en =  11'b00000000001,
            row_en =  11'b00000000010,
            cAT_en = 11'b00000000100,
            cB_en = 11'b00000001000,
            rnow_en = 11'b00000010000,
            cATnow_en = 11'b00000100000,
            cBnow_en = 11'b00001000000,
            alphap_en = 11'b00010000000,
            betap_en = 11'b00100000000,
            gammap_en = 11'b01000000000,
            Total_en = 11'b10000000000; // None state*/

integer i;
always @( posedge clk ) 
begin
    if (reset) 
		begin
        
        for (i = 0 ; i< reg_count-1 ;i=i+1 ) 
        begin
            reg_set[i] = 12'b00000000000 ;           
        end
            reg_set[Total] = core_number ;
            //NOTE : in the instrction order remember to reset total before calculations start
        //KLT 1st law reg_set[betap] = 12'b00100011010 ;
		  end
    else         
    begin
        if (write_en[R] == 1'b1     )
            reg_set[R]    = datain;
        else if (write_en[row] == 1'b1)
            reg_set[row]  = datain;
        else if (write_en[cAT] == 1'b1)
            reg_set[cAT]  = datain;
        else if (write_en[cB] == 1'b1)
            reg_set[cB]   = datain;
        else if (write_en[rnow] == 1'b1)
            reg_set[rnow]  = datain;
        else if (write_en[cATnow] == 1'b1)
            reg_set[cATnow] = datain;
        else if (write_en[cBnow] == 1'b1)
            reg_set[cBnow]  = datain;
        else if (write_en[alphap] == 1'b1)
            reg_set[alphap]  = datain;
        else if (write_en[betap] == 1'b1)
        begin
            $display("beta p ekataq aava. seethala vathura veeduruvak bomu",write_en,read_en);
            reg_set[betap]  = datain;
        end
        else if (write_en[gammap] == 1'b1)
            reg_set[gammap]  = datain;
        else if (write_en[Total] == 1'b1)
            reg_set[Total]  = datain;
               
		// KLT constant 12'b11100011011
          
        
    end
       
end

assign dataout= (read_en == R_en      ) ?  reg_set[R]:
                (read_en == row_en    ) ?  reg_set[row]:
                (read_en == cAT_en    ) ?  reg_set[cAT]:
                (read_en == cB_en     ) ?  reg_set[cB]:
                (read_en == rnow_en   ) ?  reg_set[rnow]:
                (read_en == cATnow_en ) ?  reg_set[cATnow]:
                (read_en == cBnow_en  ) ?  reg_set[cBnow]:
                (read_en == alphap_en ) ?  reg_set[alphap]:
                (read_en == betap_en  ) ?  reg_set[betap]:
                (read_en == gammap_en ) ?  reg_set[gammap]:
                (read_en == Total_en  ) ?  reg_set[Total]: 
                reg_set[betap];

endmodule


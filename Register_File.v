module Register_File
#(  parameter reg_count = 11, // Register files + R register
    parameter reg_width = 12
)

(
    
    input wire [(reg_count-1):0] read_en, write_en, //control signals
    input wire clk,reset,
    input wire [(reg_width-1):0] datain, // data from bus
    // output reg [(reg_width-1):0] dataout //data to register files+R
    output wire [(reg_width-1):0] dataout

);


reg [reg_width:0] trash; // trash value to assign at default case
//reg [(reg_count-1):0] read;
//reg [(reg_count-1):0] write;

//assign read = read_en;
//assign write = write_en;

reg [(reg_width-1):0] reg_set [(reg_count-1):0];

localparam betap_reset = 12'd900,
           gammap_reset = 12'd1600;

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
        
        for (i = 0 ; i< reg_count-3 ;i=i+1 ) 
        begin
            reg_set[i] = 12'b00000000000 ;           
        end

        //KLT 1st law 
        reg_set[betap] = betap_reset ;
        reg_set[gammap] = gammap_reset;
        reg_set[Total_en] = 12'b000000000000;
        
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
          
        /*for (i=0;i<reg_count;i=i+1)
        begin
            if (read_en[i]==1'b1)
                begin
                    dataout = reg_set[i];
                                   
                end
            // TODO - Do we need to add a delay ?
            if (write_en[i]==1'b1)
                begin
                    reg_set[i] = datain;
                                   
                end
            else
                dataout = 12'b000000000000;
            
        end*/
        /*if (read_en)
            begin
                dataout = reg_set[betap] ;

            case (read_en)
                R_en : dataout = reg_set[R] ;
                row_en : dataout = reg_set[row] ;
                cAT_en : dataout = reg_set[cAT] ;
                cB_en : dataout = reg_set[cB] ;
                rnow_en : dataout = reg_set[rnow] ;
                cATnow_en : dataout = reg_set[cATnow] ;
                cBnow_en : dataout = reg_set[cBnow] ;
                alphap_en : dataout = reg_set[alphap] ;
                betap_en : dataout = reg_set[betap] ;
                gammap_en : dataout = reg_set[gammap] ;
                Total_en: dataout = reg_set[Total] ;
                default : dataout = 12'b101010101010; //TODO change back to 12'b0            
            endcase 
            end
        
        else 
         if(write_en)
            begin
            case (write_en)
                R_en : reg_set[R] = 12'b11100011011 ;
                row_en : reg_set[row] = 12'b11100011011 ;
                cAT_en : reg_set[cAT] = 12'b11100011011 ;
                cB_en : reg_set[cB] = 12'b11100011011 ;
                rnow_en : reg_set[rnow] = 12'b11100011011 ;
                cATnow_en : reg_set[cATnow] = 12'b11100011011 ;
                cBnow_en : reg_set[cBnow] = 12'b11100011011 ;
                alphap_en : reg_set[alphap] = 12'b11100011011 ;
                betap_en : reg_set[betap] = 12'b11100011011 ;
                gammap_en : reg_set[gammap] = 12'b11100011011 ;
                Total_en: reg_set[Total] = 12'b11100011011 ;
                //default: trash <= datain;
            endcase
            end*/
    end
    //R_reg <= reg_set[R];
    //Total_reg <= reg_set[Total];   
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


/*      case (read_en)
            R_en : dataout <= reg_set[R] ;
            row_en : dataout <= reg_set[row] ;
            cAT_en : dataout <= reg_set[cAT] ;
            cB_en : dataout <= reg_set[cB] ;
            rnow_en : dataout <= reg_set[rnow] ;
            cATnow_en : dataout <= reg_set[cATnow] ;
            cBnow_en : dataout <= reg_set[cBnow] ;
            alphap_en : dataout <= reg_set[alphap] ;
            betap_en : dataout <= reg_set[betap] ;
            gammap_en : dataout <= reg_set[gammap] ;
            Total_en: dataout <= reg_set[Total] ;
            default : dataout <= 12'b000000000000;             
        endcase 

        case (write_en)
            R_en : reg_set[R] <= datain ;
            row_en : reg_set[row] <= datain ;
            cAT_en : reg_set[cAT] <= datain ;
            cB_en : reg_set[cB] <= datain ;
            rnow_en : reg_set[rnow] <= datain ;
            cATnow_en : reg_set[cATnow] <= datain ;
            cBnow_en : reg_set[cBnow] <= datain ;
            alphap_en : reg_set[alphap] <= datain ;
            betap_en : reg_set[betap] <= datain ;
            gammap_en : reg_set[gammap] <= datain ;
            Total_en: reg_set[Total] <= datain ;
            default: trash <= datain;
        endcase*/


 //Register_File
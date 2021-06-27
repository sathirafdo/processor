module ALU 
#( parameter reg_width=12 )
(
	input clk,reset,
	input [2:0] ALU_Operation, // comes from the control unit
	input [reg_width-1:0] AC,Bus, // data from AC and Bus
	// output reg [reg_width-1:0] result,// output to AC
	// output reg Zflag
	output wire [reg_width-1:0] result,
	output reg Zflag
);

localparam IDLE = 3'b000,
           Pass = 3'b001,
           Add = 3'b010,
           Sub = 3'b011,
           Mul = 3'b100,
           Plus1 = 3'b101,
           Zero = 3'b110;

//combiinational part


assign result =(ALU_Operation == IDLE) ? 12'bx : 
           			(ALU_Operation == Pass) ? Bus :
					(ALU_Operation == Add) ? AC + Bus :
					(ALU_Operation == Sub) ? AC - Bus :
					(ALU_Operation == Mul) ? AC*Bus :
					(ALU_Operation == Plus1) ? AC+12'b000000000001 :
					(ALU_Operation == Zero) ? 12'b000000000000 :
           			12'bx;

always@(result) 
begin
	if (ALU_Operation == Sub)
	begin
	if(result == 12'b000000000000)
		begin
		Zflag =  1'b1;
		$display("inside a z flag zero operation result is zero");
		end
	else
	begin
		Zflag =  1'b0;
		$display("inside z lfag result not zero");
	end
	end
end
					   
//combiinational part ends here

//   always @( reset,ALU_Operation ) 
//   begin
// 		if (reset) 
// 			begin			
// 				result = 12'b000000000000;
// 				Zflag = 1'b0;
// 			end		
			
// 		else      

// 			begin
// 				case(ALU_Operation)
// 					IDLE :
// 						result = 12'bx;
// 					Pass:
// 						result = Bus;						
// 					Add:
// 						result = AC + Bus;
// 					Sub:
// 						result = AC - Bus;
// 					Mul:
// 						result = AC*Bus;
// 					Plus1:
// 						result = AC+12'b000000000001;
// 					Zero:
// 						result = 12'b000000000000;
// 					default:
// 						result = 12'bx;
// 				endcase
// 			end
			
// 		if (result==12'b000000000000)
// 			Zflag = 1'b1;
// 		else
// 			Zflag = 1'b0;
			
// 	end
	endmodule

/*module add_sub
#(parameter reg_width=12) // TO DO: Need to deside the bit size for data
(
	input signed [reg_width-1:0] dataa,
	input signed [reg_width-1:0] datab,
	input add_sub,	  // if this is 1, add; else subtract
	output reg [reg_width-1:0] result,
	output reg Zflag
);
	
	if (add_sub)
		result = dataa + datab;
	else
		begin
		result = dataa - datab;
		if (result==12'b000000000000)
			Zflag=1'b1;
		else
			Zflag=1'b0;
		end
	

endmodule


module Mul
#(parameter reg_width=12)      // TO DO: Need to deside the bit size for data
(
	input signed [reg_width-1:0] dataa,
	input signed [reg_width-1:0] datab,
	output reg signed [reg_width-1:0] dataout
);

	// Declare input and output registers
	reg signed [reg_width-1:0] dataa_reg;
	reg signed [reg_width-1:0] datab_reg;
	wire signed [reg_width-1:0] mult_out;

	// Store the result of the multiply
	assign dataout = dataa * datab;

	// Update data
	
	dataa_reg = dataa;
	datab_reg = datab;
	dataout = mult_out;
	

endmodule

module increment         // TO DO: Need to deside the bit size for data
#(parameter reg_width = 12) // did not consider the  data overflows
(
	input signed wire [reg_width-1:0] AC,
    output signed reg [reg_width-1:0] inc_out
);
	assign inc_out = AC + 1;
	
endmodule

module pass
#(parameter reg_width = 12)
(
    input wire [reg_width-1:0] bus_out, //reg_width is the number of bits for data
	output wire [reg_width-1:0] AC_in  // TO DO: Need to deside the bit size for data
)
    assign AC_in = bus_out;

endmodule

//TODO not completed
module Idle 
#(parameter reg_width = 12)
(

);
always @(posedge clk)
begin
	
end
	
endmodule

module Zero 
#(parameter reg_width = 12)
(
	output wire [reg_width-1:0] AC_zero // TO DO: Need to deside the bit size for data
    
);
(
	
	assign AC_zero = 0;
	
)
endmodule*/

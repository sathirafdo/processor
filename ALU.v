module ALU 
#( parameter reg_width=12 )
(
	input clk,reset,
	input [2:0] ALU_Operation, // comes from the control unit
	input [reg_width-1:0] AC,Bus, // data from AC and Bus
	output [reg_width-1:0] result
	//moved z flag to ac
);

localparam IDLE = 3'b000,
           Pass = 3'b001,
           Add = 3'b010,
           Sub = 3'b011,
           Mul = 3'b100,
           Plus1 = 3'b101,
           Zero = 3'b110;

//combinational part

assign result =(ALU_Operation == IDLE) ? 12'bx : 
           			(ALU_Operation == Pass) ? Bus :
					(ALU_Operation == Add) ? AC + Bus :
					(ALU_Operation == Sub) ? AC - Bus :
					(ALU_Operation == Mul) ? AC*Bus :
					(ALU_Operation == Plus1) ? AC+12'b000000000001 :
					(ALU_Operation == Zero) ? 12'b000000000000 :
           			12'bx;

	endmodule
module Control_Unit
#(
    parameter IR_width = 12,
    parameter Reg_count = 16
) 
(
    input wire clk, start, reset, Zflag, // if reset = 1(active high)
    input wire [IR_width - 1:0] opcode, //opcode to IR

    output reg [2:0] alu_op,
    output reg [Reg_count - 1:0] read_en, write_en,
    output reg mem_write, PC_Inc,
    output reg [1:0] mem_read,

    output reg endop_signal

);

//Data Memory or Instruction Memory access control signal
localparam [1:0]
           Null0 = 2'b00,
           DataM = 2'b01,
           InsM = 2'b10;
           

// Registers
localparam [15:0]
           AC = 16'b0000000000000001,
           PC =  16'b0000000000000010,
           AR = 16'b0000000000000100,
           IR = 16'b0000000000001000,
           R = 16'b0000000000010000,
           row =  16'b0000000000100000,
           cAT= 16'b0000000001000000,
           cB = 16'b0000000010000000,
           rnow=16'b0000000100000000,
           cATnow= 16'b0000001000000000,
           cBnow = 16'b0000010000000000,
           alphap = 16'b0000100000000000,
           betap = 16'b0001000000000000,
           gammap = 16'b0010000000000000,
           Total = 16'b0100000000000000,
           DR = 16'b1000000000000000,
           None = 16'b0000000000000000;

// Instructions
localparam [11:0]
           CLR = 12'd0,
           LOAD = 12'd1,
           MUL = 12'd2,
           ADD = 12'd3,
           SUB = 12'd4,
           INC = 12'd5,
           JUMP = 12'd6,
           JUMPZ = 12'd7,
           MVAC_total = 12'd8,
           MVAC_alphap = 12'd9,
           MVAC_betap = 12'd10,
           MVAC_gammap = 12'd11,
           MVAC_R = 12'd12,
           MVAC_row = 12'd13,
           MVAC_cAT = 12'd14,
           MVAC_cB = 12'd15,
           MVAC_rnow = 12'd16,
           MVAC_cAtnow = 12'd17,
           MVAC_cBnow = 12'd18,
           MOV_total = 12'd19,
           MOV_alphap = 12'd20,
           MOV_betap = 12'd21,
           MOV_gammap = 12'd22,
           MOV_R = 12'd23,
           MOV_row = 12'd24,
           MOV_cAT = 12'd25,
           MOV_cB = 12'd26,
           MOV_rnow = 12'd27,
           MOV_cAtnow = 12'd28,
           MOV_cBnow = 12'd29,
           STORE = 12'd30,
           LOAD_REG = 12'd31,
           ENDOP = 12'd32;

//ALU Operations
localparam [2:0]
           IDLE = 3'b000,
           Pass = 3'b001,
           Add = 3'b010,
           Sub = 3'b011,
           Mul = 3'b100,
           Plus1 = 3'b101,
           Zero = 3'b110;

//States
localparam [5:0]
           Idle = 6'd0,
           FETCH1 = 6'd1,
           FETCH2 = 6'd2,
           FETCH3 = 6'd3,
           CLR1 = 6'd4,
           LOAD1 = 6'd5,
           LOAD2 = 6'd6,
           MUL1 = 6'd7,
           ADD1 = 6'd8,
           SUB1 = 6'd9,
           INC1 = 6'd10,
           JUMP1 = 6'd11,
           JUMP2 = 6'd12,
           MVAC_total1 = 6'd13,
           MVAC_alphap1 = 6'd14,
           MVAC_betap1 = 6'd15,
           MVAC_gammap1 = 6'd16,
           MVAC_R1 = 6'd17,
           MVAC_row1 = 6'd18,
           MVAC_cAT1 = 6'd19,
           MVAC_cB1 = 6'd20,
           MVAC_rnow1 = 6'd21,
           MVAC_cAtnow1 = 6'd22,
           MVAC_cBnow1 = 6'd23,
           MOV_total1 = 6'd24,
           MOV_alphap1 = 6'd25,
           MOV_betap1 = 6'd26,
           MOV_gammap1 = 6'd27,
           MOV_R1 = 6'd28,
           MOV_row1 = 6'd29,
           MOV_cAT1 = 6'd30,
           MOV_cB1 = 6'd31,
           MOV_rnow1 = 6'd32,
           MOV_cAtnow1 = 6'd33,
           MOV_cBnow1 = 6'd34,
           STORE1 = 6'd35,
           STORE2 = 6'd36,
           LOAD_REG1 = 6'd37,
           LOAD_REG2 = 6'd38,
           LOAD_REG3 = 6'd39,
           JUMPZY1 = 6'd40,
           JUMPZY2 = 6'd41,
           JUMPZN1 = 6'd42,
           ENDOP1 = 6'd43,
           LOAD3 = 6'd44,
           LOAD4 = 6'd45,
           FETCH4 = 6'd46,
           LOAD5 = 6'd47,
           JUMPZY3 = 6'd48,
           JUMPZN2 = 6'd49,
           LOAD_REG4= 6'd50,
           JUMP3 = 6'd51,
           STORE3 = 6'd52 ;    


reg [5:0] current_st, next_st;

always @(posedge clk) begin
    if (reset) begin
        
        current_st = Idle;
    end
    else begin
        current_st = next_st;
    end
end

always @(*) begin // 
    
    //next_st = current_st;

    write_en = 16'bx;
    read_en = 16'bx;
    mem_read = 2'bx;  
    mem_write = 1'bx;         
    alu_op = 3'bx;
    PC_Inc = 1'bx;  
    

    case (current_st)
        Idle : begin
            
            if (start)
                begin

                
                $display("start");
                write_en = 16'bx;
                read_en = 16'bx;
                mem_read = 2'bx;  
                mem_write = 1'bx;         
                alu_op = 3'bx;
                PC_Inc = 1'bx;
                endop_signal =1'b0;  

                next_st = FETCH1;
                end
				
            else
                
				begin
                $display("idle");
                write_en = 16'bx;
                read_en = 16'bx;
                mem_read = 2'bx;  
                mem_write = 1'bx;         
                alu_op = 3'bx;
                PC_Inc = 1'bx;
                next_st = Idle;	 
                end 
        end      
                
        FETCH1 : begin
            $display("FETCH1");
            write_en = AR;
            read_en = PC;
            mem_read = Null0; // when the mem_read enable get the value store some where, 
            mem_write = 1'b0;         
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH2;            
            end

        FETCH2 : begin
            $display("FETCH2");
            write_en = DR;  //this is useless. just put here for convention.write en dr controls bus input.
                            //but in DR we have indicated if there is a memread signal data is written in from memory
            read_en = None;            
            mem_read = InsM; // Not sure //check whether if the memory provides the data and stores in smewhere temprorry to stre in DR
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b1;
            next_st = FETCH3;
            end

        FETCH3:
			begin
            $display("FETCH3");
            write_en = IR | AR;
            read_en = DR | PC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;  //IR should be directly connecte to the Control unit 
            next_st = FETCH4;
            end
        FETCH4:
            begin
            $display("FETCH4");
            write_en = None;
            read_en = None;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;  //IR should be directly connecte to the Control unit            
            case (opcode)
                CLR : next_st = CLR1; 
                LOAD : next_st = LOAD1;
                MUL : next_st = MUL1;
                ADD : next_st = ADD1;
                SUB : next_st = SUB1;
                INC : next_st = INC1;
                JUMP : next_st = JUMP1;
                JUMPZ :begin
                if (Zflag == 1'b1)  
                    next_st = JUMPZY1; 
                else 
                    next_st = JUMPZN1;
                end
                MVAC_total : next_st = MVAC_total1;
                MVAC_alphap : next_st = MVAC_alphap1;
                MVAC_betap : next_st = MVAC_betap1;
                MVAC_gammap : next_st = MVAC_gammap1;
                MVAC_R : next_st = MVAC_R1;
                MVAC_row : next_st = MVAC_row1;
                MVAC_cAT : next_st = MVAC_cAT1;
                MVAC_cB : next_st = MVAC_cB1;
                MVAC_rnow : next_st = MVAC_rnow1;
                MVAC_cAtnow : next_st = MVAC_cAtnow1;
                MVAC_cBnow : next_st = MVAC_cBnow1;
                MOV_total : next_st = MOV_total1;
                MOV_alphap : next_st = MOV_alphap1;
                MOV_betap : next_st = MOV_betap1;
                MOV_gammap : next_st = MOV_gammap1;
                MOV_R : next_st = MOV_R1;
                MOV_row : next_st = MOV_row1;
                MOV_cAT : next_st = MOV_cAT1;
                MOV_cB : next_st = MOV_cB1;
                MOV_rnow : next_st = MOV_rnow1;
                MOV_cAtnow : next_st = MOV_cAtnow1;
                MOV_cBnow : next_st = MOV_cBnow1;
                STORE : next_st = STORE1;
                LOAD_REG : next_st = LOAD_REG1;
                ENDOP : next_st = ENDOP1;
                default : next_st = Idle;                    
            endcase
		end

        CLR1 :begin
            $display("clear");
            write_en = AC;
            read_en = None;            
            mem_read = Null0;
            mem_write = 1'b0;
            alu_op = Zero;
            PC_Inc = 1'b0;
            next_st = FETCH1;                  
        end

        LOAD1 : begin
            $display("Load1");
            write_en = DR;
            read_en = None; 
            mem_read = InsM; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = LOAD2;
        
        end

        LOAD2 :begin
            $display("Load2");
            write_en = AR;
            read_en = DR;            
            mem_read = Null0; 
            //removed DataM from here.check if got the corrct results(if results are correct change the other places with 2 consecutive Datam ASSIGNMWNTS)
            //memory does not need an enabling signal to output a value it just needs an address
            //mem read enabling signal controls data input from memmry path to DR
            //as the address is provided in this clock cycle.the required data is not avaibale yet(as it akes 2 clock cycles)(some other unnecessary data is avaible)
            //so ,no memory read signal is necessary here
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = LOAD3;         
        end

        //cycle to wait for memory data to come
        LOAD3 : begin
            $display("Load3");
            write_en = None;
            read_en = None;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b1;
            next_st = LOAD4; 
        end

        LOAD4 :begin
            $display("Load4");
            write_en = DR;
            read_en = None;            
            mem_read = DataM;
            //this signal is actually recived by DR as the enabling signal to take data in from Data memmory 
            //as we provded the address in the last clock cycle.data is avaible now so we can enable DR data memoy in path and take data is
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = LOAD5;         
        end
        
        LOAD5 : begin
            $display("Load5");
            write_en = AC ;//Ar is also witten as PC is read enabled
            read_en = DR | PC;  //read_en = DR TODO change back to this          
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;       
        end
        
        MUL1 :begin        
            $display("mul");
            write_en = AC;// 
            read_en = R;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Mul;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        
        end
        ADD1 :begin    
            $display("Add1");    
            write_en = AC;
            read_en = R;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Add;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        SUB1 :
        begin
            $display("Sub 1");
            write_en = AC;
            read_en = R;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Sub;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        INC1 :
        begin
            $display("Inc1");
            write_en = AC;
            read_en = None;           
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Plus1;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        JUMP1 :
        begin
            $display("Jump1");
            write_en = DR;
            read_en = None;            
            mem_read = InsM; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b1;
            next_st = JUMP2;
        end

        JUMP2 :
        begin
            $display("Jump2");
            write_en = PC;
            read_en = DR;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = JUMP3;
        end

        JUMP3 :
        begin
            $display("Jump3");
            write_en = AR;
            read_en = PC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end     
        
        MVAC_total1 :
        begin
            $display("MVAC_total1");
            write_en = Total;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end
        MVAC_alphap1 :
        begin
            $display("Jump1");
            write_en = alphap;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end
        MVAC_betap1 :
        begin
            $display("beta p 1");
            write_en = betap;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end
        MVAC_gammap1 :
        begin
            $display("MVAC_gammap1");
            write_en = gammap;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;   
        end
        MVAC_R1 :
        begin
            $display("MVAC R1");
            write_en = R;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end
        MVAC_row1 :
        begin
            $display("MVAC_row1");
            write_en = row;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end
        MVAC_cAT1 :
        begin
            $display("MVAC_cAT1");
            write_en = cAT;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end
        MVAC_cB1 :
        begin
            $display("mvac cb 1");
            write_en = cB;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end
        MVAC_rnow1 :
        begin
            $display("mvac rnow 1");
            write_en = rnow;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1; 
        end
        MVAC_cAtnow1 :
        begin
            $display("mvac cat now 1");
            write_en = cATnow;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1; 
        end
        MVAC_cBnow1 :
        begin
            $display("MVAC_cBnow1");
            write_en = cBnow;
            read_en = AC;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1; 
        end
        MOV_total1 :
        begin
            $display("MOV_total");
            write_en =AC;
            read_en = Total;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1; 
        
        end
        MOV_alphap1 :
        begin
            $display("MOV_alphap1");
            write_en =AC;
            read_en = alphap;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1; 
        end
        
        MOV_betap1 :
        begin
            $display("MOV_betap1");
            write_en =AC;
            read_en = betap;           
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1; 
        end

        MOV_gammap1 :
        begin
            $display("MOV_gammap1");
            write_en =AC;
            read_en =gammap ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1; 
        end
        
        MOV_R1 :
        begin
            $display("MOV_R1");
            write_en =AC;
            read_en =R ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        MOV_row1 :
        begin
            $display("MOV_row1");
            write_en =AC;
            read_en =row ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        MOV_cAT1 :
        begin
            $display("MOV_cAT1");
            write_en =AC;
            read_en =cAT;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        MOV_cB1 :
        begin
            $display("MOV_cB1");
            write_en =AC;
            read_en =cB ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        MOV_rnow1 :
        begin
            $display("mov rnow 1");
            write_en =AC;
            read_en =rnow ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        MOV_cAtnow1 :
        begin
            $display("MOV_cATnow1");
            write_en =AC;
            read_en =cATnow ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        MOV_cBnow1 :
        begin
            $display("MOV_cBnow1");
            write_en =AC;
            read_en =cBnow ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        STORE1 :
        begin
            $display("Store1");
            write_en =AR;
            read_en =gammap ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = STORE2;
        end

        STORE2 :
        begin
            $display("Store2");
            write_en =DR;
            read_en =AC ;            
            mem_read = Null0; 
            mem_write = 1'b1;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = STORE3;
        end

        STORE3 :
        begin
            $display("Store3");
            write_en = AR ;
            read_en = PC ;            
            mem_read = Null0; 
            mem_write = 1'b1;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end
        
        LOAD_REG1 :
        begin
            $display("load reg 1");
            write_en = AR;
            read_en =AC ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = LOAD_REG2;
        end

        LOAD_REG2 :
        begin
            $display("load reg 2");//update AR to get next adress from ins mem
            write_en = AR;
            read_en = PC ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = LOAD_REG3;
        end

        LOAD_REG3 :
        begin
            $display("LOAD_REG3");
            write_en = DR; //eventhough DR is enabled here (write_en for DR controls input from the bus),
            //In here DR is controlled by DataM mem read signal (as it has higher priorty in DR implementation)
            //So data from memory is written to DR here
            read_en =None ;            
            mem_read = DataM; //this signal is connected to DR. This signal is the controlling write enable siganl here
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = LOAD_REG4;
        end

        LOAD_REG4 :
        begin
            $display("LOAD_REG4");
            write_en = AC;
            read_en = DR ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = Pass;
            PC_Inc = 1'b0;
            next_st = FETCH1;
        end

        JUMPZY1 :
        begin
            $display("JUMPZY1");
            write_en = DR;
            read_en = None ;            
            mem_read = InsM; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b1; //this is not necessary as pc is overwritten in next cycle
            next_st = JUMPZY2;
        end

        JUMPZY2 :
        begin
            $display("JUMPZY2");
            write_en = PC;
            read_en = DR ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = JUMPZY3;        
        end

        JUMPZY3 :
        begin
            $display("JUMPZY3");
            write_en = AR;
            read_en = PC ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end

        JUMPZN1 :
        begin
            $display("Jump ZN1");
            write_en = None;
            read_en = None ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b1;
            next_st = JUMPZN2; 
        end

        JUMPZN2 :
        begin
            $display("JUMPZN2");
            write_en = AR;
            read_en = PC ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = FETCH1;        
        end

        ENDOP1 :
        
            begin
            $display("End op"); 
            write_en = None;
            read_en = None ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            //wrong states end 
            next_st = Idle;
            endop_signal =1'b1; 
            end
        

        default :
            begin
            write_en = None;
            read_en = None ;            
            mem_read = Null0; 
            mem_write = 1'b0;
            alu_op = IDLE;
            PC_Inc = 1'b0;
            next_st = Idle;
            end        
    endcase 
    $display("*********");
    //current_st = next_st;       
end 
    
endmodule
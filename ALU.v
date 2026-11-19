// module decleration
module ALU#( parameter OPER_WIDTH = 8,
                        OUT_WIDTH = OPER_WIDTH*2
)(
input     wire   [OPER_WIDTH-1:0]    A,
input     wire   [OPER_WIDTH-1:0]    B,
input     wire   [3:0]             ALU_fun,
input     wire                     clk,
input     wire                     rst,
input     wire                     enable,
output    reg    [OUT_WIDTH-1:0]     ALU_out,
output    reg                      out_valid
);

//output of always block
reg  [OUT_WIDTH:0]  ALU_out1;
reg                 out_valid_1;

always @(posedge clk or negedge rst)
 begin
  if(!rst)
   begin
    ALU_out   <= 'b0 ;
    out_valid <= 'b0 ;   
   end
  else 
   begin  
    ALU_out   <= ALU_out1 ;
    out_valid <= out_valid_1 ;
   end    
 end  


always@(*)
begin

ALU_out1    = 'b0;
out_valid_1 = 'b0 ; 
if (enable)
  begin
   //out_valid_1 = 'b1 ;
     case(ALU_fun)
          4'b0000:begin //addition
                         ALU_out1    = A+B ;
                         out_valid_1 = 'b1 ;
                    end

          4'b0001:begin //sub
                         ALU_out1    = A-B ;
                         out_valid_1 = 'b1 ;
                    end

          4'b0010:begin //mult
                         ALU_out1  = A*B ;
                         out_valid_1 = 'b1 ;
                    end
     
          4'b0011:begin //division
                         ALU_out1  = A/B ;
                         out_valid_1 = 'b1 ;
                    end
     
          4'b0100:begin //and
                         ALU_out1  = A&B ;
                         out_valid_1 = 'b1 ;
                    end

          4'b0101:begin //or
                         ALU_out1  = A|B ;
                         out_valid_1 = 'b1 ;
                    end
     
          4'b0110:begin //NAND
                         ALU_out1   = ~(A&B) ;
                         out_valid_1 = 'b1 ;
                    end
     
     
          4'b0111:begin //NOR
                         ALU_out1  =    ~(A|B) ;
                         out_valid_1 = 'b1 ;
                    end

          4'b1000:begin //XOR
                         ALU_out1  =    A^B ;
                         out_valid_1 = 'b1 ;
                    end
     

          4'b1001:begin //XNOR
                         ALU_out1  =    ~(A^B) ;
                         out_valid_1 = 'b1 ;
                    end

          4'b1010 : begin
                         ALU_out1 = (A == B)? 16'b1 : 16'b0 ;
                         out_valid_1 = 'b1 ;
          end
          4'b1011 : begin
                         ALU_out1 = (A > B)? 16'b10 : 16'b0 ;
                         out_valid_1 = 'b1 ;
          end
          4'b1100 : begin
                         ALU_out1 = (A < B)? 16'b11 : 16'b0 ;
                         out_valid_1 = 'b1 ;
          end

          4'b1101:begin //shifting right by 1 bit
                         ALU_out1  =    A>>1'b1;
                         out_valid_1 = 'b1 ;
                    end

          4'b1110:begin //shifting left by 1 bit
                         ALU_out1  =    A<<1'b1;
                         out_valid_1 = 'b1 ;
                    end

          default:begin // in case no case is selected
                         ALU_out1    = 16'b0;
                         out_valid_1 = 'b0 ;
                    end
     endcase
 end
else 
 begin
  out_valid_1 = 'b0 ;    
 end 
end 
endmodule



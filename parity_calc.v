module parity_calc # ( parameter WIDTH = 8 )
(
  
//Interface Signals   
input  wire [WIDTH -1 :0] P_DATA,
input  wire               PAR_EN,
input  wire               PAR_TYP,
input  wire               Data_Valid,
input  wire               busy,
input  wire               CLK,
input  wire               RST,
output reg                par_bit 
);

//Internal Signals
reg  [WIDTH-1:0]  parity_xor;

//isolate input 
always @(posedge CLK or negedge RST)
 begin
   if (!RST)
    parity_xor <= 'b0; 
   else if (Data_Valid && !busy)
    parity_xor <= P_DATA; 
 end
//Parity Calculation
always @(posedge CLK or negedge RST)
 begin
   if (!RST)
    par_bit <= 'b0;
   else
    begin
        if (PAR_EN)
          begin
            case (PAR_TYP)
               1'b0 : begin                 
	                     par_bit <= ^parity_xor  ;     // Even Parity
	                    end
	             1'b1 : begin
	                     par_bit <= ~^parity_xor ;     // Odd Parity
	                    end		
            endcase                 
          end
    end
 end
endmodule 
//XOR for all P_DATA :1 if number of ones is odd, 0 if even
//if even parity     : XOR out =  parity bit 
//if odd parity      : XOR out =~ parity bit 
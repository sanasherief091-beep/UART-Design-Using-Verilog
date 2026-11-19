module parity_check (
  
input  wire       CLK,
input  wire       RST,
input  wire       PAR_TYP,       // 0 = even, 1 = odd
input  wire       par_chk_en,
input  wire       sampled_bit,   // parity bit from UART frame
input  wire [7:0] P_DATA,        // received data bits
output reg        par_err
 
);

  // calculated parity bit
wire par_expected;
assign  par_expected = (PAR_TYP) ? ~(^P_DATA) : ^P_DATA;
always@(posedge CLK or negedge RST)
 begin
  if (!RST)
   par_err<= 1'b0;
  else if (par_chk_en) 
    begin
     if (sampled_bit != par_expected) 
       par_err <= 1'b1; // error 
     else
       par_err <= 1'b0; // no error       
    end
 else
       par_err <= 1'b0; // no error
 
    
 
 end
endmodule

  /*always@(posedge CLK or negedge RST)
    begin
    if(!RST)
      par_err <= 0;
    else if (par_chk_en && PAR_TYP)
      begin
      if(sampled_bit == !(^P_DATA))
        par_err <= 0 ;
      else
        par_err <= 1 ;
      end
    else if (par_chk_en && !PAR_TYP)
      begin
      if(sampled_bit == (^P_DATA))
        par_err <= 0 ;
      else
        par_err <= 1 ;
      end 
    else
      par_err <= 0 ;
    end
      
    endmodule
*/



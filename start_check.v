module start_check (
  
input  wire   CLK,
input  wire   RST,
input  wire   strt_chk_en,
input  wire   sampled_bit,
output reg    strt_glitch
 
);


always@(posedge CLK or negedge RST)
 begin
  if (!RST)
   strt_glitch<= 1'b0;
  else if (strt_chk_en) 
    begin
     if (sampled_bit == 1'b1) // start bit expected to be 0
       strt_glitch <= 1'b1;  // glitch detected
     else
       strt_glitch <= 1'b0; // no glitch
    end 
  else
     strt_glitch <= 1'b0;  // reset when not checking
 end
endmodule




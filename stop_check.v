module stop_check (
  
input  wire CLK,
input  wire RST,
input  wire stp_chk_en,
input  wire sampled_bit,
output reg  stp_err
 
);


always@(posedge CLK or negedge RST)
 begin
  if (!RST)
   stp_err<= 1'b0;
  else if (stp_chk_en) 
    begin
     if (sampled_bit == 1'b0) // stop bit expected to be 1
       stp_err <= 1'b1;  // error detected
     else
       stp_err <= 1'b0; // no error
    end
  else
     stp_err <= 1'b0; // reset when not checking
 end
endmodule
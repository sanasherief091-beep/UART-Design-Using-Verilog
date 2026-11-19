module edge_bit_counter(
  
input  wire       RST,
input  wire       CLK,
input  wire       cnt_en,
input  wire       PAR_EN,
input  wire [5:0] Prescale,
output reg  [3:0] bit_cnt,
output reg  [5:0] edge_cnt

);

wire [3:0] total_bits;
assign total_bits = PAR_EN ? 4'd11 : 4'd10;

// Edge counter

always @(posedge CLK or negedge RST)
 begin
   if (!RST)
     edge_cnt <= 'd0;  
   else if (cnt_en)
     begin
       if(edge_cnt == Prescale - 1)
        edge_cnt <= 'd0; 
       else
        edge_cnt <= edge_cnt + 1;  
     end
   else
    begin 
     edge_cnt <= 'd0;  
    end
    
 end
// Bit counter
always @(posedge CLK or negedge RST)
 begin
   if (!RST)
     bit_cnt  <= 4'b000;
   else if (cnt_en && edge_cnt == Prescale - 1)
    begin
       if(bit_cnt ==  total_bits - 1)
        bit_cnt <= 4'b000; 
       else
        bit_cnt <= bit_cnt + 1;  
     end
   else if (!cnt_en) 
    begin 
     bit_cnt  <= 4'b000;
    end
 end
endmodule
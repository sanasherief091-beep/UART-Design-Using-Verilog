//this solution more simple and less complicated we will rely on the  -bit_cnt- 
module deserializer (
input  wire       CLK, 
input  wire       RST,
input  wire       deser_en,
input  wire [3:0] bit_cnt, 
input  wire       sampled_bit,
output reg  [7:0] P_DATA

);

//P_DATA will be taking the same location as the (counter-1) because of the statr bit(first count)
always @(posedge CLK or negedge RST)
 begin 
  if (!RST)
    begin
      P_DATA   <= 8'b00000000; 
    end
  else if (deser_en)        
    begin
      P_DATA[bit_cnt -1] <= sampled_bit; 
  
    end
 end
endmodule
/*
module deserializer (
  input  wire       CLK, 
  input  wire       RST,
  input  wire       deser_en,
  input  wire [3:0] bit_cnt, 
  input  wire       sampled_bit,
  output reg  [7:0] P_DATA
);

  reg [7:0] register;
  reg [2:0] counter;

  always @(posedge CLK or negedge RST) begin 
    if (!RST) begin
      counter  <= 3'b000; 
      register <= 8'b00000000;
      P_DATA   <= 8'b00000000;
    end 
    else if (deser_en) begin
      // Shift left and insert new bit at MSB (LSB first in UART)
      register <= {sampled_bit, register[7:1]};
      counter  <= counter + 1;

      // When last bit received (counter=7), load parallel data 
      if (counter == 3'b111) begin
        P_DATA  <= register;
        counter <= 3'b000; 
      end
    end
  end

endmodule

*/
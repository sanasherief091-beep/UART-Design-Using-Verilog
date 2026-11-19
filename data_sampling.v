module data_sampling (
input  wire       CLK,
input  wire       RST,
input  wire       dat_samp_en,
input  wire [5:0] edge_cnt,
input  wire       RX_IN,
input  wire [5:0] Prescale,
output reg        sampled_bit
);

//register to load the sampels we will take 
reg [2:0] sampled_bits;

always @(posedge CLK or negedge RST)
 begin
  if (!RST) 
    begin
     sampled_bits    <= 3'b000;
    end
  else if (dat_samp_en)
    //we take 3 sampels 
    begin
      case(edge_cnt)
        
        ((Prescale/2) - 1 ):  sampled_bits[0] <= RX_IN;
        (Prescale/2 )      :  sampled_bits[1] <= RX_IN;
        ((Prescale/2) + 1 ):  sampled_bits[2] <= RX_IN; 
        
      endcase
    end  
 end
 
 // Majority voting
 
always @ (*)
  begin
   case(sampled_bits)
	3'b000 : sampled_bit = 0 ;
	3'b001 : sampled_bit = 0 ;
	3'b010 : sampled_bit = 0 ;
	3'b011 : sampled_bit = 1 ;
	3'b100 : sampled_bit = 0 ;
	3'b101 : sampled_bit = 1 ;
	3'b110 : sampled_bit = 1 ;
	3'b111 : sampled_bit = 1 ;
   endcase
  end 
 endmodule 
 /*
 module data_sampling (
  input  wire       CLK,
  input  wire       RST,
  input  wire       dat_samp_en,
  input  wire [5:0] edge_cnt,
  input  wire       RX_IN,
  input  wire [5:0] Prescale,
  output reg        sampled_bit
);

  reg first_sample;
  reg second_sample;
  reg third_sample;

  always @(posedge CLK or negedge RST) begin
    if (!RST) begin
      first_sample  <= 1'b0;
      second_sample <= 1'b0;
      third_sample  <= 1'b0;
      sampled_bit   <= 1'b0;
    end
    else if (dat_samp_en) begin
      if (edge_cnt == (Prescale/2) - 1)
        first_sample <= RX_IN;

      if (edge_cnt == (Prescale/2))
        second_sample <= RX_IN;

      if (edge_cnt == (Prescale/2) + 1)
        third_sample <= RX_IN;
    end
  end

  // Majority vote
  always @(*) begin
    sampled_bit = (first_sample & second_sample) |
                  (first_sample & third_sample)  |
                  (second_sample & third_sample);
  end

endmodule

 */


 

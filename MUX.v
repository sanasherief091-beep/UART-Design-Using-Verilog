module MUX (
  
//Interface Signals 
input  wire       CLK,
input  wire       RST,
input  wire       ser_data,
input  wire       par_bit,
input  wire [1:0] mux_sel,
output reg        TX_OUT
);

//Local Parameters for start & stop bit to not access it 
localparam start_bit = 1'b0;
localparam stop_bit  = 1'b1;
reg        mux_out;
always@(*)
 begin
  case (mux_sel)
 2'b00     : begin
              // Select start bit
              mux_out = start_bit;
             end
 2'b01     : begin
  
           // Select serializer output (data bits, LSB first)
              mux_out = ser_data;
             end
 2'b10     : begin
              // Select parity bit
              mux_out = par_bit;
             end
 2'b11     : begin
              // Select stop bit
              mux_out = stop_bit;
             end
 default   : begin
              // Default => idle state (logic high)
              mux_out = 2'b11;
             end
 
endcase
 end
 //register mux output
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    TX_OUT <= 'b0 ;
   end
  else
   begin
    TX_OUT <= mux_out ;
   end 
 end  
endmodule
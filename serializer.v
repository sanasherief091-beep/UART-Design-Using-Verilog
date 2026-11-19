module serializer # ( parameter WIDTH = 8 )
(
  
//Interface Signals   
input  wire [WIDTH-1 :0]  P_DATA,
input  wire               Data_Valid,
input  wire               CLK,
input  wire               RST,
input  wire               ser_en,
input  wire               busy,
output wire               ser_done,
output wire               ser_data
);

//Internal Registers 
reg [WIDTH-1 :0] shift_reg;
reg [2:0]        counter;

//isolate input 
always @(posedge CLK or negedge RST)
 begin
  if (!RST)
   begin
    shift_reg <= 'b0;
   end 
  else if (Data_Valid && !busy)
   begin
    // Load parallel data into the shift register
    shift_reg <= P_DATA;      
   end 
  else if (ser_en) 
   begin
    // Shift right by one position (LSB first output)
    shift_reg <= shift_reg >> 1;       // shift right
   end    
 end

//counter
always @(posedge CLK or negedge RST)
 begin
  if (!RST)
   begin
    counter   <= 'b0;
   end 
  else 
   begin
     if (ser_en)
       begin
        counter   <= counter + 'b1;
       end 
     else  
       begin
        counter   <= 'b0;
       end     
   end
 end
  
  
//Combinational Logic for Done Flag
// Set ser_done HIGH when the last bit (bit 7) has been shifted  
assign ser_done = (counter == 'd7) ? 1'b1 : 1'b0;
//Serial Output
assign ser_data = shift_reg[0];  // output LSB first

endmodule
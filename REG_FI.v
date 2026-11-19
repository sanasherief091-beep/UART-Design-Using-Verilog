module RegFile  #(parameter WiDTH = 8, DEPTH = 16, ADDR = 4 )

(
  
input  wire [ADDR-1 :0]  Address,
input  wire              WrEn,
input  wire              RdEn,
input  wire              CLK,
input  wire              RST,
input  wire [WiDTH-1 :0] WrData,
output reg               RdData_VLD,
output reg  [WiDTH-1 :0] RdData,
output wire [WiDTH-1:0]  REG0,
output wire [WiDTH-1:0]  REG1,
output wire [WiDTH-1:0]  REG2,
output wire [WiDTH-1:0]  REG3
);

integer i;
// 2D Array( 8 registers of 16-bit each )
reg  [WiDTH-1 :0] Reg_File [DEPTH-1 :0];

always @ (posedge CLK or negedge RST)
 begin
  // asynchronous active-low reset 
  if (!RST)
   begin
    RdData     <= 'b0 ;
    RdData_VLD <= 'b0 ;
    for (i=0 ; i < DEPTH ;i = i + 1)
     begin
      if (i == 2)
       Reg_File[i] <= 'b100000_01 ;
      else if (i==3)
       Reg_File[i] <= 'b0010_0000 ;
      else
       Reg_File[i] <= 'b0 ;
     end
   end
   
  else if (WrEn && !RdEn)
    begin
     // Write to register 
     Reg_File[Address] <= WrData ;
    end
  else if (RdEn && !WrEn)
     begin
     // Read from register 
      RdData <= Reg_File[Address] ;
      RdData_VLD <= 1 ;
     end
  else 
      RdData_VLD <= 0 ; 
   
 end
assign REG0 = Reg_File[0] ;
assign REG1 = Reg_File[1] ;
assign REG2 = Reg_File[2] ;
assign REG3 = Reg_File[3] ;
endmodule

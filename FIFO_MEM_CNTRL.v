module FIFO_MEM_CNTRL #(
  parameter DATA_WIDTH = 8,
            ADD_SIZE   = 3,
            FIFO_DEPTH = 1 << ADD_SIZE
)(
  
input  wire [DATA_WIDTH - 1 : 0] WR_DATA,
input  wire                      W_INC,
input  wire                      W_RST,
input  wire                      FULL,
input  wire                      EMPTY,
input  wire                      W_CLK,
input  wire [ADD_SIZE   - 1  :0] W_ADD,
input  wire [ADD_SIZE   - 1  :0] R_ADD,
output wire [DATA_WIDTH - 1 : 0] RD_DATA

);
reg [DATA_WIDTH - 1 : 0] fifo [0 : FIFO_DEPTH  - 1];
integer i;
always @(posedge W_CLK or negedge W_RST )
 begin 
   if (!W_RST)
     
     for (i = 0; i < FIFO_DEPTH; i = i+1)
      fifo[i] <= 'b0;
     
   else if ( W_INC && ! FULL)
     fifo [W_ADD] <= WR_DATA;
 end 
 assign RD_DATA = fifo [R_ADD];
endmodule
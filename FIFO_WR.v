module FIFO_WR #( parameter   ADD_SIZE   = 3)( 

input  wire                          W_CLK,
input  wire                          W_RST,
input  wire                          W_INC,
input  wire [ADD_SIZE :0]       wq2_rptr,  // synchronized read pointer (Gray)
output wire  [ADD_SIZE - 1  :0]      W_ADD, // binary address for RAM
output reg  [ADD_SIZE :0]       W_PTR,  // Gray pointer for sync
output wire                          FULL
);

reg  [ADD_SIZE-1:0] W_PTR_BIN;                   // binary write pointer
wire [ADD_SIZE-1:0] grey_comb;  

// binary-to-gray conversion (combinational)
assign grey_comb = W_PTR_BIN ^ (W_PTR_BIN >> 1);

// increment binary write pointer
always @(posedge W_CLK or negedge W_RST) begin
  if (!W_RST)
    W_PTR_BIN <= 'b0;
  else if (W_INC && !FULL)
    W_PTR_BIN <= W_PTR_BIN + 1;
end

// generate write address from binary pointer
assign W_ADD = W_PTR_BIN[ADD_SIZE-2:0];

// register gray-coded write pointer
always @(posedge W_CLK or negedge W_RST) begin
  if (!W_RST)
    W_PTR <= 'b0;
  else
    W_PTR <= grey_comb;
end

// FULL detection 
assign FULL = (wq2_rptr[ADD_SIZE-1]   != grey_comb[ADD_SIZE-1]) && 
              (wq2_rptr[ADD_SIZE-2]   != grey_comb[ADD_SIZE-2]) &&
              (wq2_rptr[ADD_SIZE-3:0] == grey_comb[ADD_SIZE-3:0]);

endmodule

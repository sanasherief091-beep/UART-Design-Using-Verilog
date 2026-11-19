module FIFO_RD #( parameter ADD_SIZE = 3 )( 

  input  wire                    R_CLK,
  input  wire                    R_RST,
  input  wire                    R_INC,
  input  wire [ADD_SIZE:0]     rq2_wptr, // synchronized write pointer (Gray)
  output wire [ADD_SIZE-1:0]     R_ADD,   // binary address for RAM
  output reg  [ADD_SIZE:0]     R_PTR ,   // Gray pointer for sync
  output wire                    EMPTY
);

reg  [ADD_SIZE-1:0] R_PTR_BIN;               // binary read pointer
wire [ADD_SIZE-1:0] grey_comb;  

assign grey_comb = R_PTR_BIN ^ (R_PTR_BIN >> 1);

always @(posedge R_CLK or negedge R_RST)
  begin
   if (!R_RST)
    begin
      R_PTR_BIN <= 'b0;
    end 
   else
    begin
     if (R_INC && !EMPTY)
      begin
        R_PTR_BIN <= R_PTR_BIN + 1;
      end  
    end
  end
 assign R_ADD =  R_PTR_BIN[ADD_SIZE-2 :0];
 
always @(posedge R_CLK or negedge R_RST)
  begin
   if (!R_RST)
    begin
      R_PTR <= 'b0;
    end 
   else
    begin
     if (R_INC && !EMPTY)
      begin
        R_PTR <= grey_comb;
      end  
    end
  end 
 // EMPTY detection 
assign EMPTY = (rq2_wptr == grey_comb);
endmodule



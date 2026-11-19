module DF_SYNC #(parameter ADD_SIZE = 3)(

    // Write Clock Domain
    input  wire                   W_CLK,
    input  wire                   W_RST,
    input  wire   [ADD_SIZE:0]    R_PTR,     // from read domain
    output reg    [ADD_SIZE:0]    wq2_rptr, // synchronized into write domain

    // Read Clock Domain
    input  wire                   R_CLK,
    input  wire                   R_RST,
    input  wire   [ADD_SIZE:0]    W_PTR,     // from write domain
    output reg    [ADD_SIZE:0]    rq2_wptr  // synchronized into read domain
);

// Internal registers

    reg [ADD_SIZE:0] rptr_wq1;
    reg [ADD_SIZE:0] wptr_rq1;

// ----------------- R_PTR to W_CLK (double flop) -----------------
 always @(posedge W_CLK or negedge W_RST)
  begin
    if (!W_RST)
      begin
        rptr_wq1  <= 'b0;
        wq2_rptr  <= 'b0;
      end
    else 
      begin
        rptr_wq1  <= R_PTR;
        wq2_rptr  <= rptr_wq1;
      end
  end

// ----------------- W_PTR to R_CLK (double flop) -----------------
always @(posedge R_CLK or negedge R_RST)
 begin
  if (!R_RST)
   begin
    wptr_rq1  <= 'b0;
    rq2_wptr  <= 'b0;
   end 
  else
   begin
    wptr_rq1  <= W_PTR;
    rq2_wptr  <= wptr_rq1;
   end
 end

endmodule
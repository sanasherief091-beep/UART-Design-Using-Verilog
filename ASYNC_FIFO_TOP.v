module ASYNC_FIFO_TOP #(
  parameter DATA_WIDTH = 8,
            ADD_SIZE   = 3,
            FIFO_DEPTH = 1 << ADD_SIZE            
)(

// interface signals
input  wire                      W_CLK,
input  wire                      W_RST,
input  wire                      W_INC,
input  wire                      R_CLK,
input  wire                      R_RST,
input  wire                      R_INC,
input  wire [DATA_WIDTH - 1 : 0] WR_DATA,
output wire [DATA_WIDTH - 1 : 0] RD_DATA,
output wire                      FULL,
output wire                      EMPTY

);
// internal signals  
wire [ADD_SIZE   - 1  :0] W_ADD;
wire [ADD_SIZE   - 1  :0] R_ADD;
wire [ADD_SIZE   :0]       rq2_wptr;
wire [ADD_SIZE   :0]       R_PTR;
wire [ADD_SIZE   :0]       wq2_rptr;
wire [ADD_SIZE   :0]       W_PTR;

FIFO_MEM_CNTRL #(
.DATA_WIDTH(DATA_WIDTH),
.ADD_SIZE(ADD_SIZE),
.FIFO_DEPTH(FIFO_DEPTH)
)U0_FIFO_MEM_CNTRL (
.WR_DATA(WR_DATA),
.W_INC(W_INC),
.FULL(FULL),
.W_CLK(W_CLK),
.W_ADD(W_ADD),
.W_RST(W_RST),
.EMPTY(EMPTY),
.R_ADD(R_ADD),
.RD_DATA(RD_DATA)
);

FIFO_RD #(
.ADD_SIZE(ADD_SIZE)
)U1_FIFO_RD (
.R_CLK(R_CLK),
.R_RST(R_RST),
.R_INC(R_INC),
.rq2_wptr(rq2_wptr), 
.EMPTY(EMPTY),
.R_ADD(R_ADD),   
.R_PTR(R_PTR)    
);

FIFO_WR#(
.ADD_SIZE(ADD_SIZE)
) U2_FIFO_WR (
.W_CLK(W_CLK),
.W_RST(W_RST),
.W_INC(W_INC),
.wq2_rptr(wq2_rptr), 
.FULL(FULL),
.W_ADD(W_ADD),   
.W_PTR(W_PTR)    
);

DF_SYNC#(
.ADD_SIZE(ADD_SIZE)
) U3_DF_SYNC (
.W_CLK(W_CLK),
.W_RST(W_RST),
.R_CLK(R_CLK),
.R_RST(R_RST),
.R_PTR(R_PTR),
.W_PTR(W_PTR),
.wq2_rptr(wq2_rptr),
.rq2_wptr(rq2_wptr)
);

endmodule

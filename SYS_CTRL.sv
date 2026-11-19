module SYS_CTRL # ( parameter DATA_WIDTH = 8 ,  RF_ADDR = 4 )

(

input  wire                    CLK,
input  wire                    RST,
input  wire [DATA_WIDTH-1:0]   RF_RdData,
input  wire                    RF_RdData_VLD, 
input  wire [DATA_WIDTH*2-1:0] ALU_OUT,
input  wire                    ALU_OUT_VLD,      
input  wire [DATA_WIDTH-1:0]   UART_RX_DATA, 
input  wire                    UART_RX_VLD,
input  wire                    FIFO_FULL,
output reg                     CLKDIV_EN,
output reg                     ALU_EN,
output reg  [3:0]              ALU_FUN,
output reg                     CLKG_EN,
output reg                     RF_WrEn,
output reg                     RF_RdEn,
output reg  [RF_ADDR-1:0]      RF_Address,
output reg  [DATA_WIDTH-1:0]   RF_WrData,
output reg  [DATA_WIDTH-1:0]   UART_TX_DATA, 
output reg                     UART_TX_VLD

);
// FSM States
typedef enum logic [3:0] {
        IDLE        = 4'b0000,
        RF_WR_ADDR  = 4'b0001,
        RF_WR_DATA  = 4'b0010,
        RF_RD_ADDR  = 4'b0011,
        RF_RD_SEND  = 4'b0100,
        ALU_OP_A    = 4'b0101,
        ALU_OP_B    = 4'b0110,
        ALU_FUN_OP  = 4'b0111,
        ALU_WAIT_L  = 4'b1000,
        ALU_WAIT_H  = 4'b1001,
        ALU_FUN_NOP = 4'b1010
    } state_e;

    state_e current_state, next_state;

// Register only the write address
reg[RF_ADDR-1:0] rf_wr_addr_reg;

//regidter for the out
reg [2*DATA_WIDTH-1:0] alu_out_reg;

//alu out regestering  
always @(posedge CLK or negedge RST)
 begin
    if(!RST)
        alu_out_reg <= {2*DATA_WIDTH{1'b0}};
    else if( ALU_OUT_VLD)
        alu_out_reg <= ALU_OUT;
 end
//ADDRESS regestering  
always @(posedge CLK or negedge RST)
 begin
    if(!RST)
        rf_wr_addr_reg <= {RF_ADDR{1'b0}};
    else if(current_state == RF_WR_ADDR &&  UART_RX_VLD)
        rf_wr_addr_reg <= UART_RX_DATA[RF_ADDR-1:0];
 end

//state transition 
always @(posedge CLK or negedge RST)
 begin
    if(!RST)     
        current_state <= IDLE; 
    else      
        current_state <= next_state;    
 end
// Next-state logic
always @(*) begin
    case(current_state)
        IDLE: if (UART_RX_VLD) begin 
                case (UART_RX_DATA)
                  8'hAA  : next_state = RF_WR_ADDR;  // RegFile Write
                  8'hBB  : next_state = RF_RD_ADDR;  // RegFile Read
                  8'hCC  : next_state = ALU_OP_A;    // ALU with operands
                  8'hDD  : next_state = ALU_FUN_NOP; // ALU NOP  
                  default: next_state = IDLE;         
                endcase
              end
              else
                next_state = IDLE; 
              
        // RegFile Write
        RF_WR_ADDR : next_state = (UART_RX_VLD) ? RF_WR_DATA : RF_WR_ADDR;
        RF_WR_DATA : next_state = (UART_RX_VLD) ? IDLE       : RF_WR_DATA;
       
        // RegFile Read
        RF_RD_ADDR : next_state = (UART_RX_VLD)   ? RF_RD_SEND : RF_RD_ADDR;
        RF_RD_SEND : next_state = (RF_RdData_VLD) ? IDLE       : RF_RD_SEND;
        
        // ALU Ops
        ALU_OP_A   : next_state = (UART_RX_VLD) ?  ALU_OP_B  : ALU_OP_A;
        ALU_OP_B   : next_state = (UART_RX_VLD) ? ALU_FUN_OP : ALU_OP_B;
        ALU_FUN_OP : next_state = (ALU_OUT_VLD) ? ALU_WAIT_L : ALU_FUN_OP;
        
        ALU_WAIT_L : next_state =  ALU_WAIT_H ;
        ALU_WAIT_H : next_state =  IDLE;

        // ALU NO Ops
        ALU_FUN_NOP: next_state = (ALU_OUT_VLD) ? ALU_WAIT_L : ALU_FUN_NOP;
        default    : next_state = IDLE;
    endcase
end

// Output Logic
always @(*)
 begin
  // Defaults
  RF_WrEn     = 1'b0;
  RF_RdEn     = 1'b0;
  RF_Address  = {RF_ADDR{1'b0}};
  RF_WrData   = {DATA_WIDTH{1'b0}};
  ALU_EN      = 1'b0;
  ALU_FUN     = 4'b0;
  UART_TX_DATA= {DATA_WIDTH{1'b0}};
  UART_TX_VLD = 1'b0;
  CLKG_EN     = 1'b0;
  CLKDIV_EN   = 1'b1;
  
  case(current_state)
    
            // RegFile Write
            RF_WR_ADDR:  begin
                // nothing to assert here (address already captured)
                         end
            RF_WR_DATA:  begin
                RF_WrEn      = (UART_RX_VLD) ? 1'b1 : 1'b0;
                RF_Address   = rf_wr_addr_reg;
                RF_WrData    = (UART_RX_VLD) ? UART_RX_DATA : 1'b0;
                         end
            // RegFile Read
            
            RF_RD_ADDR:  begin
                RF_RdEn    = (UART_RX_VLD) ? 1'b1 : 1'b0;
                RF_Address = (UART_RX_VLD) ? UART_RX_DATA[RF_ADDR-1:0] : 1'b0;
                         end
            RF_RD_SEND:  begin
                UART_TX_VLD  = (RF_RdData_VLD && !FIFO_FULL) ? 1'b1 : 1'b0;
                UART_TX_DATA = (RF_RdData_VLD) ? RF_RdData  : 1'b0 ;                
                         end            
            // ALU Ops
            
            ALU_OP_A:    begin
                RF_WrEn    = (UART_RX_VLD) ? 1'b1 : 1'b0; // write operand A to REG0
                RF_Address =1'b0 ; // address 0
                RF_WrData  = (UART_RX_VLD) ?  UART_RX_DATA : 1'b0;
                         end
            ALU_OP_B:    begin
                RF_WrEn    = (UART_RX_VLD) ? 1'b1 : 1'b0; // write operand B to REG1
                RF_Address = 1'b1 ; // address 1
                RF_WrData  = (UART_RX_VLD) ?  UART_RX_DATA : 1'b0;
                         end
            ALU_FUN_OP:  begin
                ALU_EN     = (UART_RX_VLD) ? 1'b1 : 1'b0; // start ALU when function frame arrives;
                ALU_FUN    = (UART_RX_VLD) ? UART_RX_DATA[3:0] :1'b0;
                CLKG_EN    = 1'b1 ;// enable ALU clock so ALU can use regfile
                         end
            ALU_FUN_NOP: begin
                ALU_EN     =  (UART_RX_VLD) ? 1'b1 : 1'b0;
                ALU_FUN    = (UART_RX_VLD) ? UART_RX_DATA[3:0] :1'b0;
                CLKG_EN    =  1'b1 ;
                         end
            ALU_WAIT_L : begin
                UART_TX_VLD  =(!FIFO_FULL) ? 1'b1 : 1'b0;
                UART_TX_DATA = alu_out_reg[7:0];// lower byte
                         end
            ALU_WAIT_H : begin
                UART_TX_VLD  =(!FIFO_FULL) ?  1'b1 : 1'b0;
                UART_TX_DATA = alu_out_reg[15:8];// upper byte
                         end
            default    : begin
                  RF_WrEn     = 1'b0;
                  RF_RdEn     = 1'b0;
                  RF_Address  ={RF_ADDR{1'b0}};
                  RF_WrData   ={DATA_WIDTH{1'b0}};
                  ALU_EN      = 1'b0;
                  ALU_FUN     = 4'b0;
                  UART_TX_DATA={DATA_WIDTH{1'b0}};
                  UART_TX_VLD = 1'b0;
                  CLKG_EN     = 1'b0;
                  CLKDIV_EN   = 1'b1;       
                         end                    
        endcase
    end

endmodule
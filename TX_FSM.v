module TX_FSM (
  
//Interface Signals  
input  wire        CLK,
input  wire        RST,
input  wire        PAR_EN ,
input  wire        Data_Valid ,
input  wire        ser_done,
output reg         ser_en,
output reg  [1:0]  mux_sel,
output reg         busy 
);

//State Encoding

localparam [2:0] IDLE   = 3'b000,
                 START  = 3'b001,
                 DATA   = 3'b011,
                 PARITY = 3'b111,
                 STOP   = 3'b110;

//Internal Registers                

reg [2:0]  current_state,
           next_state; 
reg        busy_reg ;                               
// state transition 		

always @(posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
     current_state <= IDLE;
   end
  else
   begin
     current_state <= next_state;
   end
 end
 
// next_state logic
always @(*)
 begin
  case(current_state)
  IDLE     : begin
    
              if(Data_Valid)
			         next_state = START ; // Start sending
              else
               next_state = IDLE ;  // Stay idle
              		  
             end
  START    : begin
              // After sending start bit : send data bits
              next_state = DATA ;	   
             end
  DATA     : begin 
               if (ser_done)
                  // If parity enabled : send parity bit, else go to stop
                  next_state = (PAR_EN) ? PARITY : STOP;
               else
                 // Keep sending data
                  next_state = DATA;
             end   
  PARITY   : begin
              // After parity bit : send stop bit
              next_state = STOP ;	    
             end
  STOP     : begin
              // After stop bit : go back to idle
              next_state = IDLE ; 
             end			 

  default :   next_state = IDLE ;		 
  
  endcase
end	


// Output_Logic
always @(*)
 begin
  ser_en   = 1'b0 ;
  mux_sel  = 2'b11 ;	
  busy_reg = 1'b0 ;
  case(current_state)
  IDLE     : begin
              busy_reg = 1'b0;
              mux_sel  = 2'b11; //  stop_bit
              ser_en   = 1'b0;
             end
  START    : begin
              busy_reg =  1'b1 ;
              mux_sel  =  2'b00 ; // Start bit
              ser_en   =		1'b0 ;
             end	
  DATA     : begin
              busy_reg =  1'b1 ;
              mux_sel  =  2'b01; // Data bit
              ser_en   =		1'b1 ;	   
             end
  PARITY   : begin
              busy_reg =  1'b1 ;
              mux_sel  =  2'b10; // Parity bit
              ser_en   =		1'b0 ;	   
             end
  STOP     : begin
              busy_reg =  1'b1 ;
              mux_sel  =  2'b11; // Stop bit
              ser_en   =		1'b0 ;		   
             end			 
  default  : begin
              busy_reg =  1'b0 ;
              mux_sel  =  2'b11 ;
              ser_en   =		1'b0 ;
             end			  
  endcase
 end	
//register output 
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    busy <= 1'b0 ;
   end
  else
   begin
    busy <= busy_reg ;
   end
 end		
		
endmodule		
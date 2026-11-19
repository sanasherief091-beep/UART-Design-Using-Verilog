module FSM (
  
//Interface Signals  
input wire        RX_IN,
input wire [5:0]  edge_cnt,
input wire [3:0]  bit_cnt,
input wire [5:0]  Prescale,
input wire        stp_err,
input wire        strt_glitch,
input wire        par_err,
input wire        PAR_EN,
input wire        RST,
input wire        CLK,
output reg        dat_samp_en,
output reg        cnt_en,
output reg        deser_en,
output reg        data_valid,
output reg        stp_chk_en,
output reg        strt_chk_en,
output reg        par_chk_en

);

//State Encoding
typedef enum bit [2:0] {
IDLE   = 3'b000,
                 START  = 3'b001,
                 DATA   = 3'b011,
                 PARITY = 3'b111,
                 STOP   = 3'b110,
                 VALID  = 3'b101
                 
} state_e ;
state_e    current_state,next_state;  ;
                               
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
  IDLE     : next_state = (!RX_IN) ? START : IDLE;
             
  START    : begin
               if( edge_cnt == Prescale - 1 && bit_cnt==4'b0 ) 
                begin
                  next_state = (strt_glitch) ? IDLE : DATA;
                end
               else
                 next_state = START;   
             end
  DATA     : begin 
              if( edge_cnt == Prescale - 1 && bit_cnt==4'd8 ) 
               begin
                next_state = (PAR_EN) ? PARITY : STOP;  
               end
              else
               next_state = DATA; 
             end   
             
  PARITY   : begin
              if( edge_cnt == Prescale - 1 && bit_cnt==4'd9) 
               next_state = STOP;
              else
               next_state = PARITY;    
             end
 STOP :      begin
              if(edge_cnt == Prescale - 2 && ((PAR_EN && bit_cnt==4'd10) || (!PAR_EN && bit_cnt==4'd9)))
               next_state = VALID;
              else
               next_state = STOP;
             end
  VALID    : next_state = (!RX_IN) ? START : IDLE; 
                    
   default :   next_state = IDLE ;		 
  
  endcase
end	
// Output_Logic
always @(*)
 begin
  
  par_chk_en =1'b0;
  stp_chk_en =1'b0;
  strt_chk_en=1'b0;
  cnt_en     =1'b0;
  deser_en   =1'b0;
  dat_samp_en =1'b0;
  data_valid =1'b0;


  case(current_state)
  IDLE     : begin
    
               cnt_en     = (!RX_IN) ? 1'b1 : 1'b0;
               dat_samp_en =1'b0;
               deser_en   =1'b0;
               data_valid =1'b0;
               stp_chk_en =1'b0;
               strt_chk_en=1'b0;
               par_chk_en =1'b0;
               
             end
  START    : begin
              dat_samp_en =1'b1;
              cnt_en     =1'b1;
              strt_chk_en= (edge_cnt == Prescale-2) ? 1'b1 : 1'b0;
              deser_en    =  1'b0;
              data_valid =1'b0;
              stp_chk_en =1'b0;
              par_chk_en =1'b0;
              
              end	
  DATA     : begin
              dat_samp_en =1'b1;
              cnt_en     =1'b1;
              deser_en    = (edge_cnt == Prescale-2) ? 1'b1 : 1'b0;
              data_valid =1'b0;
              stp_chk_en =1'b0;
              strt_chk_en=1'b0;
              par_chk_en =1'b0;
              
              end
  PARITY   : begin
              dat_samp_en =1'b1;
              cnt_en     =1'b1;
              par_chk_en = (edge_cnt == Prescale-2) ? 1'b1 : 1'b0;  
              deser_en    =  1'b0;
              data_valid =1'b0;
              stp_chk_en =1'b0;
              strt_chk_en=1'b0; 
                          	   
             end
  STOP     : begin
              dat_samp_en =1'b1;
              cnt_en     =1'b1;
              stp_chk_en =(edge_cnt == Prescale-2) ? 1'b1 : 1'b0; 
              deser_en    =  1'b0;
              data_valid =1'b0;
              strt_chk_en=1'b0;
              par_chk_en =1'b0;
              
             end			 
             
  VALID    : begin
              dat_samp_en =1'b0;
              cnt_en     =1'b0;
              deser_en   =1'b0;
              data_valid =(par_err || stp_err ) ?1'b0 : 1'b1;
              stp_chk_en =1'b0;
              strt_chk_en=1'b0;
              par_chk_en =1'b0;
              
             end                      
  default  : begin
              dat_samp_en =1'b0;
              cnt_en     =1'b0;
              deser_en   =1'b0;
              data_valid =1'b0;
              stp_chk_en =1'b0;
              strt_chk_en=1'b0;
              par_chk_en =1'b0;
             end			  
  endcase
 end	
		
		
endmodule

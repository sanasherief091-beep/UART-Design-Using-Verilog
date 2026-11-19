module data_sync #( 
parameter BUS_WIDTH = 8,
parameter NUM_STAGES = 3
)(

//--------------------------- interface signals ---------------------------------------//
input  wire [BUS_WIDTH -1 : 0]  Unsync_bus,
input  wire                     bus_enable,
input  wire                     CLK,
input  wire                     RST,  // Active Low
output reg  [BUS_WIDTH -1 : 0]  sync_bus,
output reg                      enable_pulse

);

//----------------------------internal signals -----------------------------------------//

reg  [NUM_STAGES -1 : 0]  sync_regs;   // vector of synchronizer stages
reg                       enabled_flop;
wire                      enable_flop_pulse;
wire [BUS_WIDTH-1:0]      sync_bus_out;

//------------------------------ Synchronizer stages ----------------------------------//

always @(posedge CLK or negedge RST)
 begin
   if (!RST )
     begin
      sync_regs <= 'b0;
     end
   else
     begin
     sync_regs <= {sync_regs[NUM_STAGES-2:0],bus_enable};
     end
 end
 
 //---------------------------------- pulse flop ---------------------------------------//
always @(posedge CLK or negedge RST)
 begin
   if (!RST )
     begin
      enabled_flop  <= 1'b0;
     end
   else
     begin
      enabled_flop  <= sync_regs[NUM_STAGES-1];       
     end
 end
 assign enable_flop_pulse = sync_regs[NUM_STAGES-1] && !enabled_flop ;
 
  //---------------------------------- multiplexing ---------------------------------------//
  
 assign sync_bus_out =  enable_flop_pulse ? Unsync_bus : sync_bus;
  
  //---------------------------------- bus capture --------------------------------------//
always @(posedge CLK or negedge RST) 
 begin
  if (!RST)
    begin
     sync_bus     <= 'b0;
     enable_pulse <= 'b0;
    end
  else 
    begin
     sync_bus     <= sync_bus_out;
     enable_pulse <= enable_flop_pulse;
    end
 end  
endmodule
  
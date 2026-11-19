module RST_SYNC #( parameter NUM_STAGES = 2)(

//--------------------------- interface signals ---------------------------------------//
input  wire  RST,
input  wire  CLK,
output wire  SYNC_RST

);

//----------------------------internal signals -----------------------------------------//

reg  [NUM_STAGES -1 : 0]  sync_regs;   // vector of synchronizer stages

//------------------------------ Synchronizer stages ----------------------------------//

always @(posedge CLK or negedge RST)
 begin
   if (!RST )
     begin
      sync_regs <= 'b0;
     end
   else
     begin
     sync_regs <= {sync_regs[NUM_STAGES-2:0],1'b1};
     end
 end
 assign SYNC_RST = sync_regs[NUM_STAGES-1];
endmodule
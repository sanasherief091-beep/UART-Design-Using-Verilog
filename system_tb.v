`timescale 1ns/1ps

module system_tb ();
/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter DATA_WIDTH      = 8 ;
parameter RF_ADDR         = 4 ;
parameter REF_CLK_PERIOD  = 20;    // 50 MHz
parameter UART_CLK_PERIOD = 271.3 ;// 3.6864 MHz

/////////////////////////////////////////////////////////
//////////////////// DUT Signals ////////////////////////
/////////////////////////////////////////////////////////
reg   UART_CLK_tb;
reg   REF_CLK_tb;
reg   RST_N_tb;
reg   UART_RX_IN_tb;
wire  TX_CLK_tb;
wire  TX_OUT_V_tb;
wire  UART_TX_O_tb;
wire  parity_error_tb;
wire  framing_error_tb;

////////////////// DUT Instantiation //////////////////
  SYS_TOP #(
    .DATA_WIDTH(DATA_WIDTH),
    .RF_ADDR(RF_ADDR)
  ) DUT (
    .UART_CLK(UART_CLK_tb),
    .REF_CLK(REF_CLK_tb),
    .RST_N(RST_N_tb),
    .UART_RX_IN(UART_RX_IN_tb),
    .UART_TX_O(UART_TX_O_tb),
    .parity_error(parity_error_tb),
    .framing_error(framing_error_tb)    

  );
  assign TX_OUT_V_tb = DUT.U0_UART.TX_OUT_V;
  assign TX_CLK_tb = DUT.U0_UART.TX_CLK;

///////////////////// Clock Generator //////////////////

always #(REF_CLK_PERIOD/2) REF_CLK_tb = ~REF_CLK_tb ;

always #(UART_CLK_PERIOD/2) UART_CLK_tb = ~UART_CLK_tb ;

////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial
 begin

 // Initialization
 initialize() ;

 // Reset
 reset() ; 
//----------------------------------------------------------------------testing all commands -----------------------------------------------------------//
// Config write sequence
//------------------------------------------------------------------//
  
  //AA

  send_uart_frame(0, 8'hAA,0,0, 1);// Command
  
  send_uart_frame(0, 8'd4,0,1, 1); // Address
  
  send_uart_frame(0, 8'd7,0,1, 1); // Data

  //AA

  send_uart_frame(0, 8'hAA,0,0, 1);// Command
  
  send_uart_frame(0, 8'd5,0,0, 1); // Address
  
  send_uart_frame(0, 8'd7,0,1, 1); // Data

//------------------------------------------------------------------//
 
  //BB

  send_uart_frame(0, 8'hBB,0,0, 1);// Command
  
  send_uart_frame(0, 8'd4,0,1, 1); // Address

  check_uart_frame (0, 8'd7,1,1);

  //BB

  send_uart_frame(0, 8'hBB,0,0, 1);// Command
  
  send_uart_frame(0, 8'd5,0,0, 1); // Address

  check_uart_frame ( 0, 8'd7,1,1);

 //------------------------------------------------------------------//
  
  //CC

  send_uart_frame(0, 8'hCC,0,0, 1);// Command
  
  send_uart_frame(0, 8'd10,0,0, 1); // A
  
  send_uart_frame(0, 8'd5,0,0, 1); // B

  send_uart_frame(0, 8'd0,0,0, 1);// OP (add)
  
  //expected 15 = 0000-0000 0000-1111

  check_uart_frame_alu (0, 16'b1111,0,0,1);

//------------------------------------------------------------------//
  
  //DD
 
  send_uart_frame(0, 8'hDD,0,0, 1);// Command

  send_uart_frame(0, 8'd1,0,1, 1);// OP (sub)
 
  //expected 5 = 0000-0000 0000-0101

  check_uart_frame_alu (0, 16'b101,0,0,1);

//------------------------------------------------------------------//
  
  //CC

  send_uart_frame(0, 8'hCC,0,0, 1);// Command
  
  send_uart_frame(0, 8'd8,0,1, 1); // A
  
  send_uart_frame(0, 8'd2,0,1, 1); // B

  send_uart_frame(0, 8'd2,0,1, 1);// OP (mul)
  
  //expected 16 = 0000-0000 0001-0000

  check_uart_frame_alu (0, 16'b10000,1,0,1);

//------------------------------------------------------------------//

  //DD

  send_uart_frame(0, 8'hDD,0,0, 1);// Command

  send_uart_frame(0, 8'd3,0,0, 1);// OP(div)
 
  //expected 4 = 0000-0000 0000-0100

  check_uart_frame_alu (0, 16'b100,1,0,1);

//------------------------------------------------------------------//
  
  //CC (16 bits multiplication)

  send_uart_frame(0, 8'hCC,0,0, 1);// Command
  
  send_uart_frame(0, 8'b00111111,0,0, 1); // A
  
  send_uart_frame(0, 8'b00111111,0,0, 1); // B

  send_uart_frame(0, 8'd2,0,1, 1);// OP (mul)
  
  //expected 16 = 0000-1111 1000-0001

  check_uart_frame_alu (0, 16'b111110000001,0,0,1);

//----------------------------------------------------------------------testing  different prescale -----------------------------------------------------------//

//------------------------------------------------------------------//

  //try a diff prescale (8) USING AA COMAND (WRITE)

  send_uart_frame(0, 8'hAA,0,0, 1);// Command

  send_uart_frame(0, 8'd2,0,1, 1); // Address
  
  send_uart_frame(0, 8'b00100001,0,0, 1); // Data 

 // parity enable=1 , parity type =EVEN , prescale =8

 // you can try those to make sure the prescale working well :) ↓

 
//------------------------------------------------------------------//

 /*
 send_uart_frame(0, 8'hAA,0,0, 1);// Command
  
  send_uart_frame(0, 8'd4,0,1, 1); // Address
  
  send_uart_frame(0, 8'd7,0,1, 1); // Data

  send_uart_frame(0, 8'hAA,0,0, 1);// Command
  
  send_uart_frame(0, 8'd5,0,0, 1); // Address
  
  send_uart_frame(0, 8'd7,0,1, 1); // Data

  send_uart_frame(0, 8'hBB,0,0, 1);// Command
  
  send_uart_frame(0, 8'd4,0,1, 1); // Address

  check_uart_frame (0, 8'd7,1,1);

  send_uart_frame(0, 8'hBB,0,0, 1);// Command
  
  send_uart_frame(0, 8'd5,0,0, 1); // Address

  check_uart_frame ( 0, 8'd7,1,1);
 
  send_uart_frame(0, 8'hCC,0,0, 1);// Command
  
  send_uart_frame(0, 8'd10,0,0, 1); // A
  
  send_uart_frame(0, 8'd5,0,0, 1); // B

  send_uart_frame(0, 8'd0,0,0, 1);// OP (add)
  //expected 15 = 0000-0000 0000-1111

  check_uart_frame_alu (0, 16'b1111,0,0,1);
 
  send_uart_frame(0, 8'hDD,0,0, 1);// Command

  send_uart_frame(0, 8'd1,0,1, 1);// OP (sub)
 //expected 5 = 0000-0000 0000-0101

  check_uart_frame_alu (0, 16'b101,0,0,1);

  send_uart_frame(0, 8'hCC,0,0, 1);// Command
  
  send_uart_frame(0, 8'd8,0,1, 1); // A
  
  send_uart_frame(0, 8'd2,0,1, 1); // B

  send_uart_frame(0, 8'd2,0,1, 1);// OP (mul)
  //expected 16 = 0000-0000 0001-0000

  check_uart_frame_alu (0, 16'b10000,1,0,1);

  send_uart_frame(0, 8'hDD,0,0, 1);// Command

  send_uart_frame(0, 8'd3,0,0, 1);// OP(div)
  //expected 4 = 0000-0000 0000-0100

  check_uart_frame_alu (0, 16'b100,1,0,1);

 */

//----------------------------------------------------------------------testing  different parity type (odd) -----------------------------------------------------------//

//------------------------------------------------------------------//

  //try a diff parity type (ODD) USING AA COMAND (WRITE)

  send_uart_frame(0, 8'hAA,0,0, 1);// Command

  send_uart_frame(0, 8'd2,0,1, 1); // Address
  
  send_uart_frame(0, 8'b10000011,0,1, 1); // Data 
   
   // parity enable=1 , parity type =ODD , prescale =32
   
   //you can also try those to make sure the ODD type working well :) ↓

//------------------------------------------------------------------//
  
  /*
  send_uart_frame(0, 8'hAA,1,1, 1);// Command
  
  send_uart_frame(0, 8'd4,1,0, 1); // Address
  
  send_uart_frame(0, 8'd7,1,0, 1); // Data

  send_uart_frame(0, 8'hAA,1,1, 1);// Command
  
  send_uart_frame(0, 8'd5,1,1, 1); // Address
  
  send_uart_frame(0, 8'd7,1,0, 1); // Data

  send_uart_frame(0, 8'hBB,1,1, 1);// Command
  
  send_uart_frame(0, 8'd4,1,0, 1); // Address

  check_uart_frame (0, 8'd7,0,1);

  send_uart_frame(0, 8'hBB,1,1, 1);// Command
  
  send_uart_frame(0, 8'd5,1,1, 1); // Address

  check_uart_frame ( 0, 8'd7,0,1);
 */

//----------------------------------------------------------------------testing parity disabled -----------------------------------------------------------------------//

//------------------------------------------------------------------//

// try parity disabled 

  send_uart_frame(0, 8'hAA,1,1, 1);// Command

  send_uart_frame(0, 8'd2,1,0, 1); // Address
  
  send_uart_frame(0, 8'b10000000,1,0, 1); // Data 

// you can try those to make surrrrre :) ↓

//------------------------------------------------------------------//
  
  /*
  //AA

  send_uart_frame_no_parity(0, 8'hAA ,1);// Command
  
  send_uart_frame_no_parity(0, 8'd4, 1); // Address
  
  send_uart_frame_no_parity(0, 8'd7, 1); // Data

  //AA

  send_uart_frame_no_parity(0, 8'hAA, 1);// Command
  
  send_uart_frame_no_parity(0, 8'd5,1); // Address
  
  send_uart_frame_no_parity(0, 8'd7,1); // Data

//------------------------------------------------------------------//
 
  //BB

  send_uart_frame_no_parity(0, 8'hBB, 1);// Command
  
  send_uart_frame_no_parity(0, 8'd4,1); // Address

  check_uart_frame_no_parity (0, 8'd7,1);

  //BB

  send_uart_frame_no_parity(0, 8'hBB, 1);// Command
  
  send_uart_frame_no_parity(0, 8'd5,1); // Address

  check_uart_frame_no_parity ( 0, 8'd7,1);

//------------------------------------------------------------------//

  //CC (16 bits multiplication)

  send_uart_frame_no_parity(0, 8'hCC,1);// Command
  
  send_uart_frame_no_parity(0, 8'b00111111,1); // A
  
  send_uart_frame_no_parity(0, 8'b00111111,1); // B

  send_uart_frame_no_parity(0, 8'd2,1);// OP (mul)
  
  //expected 16 = 0000-1111 1000-0001

  check_uart_frame_no_parity (0, 16'b111110000001,1);
  */

//------------------------------------------------------------------//



//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//
  #(10000*REF_CLK_PERIOD);
  $stop;
 end
 

  //------------------------------- TASKS -------------------------------//
 /////////////// TASK:  UART Frame Sending Task With Parity //////////////
 task send_uart_frame;
   input     start;
   input[7:0]frame;
   input     parity_type;
   input     parity_bit; 
   input     stop;
   integer   i;
   begin
   
     //start bit
     @(posedge TX_CLK_tb);
     UART_RX_IN_tb  = start ;

  
     //data bits (LSB first)  
     for (i = 0; i < 8; i = i + 1)
      begin
      @(posedge TX_CLK_tb);
      UART_RX_IN_tb = frame[i];
      end
      
      //Parity bit
      @(posedge TX_CLK_tb);
      UART_RX_IN_tb =  parity_bit;
 
      // Stop bit
      @(posedge TX_CLK_tb);
      UART_RX_IN_tb = stop;

      // Report Frame
      $display(" sent = %b ",{stop,parity_bit,frame,start} );
      
   end
 endtask
   //------------------------------- TASK: CHECK UART FRAME -------------------------------//
  task check_uart_frame;
    input       expected_start;     
    input [7:0] expected_data;   
    input       expected_parity; 
    input       expected_stop;   
    integer i;
    reg start_bit;
    reg [7:0] rx_data;
    reg parity_bit;
    reg stop_bit;
    begin

      rx_data='d0;

      // wait Tx VALIDATION
      @(posedge TX_OUT_V_tb) ;
      
      //start bit
      @(posedge TX_CLK_tb);
      start_bit = UART_TX_O_tb;
       
      //data bits
      for (i = 0; i < 8; i = i + 1) 
       begin
        @(posedge TX_CLK_tb);
        rx_data[i] = UART_TX_O_tb;
        end

        //parity bit
        @(posedge TX_CLK_tb);
        parity_bit = UART_TX_O_tb;

        //stop bit
        @(posedge TX_CLK_tb);
        stop_bit = UART_TX_O_tb;

       // single combined check & message
       if ((rx_data     === expected_data)   && 
          (start_bit   === expected_start)   && 
          (stop_bit    === expected_stop)    && 
         (parity_bit  === expected_parity)) 
       begin

         $display(" PASS : UART Frame Match at %t | Data=%b | Start=%b | Stop=%b | Parity=%b ",
              $time, rx_data, start_bit, stop_bit, parity_bit);

       end 
      else 
       begin

        $display(" FAILED : UART Frame Mismatch at %t | Expected: Data=%b Start=%b Stop=%b Parity=%b | Got: Data=%b Start=%b Stop=%b Parity=%b",
              $time, expected_data, expected_start, expected_stop, expected_parity,
                     rx_data, start_bit, stop_bit, parity_bit);

       end

    end
  endtask
  //------------------------------- TASK: CHECK UART FRAME -------------------------------//
  task check_uart_frame_alu;
    input        expected_start;     
    input [15:0] expected_data;   
    input        expected_parity; 
    input        expected_parity_2;
    input        expected_stop;   
    integer i;
    reg [15:0] rx_data;
    reg start_bit;
    reg parity_bit;
    reg parity_bit_2;
    reg stop_bit;
    begin

      rx_data='d0;

      // wait Tx VALIDATION (frame 1)
      @(posedge TX_OUT_V_tb) ;

      // start bit
      @(posedge TX_CLK_tb);
      start_bit = UART_TX_O_tb;
       

      // data bits
      for (i = 0; i < 8; i = i + 1) 
       begin
        @(posedge TX_CLK_tb);
        rx_data[i] = UART_TX_O_tb;
        end

      //parity bit (frame 1)
      @(posedge TX_CLK_tb);
      parity_bit = UART_TX_O_tb;

      //stop bit
      @(posedge TX_CLK_tb);
      stop_bit = UART_TX_O_tb;
       
       // wait Tx VALIDATION (frame 2)
       @(posedge TX_OUT_V_tb) ;

       // start bit
       @(posedge TX_CLK_tb);
       start_bit = UART_TX_O_tb;
       
       //data bit
       for (i = 8; i < 16; i = i + 1) 
       begin
        @(posedge TX_CLK_tb);
        rx_data[i] = UART_TX_O_tb;
       end

       //parity bit (frame 2)
       @(posedge TX_CLK_tb);
       parity_bit_2 = UART_TX_O_tb;

       //stop bit
       @(posedge TX_CLK_tb);
       stop_bit = UART_TX_O_tb;
      
      // single combined check & message
      if ((rx_data     === expected_data)   && 
         (start_bit   === expected_start)   && 
         (stop_bit    === expected_stop)    && 
         (parity_bit  === expected_parity)  && 
         (parity_bit_2=== expected_parity_2)) 
       begin

         $display(" PASS : UART Frame Match at %t | Data=%b | Start=%b | Stop=%b | Parity1=%b | Parity2=%b",
              $time, rx_data, start_bit, stop_bit, parity_bit, parity_bit_2);

       end 
      else 
       begin

        $display(" FAILED : UART Frame Mismatch at %t | Expected: Data=%b Start=%b Stop=%b Parity1=%b Parity2=%b | Got: Data=%b Start=%b Stop=%b Parity1=%b Parity2=%b",
              $time, expected_data, expected_start, expected_stop, expected_parity, expected_parity_2,
                     rx_data, start_bit, stop_bit, parity_bit, parity_bit_2);

       end

    end
  endtask

/////////////// NO PARITY TASKS:  UART Frame Sending & ckecking  Tasks  //////////////
 task send_uart_frame_no_parity;
   input     start;
   input[7:0]frame;
   //input     parity_type;
   //input     parity_bit; 
   input     stop;
   integer   i;
   begin
   
     //start bit
     @(posedge TX_CLK_tb);
     UART_RX_IN_tb  = start ;

  
     //data bits (LSB first)  
     for (i = 0; i < 8; i = i + 1)
      begin
      @(posedge TX_CLK_tb);
      UART_RX_IN_tb = frame[i];
      end
      
      //Parity bit
      //@(posedge TX_CLK_tb);
      //UART_RX_IN_tb =  parity_bit;
 
      // Stop bit
      @(posedge TX_CLK_tb);
      UART_RX_IN_tb = stop;

      // Report Frame
      $display(" sent = %b ",{stop,frame,start} );
      
   end
 endtask
   //------------------------------- TASK: CHECK UART FRAME -------------------------------//
  task check_uart_frame_no_parity;
    input       expected_start;     
    input [7:0] expected_data;   
    //input       expected_parity; 
    input       expected_stop;   
    integer i;
    reg start_bit;
    reg [7:0] rx_data;
    //reg parity_bit;
    reg stop_bit;
    begin

      rx_data='d0;

      // wait Tx VALIDATION
      @(posedge TX_OUT_V_tb) ;
      
      //start bit
      @(posedge TX_CLK_tb);
      start_bit = UART_TX_O_tb;
       
      //data bits
      for (i = 0; i < 8; i = i + 1) 
       begin
        @(posedge TX_CLK_tb);
        rx_data[i] = UART_TX_O_tb;
        end

        //parity bit
        //@(posedge TX_CLK_tb);
        //parity_bit = UART_TX_O_tb;

        //stop bit
        @(posedge TX_CLK_tb);
        stop_bit = UART_TX_O_tb;

       // single combined check & message
       if ((rx_data     === expected_data)   && 
          (start_bit   === expected_start)   && 
          (stop_bit    === expected_stop)) 
       begin

         $display(" PASS : UART Frame Match at %t | Data=%b | Start=%b | Stop=%b  ",
              $time, rx_data, start_bit, stop_bit);

       end 
      else 
       begin

        $display(" FAILED : UART Frame Mismatch at %t | Expected: Data=%b Start=%b Stop=%b  | Got: Data=%b Start=%b Stop=%b ",
              $time, expected_data, expected_start, expected_stop,
                     rx_data, start_bit, stop_bit);

       end

    end
  endtask
  //------------------------------- TASK: CHECK UART FRAME -------------------------------//
  task check_uart_frame_alu_no_parity;
    input        expected_start;     
    input [15:0] expected_data;   
    //input        expected_parity; 
    //input        expected_parity_2;
    input        expected_stop;   
    integer i;
    reg [15:0] rx_data;
    reg start_bit;
    //reg parity_bit;
    //reg parity_bit_2;
    reg stop_bit;
    begin

      rx_data='d0;

      // wait Tx VALIDATION (frame 1)
      @(posedge TX_OUT_V_tb) ;

      // start bit
      @(posedge TX_CLK_tb);
      start_bit = UART_TX_O_tb;
       

      // data bits
      for (i = 0; i < 8; i = i + 1) 
       begin
        @(posedge TX_CLK_tb);
        rx_data[i] = UART_TX_O_tb;
        end

      //parity bit (frame 1)
      //@(posedge TX_CLK_tb);
      //parity_bit = UART_TX_O_tb;

      //stop bit
      @(posedge TX_CLK_tb);
      stop_bit = UART_TX_O_tb;
       
       // wait Tx VALIDATION (frame 2)
       @(posedge TX_OUT_V_tb) ;

       // start bit
       @(posedge TX_CLK_tb);
       start_bit = UART_TX_O_tb;
       
       //data bit
       for (i = 8; i < 16; i = i + 1) 
       begin
        @(posedge TX_CLK_tb);
        rx_data[i] = UART_TX_O_tb;
       end

       //parity bit (frame 2)
       //@(posedge TX_CLK_tb);
       //parity_bit_2 = UART_TX_O_tb;

       //stop bit
       @(posedge TX_CLK_tb);
       stop_bit = UART_TX_O_tb;
      
      // single combined check & message
      if ((rx_data     === expected_data)   && 
         (start_bit   === expected_start)   && 
         (stop_bit    === expected_stop)) 
       begin

         $display(" PASS : UART Frame Match at %t | Data=%b | Start=%b | Stop=%b ",
              $time, rx_data, start_bit, stop_bit);

       end 
      else 
       begin

        $display(" FAILED : UART Frame Mismatch at %t | Expected: Data=%b Start=%b Stop=%b | Got: Data=%b Start=%b Stop=%b",
              $time, expected_data, expected_start, expected_stop, 
                     rx_data, start_bit, stop_bit);

       end

    end
  endtask

////////////// Signals Initialization //////////////////

task initialize ;
  begin
	UART_CLK_tb         = 1'b0      ;
	REF_CLK_tb          = 1'b0      ;
	RST_N_tb            = 1'b1      ;    // rst is deactivated
	UART_RX_IN_tb       = 1'b1      ;    // ideal = 1
	
  end
endtask

///////////////////////// RESET /////////////////////////
task reset ;
  begin
	#(REF_CLK_PERIOD)
	RST_N_tb  = 'b0;           // rst is activated
	#(REF_CLK_PERIOD)
	RST_N_tb  = 'b1;
	#(REF_CLK_PERIOD) ;
  end
endtask
endmodule 
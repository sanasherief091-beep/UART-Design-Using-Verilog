module UART_TX  # (parameter DATA_WIDTH = 8)
(
  
//Interface Signals
input  wire [DATA_WIDTH - 1:0] P_DATA,
input  wire                    Data_Valid,
input  wire                    PAR_EN,
input  wire                    PAR_TYP,
input  wire                    CLK,
input  wire                    RST,
output wire                    TX_OUT,
output wire                    busy
);

//internal Connections
wire       ser_done;
wire       ser_en;
wire       par_bit;
wire       ser_data;
wire [1:0] mux_sel;

//FSM: Controls transmission flow
TX_FSM U_TX_FSM (
.CLK(CLK),
.RST(RST),
.Data_Valid(Data_Valid),
.PAR_EN(PAR_EN),
.ser_done(ser_done),
.ser_en(ser_en),
.mux_sel(mux_sel),
.busy(busy)
);

// Serializer: Converts parallel to serial
serializer # (.WIDTH(DATA_WIDTH)) U_serializer(
.CLK(CLK),
.RST(RST),
.Data_Valid(Data_Valid),
.busy(busy),
.P_DATA(P_DATA),
.ser_en(ser_en),
.ser_done(ser_done),
.ser_data(ser_data)
);

//Parity Calculator
parity_calc # (.WIDTH(DATA_WIDTH)) U_parity_calc(
.CLK(CLK),
.RST(RST),
.Data_Valid(Data_Valid),
.busy(busy),
.P_DATA(P_DATA),
.PAR_EN(PAR_EN),
.PAR_TYP(PAR_TYP),
.par_bit(par_bit)
);

// MUX: Selects which bit to send out
MUX U_MUX(
.CLK(CLK),
.RST(RST),
.mux_sel(mux_sel),
.ser_data(ser_data),
.par_bit(par_bit),
.TX_OUT(TX_OUT)
);


endmodule
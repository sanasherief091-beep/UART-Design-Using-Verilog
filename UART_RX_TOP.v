module TOP (

//Interface Signals  
input  wire       RX_IN,
input  wire       CLK,
input  wire       RST,
input  wire [5:0] Prescale,
input  wire       PAR_EN,
input  wire       PAR_TYP,
output wire       stp_err,
output wire       par_err,
output wire       data_valid,
output wire [7:0] P_DATA

);

//internal Connections
wire       dat_samp_en;
wire       cnt_en;
wire [3:0] bit_cnt;
wire [5:0] edge_cnt;
wire       deser_en;
wire       sampled_bit;
wire       stp_chk_en;
wire       strt_glitch;
wire       strt_chk_en;
wire       par_chk_en;
//wire       stp_err;
//wire       par_err;



//FSM: Controls receiving flow
FSM U_FSM (

.RST(RST),
.CLK(CLK),
.RX_IN(RX_IN),
.Prescale(Prescale),
.edge_cnt(edge_cnt),
.bit_cnt(bit_cnt),
.stp_err(stp_err),
.strt_glitch(strt_glitch),
.par_err(par_err),
.PAR_EN(PAR_EN),
.dat_samp_en(dat_samp_en),
.cnt_en(cnt_en),
.deser_en(deser_en),
.data_valid(data_valid),
.stp_chk_en(stp_chk_en),
.strt_chk_en(strt_chk_en),
.par_chk_en(par_chk_en)

);

edge_bit_counter U_edge_bit_counter (

.RST(RST),
.CLK(CLK),
.Prescale(Prescale),
.cnt_en(cnt_en),
.PAR_EN(PAR_EN),
.bit_cnt(bit_cnt),
.edge_cnt(edge_cnt)

);

deserializer U_deserializer(

.RST(RST),
.CLK(CLK),
.deser_en(deser_en), 
.sampled_bit(sampled_bit),
.bit_cnt(bit_cnt),
.P_DATA(P_DATA)

);

data_sampling U_data_sampling (

.RST(RST),
.CLK(CLK),
.dat_samp_en(dat_samp_en),
.edge_cnt(edge_cnt),
.RX_IN(RX_IN),
.Prescale(Prescale),
.sampled_bit(sampled_bit)

);

stop_check U_stop_check (
  
.RST(RST),
.CLK(CLK),
.stp_chk_en(stp_chk_en),
.sampled_bit(sampled_bit),
.stp_err(stp_err)
 
);

 start_check U_start_check (
  
.RST(RST),
.CLK(CLK),
.strt_chk_en(strt_chk_en),
.sampled_bit(sampled_bit),
.strt_glitch(strt_glitch)
 
);

parity_check U_parity_check (
  
.RST(RST),
.CLK(CLK),
.PAR_TYP(PAR_TYP),       
.par_chk_en(par_chk_en),
.sampled_bit(sampled_bit),   
.P_DATA(P_DATA),       
.par_err(par_err)

);

endmodule
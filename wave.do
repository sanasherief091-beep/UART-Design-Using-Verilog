onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /system_tb/DATA_WIDTH
add wave -noupdate -expand -group TB /system_tb/RF_ADDR
add wave -noupdate -expand -group TB /system_tb/REF_CLK_PERIOD
add wave -noupdate -expand -group TB /system_tb/UART_CLK_PERIOD
add wave -noupdate -expand -group TB /system_tb/RST_N_tb
add wave -noupdate -expand -group TB -color Orchid -itemcolor Orchid /system_tb/UART_CLK_tb
add wave -noupdate -expand -group TB -color Magenta -itemcolor Magenta /system_tb/REF_CLK_tb
add wave -noupdate -expand -group TB -color Salmon -itemcolor Salmon -radix hexadecimal /system_tb/UART_RX_IN_tb
add wave -noupdate -expand -group TB -color Sienna -itemcolor Sienna /system_tb/TX_CLK_tb
add wave -noupdate -expand -group TB -color Orange -itemcolor Orange /system_tb/UART_TX_O_tb
add wave -noupdate -expand -group TB -color {Indian Red} -itemcolor {Indian Red} /system_tb/TX_OUT_V_tb
add wave -noupdate -expand -group TB /system_tb/parity_error_tb
add wave -noupdate -expand -group TB /system_tb/framing_error_tb
add wave -noupdate -expand -group CONTROL /system_tb/DUT/U0_SYS_CTRL/RST
add wave -noupdate -expand -group CONTROL -color Magenta -itemcolor Magenta /system_tb/DUT/U0_SYS_CTRL/CLK
add wave -noupdate -expand -group CONTROL /system_tb/DUT/U0_SYS_CTRL/DATA_WIDTH
add wave -noupdate -expand -group CONTROL /system_tb/DUT/U0_SYS_CTRL/RF_ADDR
add wave -noupdate -expand -group CONTROL -color {Medium Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/current_state
add wave -noupdate -expand -group CONTROL -color {Steel Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/next_state
add wave -noupdate -expand -group CONTROL -color {Dark Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_DATA
add wave -noupdate -expand -group CONTROL -color {Medium Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_VLD
add wave -noupdate -expand -group CONTROL -group AA -color {Dark Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_DATA
add wave -noupdate -expand -group CONTROL -group AA -color {Medium Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_VLD
add wave -noupdate -expand -group CONTROL -group AA -color Goldenrod -radix unsigned /system_tb/DUT/U0_SYS_CTRL/RF_Address
add wave -noupdate -expand -group CONTROL -group AA /system_tb/DUT/U0_SYS_CTRL/rf_wr_addr_reg
add wave -noupdate -expand -group CONTROL -group AA -color Yellow /system_tb/DUT/U0_SYS_CTRL/RF_WrEn
add wave -noupdate -expand -group CONTROL -group AA -color Yellow /system_tb/DUT/U0_SYS_CTRL/RF_WrData
add wave -noupdate -expand -group CONTROL -group BB -color {Dark Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_DATA
add wave -noupdate -expand -group CONTROL -group BB -color {Medium Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_VLD
add wave -noupdate -expand -group CONTROL -group BB -color {Pale Green} /system_tb/DUT/U0_SYS_CTRL/RF_RdData
add wave -noupdate -expand -group CONTROL -group BB -color {Yellow Green} /system_tb/DUT/U0_SYS_CTRL/RF_RdData_VLD
add wave -noupdate -expand -group CONTROL -group BB /system_tb/DUT/U0_SYS_CTRL/RF_RdEn
add wave -noupdate -expand -group CONTROL -group BB -color Goldenrod -radix unsigned /system_tb/DUT/U0_SYS_CTRL/RF_Address
add wave -noupdate -expand -group CONTROL -group BB /system_tb/DUT/U0_SYS_CTRL/FIFO_FULL
add wave -noupdate -expand -group CONTROL -group BB -color Orange -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_TX_DATA
add wave -noupdate -expand -group CONTROL -group BB -color Sienna -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_TX_VLD
add wave -noupdate -expand -group CONTROL -expand -group CC -color {Dark Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_DATA
add wave -noupdate -expand -group CONTROL -expand -group CC -color {Medium Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_VLD
add wave -noupdate -expand -group CONTROL -expand -group CC -color Goldenrod -radix unsigned /system_tb/DUT/U0_SYS_CTRL/RF_Address
add wave -noupdate -expand -group CONTROL -expand -group CC -color Yellow /system_tb/DUT/U0_SYS_CTRL/RF_WrEn
add wave -noupdate -expand -group CONTROL -expand -group CC -color Yellow /system_tb/DUT/U0_SYS_CTRL/RF_WrData
add wave -noupdate -expand -group CONTROL -expand -group CC -color {Light Steel Blue} /system_tb/DUT/U0_SYS_CTRL/CLKDIV_EN
add wave -noupdate -expand -group CONTROL -expand -group CC -color Thistle /system_tb/DUT/U0_SYS_CTRL/ALU_EN
add wave -noupdate -expand -group CONTROL -expand -group CC -color {Light Blue} /system_tb/DUT/U0_SYS_CTRL/ALU_FUN
add wave -noupdate -expand -group CONTROL -expand -group CC -color Wheat /system_tb/DUT/U0_SYS_CTRL/CLKG_EN
add wave -noupdate -expand -group CONTROL -expand -group CC -color {Sky Blue} /system_tb/DUT/U0_SYS_CTRL/ALU_OUT
add wave -noupdate -expand -group CONTROL -expand -group CC -color {Light Blue} /system_tb/DUT/U0_SYS_CTRL/ALU_OUT_VLD
add wave -noupdate -expand -group CONTROL -expand -group CC -radix unsigned /system_tb/DUT/U0_SYS_CTRL/alu_out_reg
add wave -noupdate -expand -group CONTROL -expand -group CC -color Sienna -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_TX_VLD
add wave -noupdate -expand -group CONTROL -expand -group CC -color Orange -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_TX_DATA
add wave -noupdate -expand -group CONTROL -group DD -color {Dark Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_DATA
add wave -noupdate -expand -group CONTROL -group DD -color {Medium Slate Blue} -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_RX_VLD
add wave -noupdate -expand -group CONTROL -group DD -color {Light Steel Blue} /system_tb/DUT/U0_SYS_CTRL/CLKDIV_EN
add wave -noupdate -expand -group CONTROL -group DD -color Thistle /system_tb/DUT/U0_SYS_CTRL/ALU_EN
add wave -noupdate -expand -group CONTROL -group DD -color {Light Blue} /system_tb/DUT/U0_SYS_CTRL/ALU_FUN
add wave -noupdate -expand -group CONTROL -group DD -color Wheat /system_tb/DUT/U0_SYS_CTRL/CLKG_EN
add wave -noupdate -expand -group CONTROL -group DD -color {Sky Blue} /system_tb/DUT/U0_SYS_CTRL/ALU_OUT
add wave -noupdate -expand -group CONTROL -group DD -color {Light Blue} /system_tb/DUT/U0_SYS_CTRL/ALU_OUT_VLD
add wave -noupdate -expand -group CONTROL -group DD -color Sienna -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_TX_VLD
add wave -noupdate -expand -group CONTROL -group DD -color Orange -itemcolor Black /system_tb/DUT/U0_SYS_CTRL/UART_TX_DATA
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/WiDTH
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/DEPTH
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/RST
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/ADDR
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/CLK
add wave -noupdate -group reg_file -color Goldenrod /system_tb/DUT/U0_RegFile/Address
add wave -noupdate -group reg_file -color Yellow /system_tb/DUT/U0_RegFile/WrEn
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/RdEn
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/WrData
add wave -noupdate -group reg_file -color {Green Yellow} /system_tb/DUT/U0_RegFile/RdData_VLD
add wave -noupdate -group reg_file -color {Pale Green} /system_tb/DUT/U0_RegFile/RdData
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/REG0
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/REG1
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/REG2
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/REG3
add wave -noupdate -group reg_file /system_tb/DUT/U0_RegFile/i
add wave -noupdate -group reg_file -expand /system_tb/DUT/U0_RegFile/Reg_File
add wave -noupdate -group UART /system_tb/DUT/U0_UART/DATA_WIDTH
add wave -noupdate -group UART /system_tb/DUT/U0_UART/RST
add wave -noupdate -group UART /system_tb/DUT/U0_UART/RX_CLK
add wave -noupdate -group UART -color Sienna -itemcolor Sienna /system_tb/DUT/U0_UART/TX_CLK
add wave -noupdate -group UART -color Orange -itemcolor Orange /system_tb/DUT/U0_UART/TX_OUT_S
add wave -noupdate -group UART -color {Indian Red} -itemcolor {Indian Red} /system_tb/DUT/U0_UART/TX_OUT_V
add wave -noupdate -group UART -color Salmon -itemcolor Salmon -radix hexadecimal /system_tb/DUT/U0_UART/RX_IN_S
add wave -noupdate -group UART -color {Dark Slate Blue} -itemcolor Black -radix hexadecimal -childformat {{{/system_tb/DUT/U0_UART/RX_OUT_P[7]} -radix hexadecimal} {{/system_tb/DUT/U0_UART/RX_OUT_P[6]} -radix hexadecimal} {{/system_tb/DUT/U0_UART/RX_OUT_P[5]} -radix hexadecimal} {{/system_tb/DUT/U0_UART/RX_OUT_P[4]} -radix hexadecimal} {{/system_tb/DUT/U0_UART/RX_OUT_P[3]} -radix hexadecimal} {{/system_tb/DUT/U0_UART/RX_OUT_P[2]} -radix hexadecimal} {{/system_tb/DUT/U0_UART/RX_OUT_P[1]} -radix hexadecimal} {{/system_tb/DUT/U0_UART/RX_OUT_P[0]} -radix hexadecimal}} -subitemconfig {{/system_tb/DUT/U0_UART/RX_OUT_P[7]} {-color {Dark Slate Blue} -height 15 -itemcolor Black -radix hexadecimal} {/system_tb/DUT/U0_UART/RX_OUT_P[6]} {-color {Dark Slate Blue} -height 15 -itemcolor Black -radix hexadecimal} {/system_tb/DUT/U0_UART/RX_OUT_P[5]} {-color {Dark Slate Blue} -height 15 -itemcolor Black -radix hexadecimal} {/system_tb/DUT/U0_UART/RX_OUT_P[4]} {-color {Dark Slate Blue} -height 15 -itemcolor Black -radix hexadecimal} {/system_tb/DUT/U0_UART/RX_OUT_P[3]} {-color {Dark Slate Blue} -height 15 -itemcolor Black -radix hexadecimal} {/system_tb/DUT/U0_UART/RX_OUT_P[2]} {-color {Dark Slate Blue} -height 15 -itemcolor Black -radix hexadecimal} {/system_tb/DUT/U0_UART/RX_OUT_P[1]} {-color {Dark Slate Blue} -height 15 -itemcolor Black -radix hexadecimal} {/system_tb/DUT/U0_UART/RX_OUT_P[0]} {-color {Dark Slate Blue} -height 15 -itemcolor Black -radix hexadecimal}} /system_tb/DUT/U0_UART/RX_OUT_P
add wave -noupdate -group UART -color {Medium Slate Blue} -itemcolor Black -radix binary /system_tb/DUT/U0_UART/RX_OUT_V
add wave -noupdate -group UART -color Orange -itemcolor Black /system_tb/DUT/U0_UART/TX_IN_P
add wave -noupdate -group UART -color Sienna -itemcolor Black /system_tb/DUT/U0_UART/TX_IN_V
add wave -noupdate -group UART /system_tb/DUT/U0_UART/Prescale
add wave -noupdate -group UART /system_tb/DUT/U0_UART/parity_enable
add wave -noupdate -group UART /system_tb/DUT/U0_UART/parity_type
add wave -noupdate -group UART /system_tb/DUT/U0_UART/parity_error
add wave -noupdate -group UART /system_tb/DUT/U0_UART/framing_error
add wave -noupdate -group ALU /system_tb/DUT/U0_ALU/OPER_WIDTH
add wave -noupdate -group ALU /system_tb/DUT/U0_ALU/OUT_WIDTH
add wave -noupdate -group ALU -radix unsigned /system_tb/DUT/U0_ALU/A
add wave -noupdate -group ALU -radix unsigned /system_tb/DUT/U0_ALU/B
add wave -noupdate -group ALU -color {Light Blue} /system_tb/DUT/U0_ALU/ALU_fun
add wave -noupdate -group ALU /system_tb/DUT/U0_ALU/clk
add wave -noupdate -group ALU /system_tb/DUT/U0_ALU/rst
add wave -noupdate -group ALU -color Turquoise /system_tb/DUT/U0_ALU/enable
add wave -noupdate -group ALU -color {Sky Blue} -radix unsigned /system_tb/DUT/U0_ALU/ALU_out
add wave -noupdate -group ALU -color {Light Blue} -itemcolor White /system_tb/DUT/U0_ALU/out_valid
add wave -noupdate -group ALU /system_tb/DUT/U0_ALU/ALU_out1
add wave -noupdate -group ALU /system_tb/DUT/U0_ALU/out_valid_1
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/DATA_WIDTH
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/ADD_SIZE
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/FIFO_DEPTH
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/W_CLK
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/W_RST
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/W_INC
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/R_CLK
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/R_RST
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/R_INC
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/WR_DATA
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/RD_DATA
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/FULL
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/EMPTY
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/W_ADD
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/R_ADD
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/rq2_wptr
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/R_PTR
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/wq2_rptr
add wave -noupdate -group FIFO /system_tb/DUT/U0_UART_FIFO/W_PTR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5694870000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 172
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {5514564491 ps} {6249839757 ps}

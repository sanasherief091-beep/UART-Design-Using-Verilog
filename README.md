# UART Design Using Verilog HDL

## Project Overview
This project presents the design and implementation of a UART (Universal Asynchronous Receiver/Transmitter) communication system using Verilog HDL.

The design integrates both UART Transmitter (TX) and Receiver (RX) modules, along with supporting digital modules to handle data transmission, reception, synchronization, and control operations.

## Project Architecture

The project consists of the following main blocks:

- **UART Transmitter (TX):** Handles serial data transmission.
- **UART Receiver (RX):** Handles serial data reception.
- **System Controller:** Coordinates the system operations.
- **FIFO:** Supports data buffering.
- **Synchronization Modules:** Handle clock-domain synchronization.
- **ALU:** Performs arithmetic and logic operations.
- **Parity Logic:** Supports parity generation and checking.
- **Clock and Reset Modules:** Handle clock division, clock gating, and reset synchronization.

## RTL Modules

The design includes multiple Verilog modules, such as:

- UART_TX_TOP
- UART_RX_TOP
- UART
- SYS_TOP
- SYS_CTRL
- TX_FSM
- FSM
- ASYNC_FIFO_TOP
- FIFO_WR
- FIFO_RD
- FIFO_MEM_CNTRL
- serializer
- deserializer
- data_sampling
- DATA_SYNC
- DF_SYNC
- ALU
- parity_calc
- parity_check
- PULSE_GEN
- CLK_GATE
- RST_SYNC

Additional supporting modules are included in the RTL directory.

## Verification & Simulation

The complete system was tested using a system-level testbench.

**Simulation Environment:**
- HDL: Verilog
- Simulation Tool: ModelSim
- Testbench: System Testbench (`system_tb.v`)
- Waveform Configuration: `wave.do`
- Simulation Script: `run.do`

The system testbench is used to verify the integrated design, while waveform inspection helps analyze the system signals and behavior.

## Project Structure

```text
UART-Design-Using-Verilog/
│
├── RTL/
│   └── Verilog Design Modules
│
├── Testbench/
│   └── system_tb.v
│
├── Simulation/
│   ├── wave.do
│   └── run.do
│
└── README.md
```

## Tools & Technologies

- Verilog HDL
- ModelSim
- RTL Design
- Digital Design & Verification

---

**Author:** Sana Sherief


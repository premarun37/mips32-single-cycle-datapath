# MIPS32 Single Cycle Datapath Design

This repository presents the design and implementation of a **32-bit MIPS single-cycle datapath** using Verilog HDL. The project focuses on understanding processor architecture by implementing instruction execution within a single clock cycle.

A single-cycle datapath executes each instruction in one clock cycle, integrating fetch, decode, execute, memory access, and write-back stages into a unified architecture :contentReference[oaicite:0]{index=0}.

---

## Project Overview

- **Architecture**: MIPS32  
- **Design Type**: Single-Cycle Datapath  
- **Language**: Verilog HDL  
- **Domain**: Digital Design / Computer Architecture  
- **Simulation Tool**: (ModelSim / your tool - update if needed)  

---

## Key Components

The datapath consists of fundamental processor building blocks:

- Program Counter (PC)  
- Instruction Memory  
- Register File  
- Arithmetic Logic Unit (ALU)  
- Data Memory  
- Multiplexers and Control Unit  

These components work together to execute instructions by controlling data flow and operations within the processor :contentReference[oaicite:1]{index=1}.

---

## Features

- Implementation of 32-bit MIPS architecture  
- Supports instruction types:
  - R-type (add, sub, and, or)  
  - I-type (lw, sw)  
  - Branch (beq)  
- Single-cycle execution for all instructions  
- Control signal generation for datapath operation  
- Modular RTL design for each component  

---

## Supported Instructions

- Arithmetic: `add`, `sub`, `and`, `or`  
- Data Transfer: `lw`, `sw`  
- Control Flow: `beq`  

---

## Repository Structure

```
mips32-single-cycle-datapath/
│
├── design/
├── testbench/
├── simulation/
└── README.md
```

---

## Methodology

1. Designed individual components (ALU, register file, memory units)  
2. Developed control unit for instruction decoding  
3. Integrated all modules to form complete datapath  
4. Simulated instruction execution using testbench  
5. Verified correctness using waveform analysis  

---

## Results

- Successfully implemented a functional single-cycle MIPS datapath  
- Verified correct execution of arithmetic, memory, and branch instructions  
- Observed proper control signal generation and data flow through simulation  

---

## Applications

- Understanding processor design fundamentals  
- Academic learning in computer architecture  
- Foundation for pipelined and multi-cycle CPU design  

---

## Conclusion

This project demonstrates the design of a simple yet complete MIPS32 processor datapath using a single-cycle architecture. While simple to design, the single-cycle approach has limitations in performance due to longer clock cycles, making it a foundational step toward more advanced processor designs :contentReference[oaicite:2]{index=2}.

---

## Author

- Prem Arun P  

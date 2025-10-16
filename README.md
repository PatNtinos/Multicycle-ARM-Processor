# 🧠 Multicycle ARM Processor (VHDL – Vivado)

## 📘 Overview
This project implements a **multicycle ARM processor** in **VHDL**, developed using **Xilinx Vivado IDE**.  
The design supports **data processing**, **memory**, and **branch instructions**, following a **multicycle execution model** to optimize hardware utilization while maintaining instruction flexibility.
Its architecture consists of a datapath and a control unit, with 25 individual components, each accompanied by dedicated testbenches to ensure correct functionality.
A custom ARM assembly program was included to verify and demonstrate the processor’s correct operation.
---

## ⚙️ Supported Instructions

### 🏗 Data Processing  
`ADD(S)`, `SUB(S)`, `AND(S)`, `ORR(S)`, `EOR(S)`, `CMP`, `MOV`, `MVN`, `LSL`, `LSR`, `ASR`, `ROR`

### 📦 Memory  
`LDR`, `STR`

### 🔀 Branch  
`B`, `BL`

---

## 🧩 Design Architecture

### 🔹 Datapath  
Handles data flow and arithmetic operations within the processor.  
Components include the **Program Counter (PC)**, **Instruction Memory**, **Register File**, **Extender**, **ALU**, **Status Register**, **Data Memory**, and several specialized **register modules** with reset and write-enable control.  
All modules are interconnected to form a complete and efficient execution pipeline.


<p align="center">
  <img src="ARM Processor/schemas/Datapath.png">
  <br>
  <em>Figure 1: Datapath structure of the processor</em>
</p>


<p align="center">
  <img src="ARM Processor/schemas/Datapath_Elaborated_Design.png">
  <br>
  <em>Figure 2: Datapath RTL</em>
</p>

### 🔹 Control Unit  
Decodes instructions and generates control signals to coordinate datapath operations for each execution phase.

<p align="center">
  <img src="ARM Processor/schemas/Control_Unit.png">
  <br>
  <em>Figure 3: Control Unit structure of the processor</em>
</p>

<p align="center">
  <img src="ARM Processor/schemas/Control_Unit_Elaborated_Design.png">
  <br>
  <em>Figure 4: Control Unit RTL</em>
</p>

### 🔹 Finite State Machine (FSM)  
Defines the control flow for multicycle instruction execution, sequencing states and control signals to ensure correct timing and synchronization.

<p align="center">
  <img src="ARM Processor/schemas/FSM.png">
  <br>
  <em>Figure 5: FSM</em>
</p>

### 🔹 Processor Integration  
The **Datapath** and **Control Unit** were combined to form the full processor.  
Instruction memory was preloaded with ARM machine code for simulation and verification.

<p align="center">
  <img src="ARM Processor/schemas/Processor.png">
  <br>
  <em>Figure 5: Processor</em>
</p>

---

## 🧪 Simulation & Testing
Functionality was verified through an **ARM assembly test program** loaded into instruction memory in **hexadecimal format**.  
The test covered arithmetic, logic, memory, and branching operations — confirming correct multicycle execution and synchronization between datapath and control signals.

### 🧾 Example Test Program
```asm
MAIN_PROGRAM:
MOV     R0, #5          ; R0 = 5
MOV     R1, #2          ; R1 = 2
ADD     R2, R0, R1      ; R2 = 7 , R2= R0+R1
SUB     R3, R2, #4      ; R3 = 3 , R3= R2-4
AND     R4, R2, R3      ; R4 = 7 & 3 = 3
ORR     R5, R4, #8      ; R5 = 3 | 8 = 11
EOR     R6, R5, R0      ; R6 = 11 xor 5 = 14
LSL     R7, R6, #1      ; R7 = 14 << 1 = 28
ASR     R8, R7, #2      ; R8 = 28 >> 2 = 7
CMP     R7, R8          ; compare 28 vs 7 (sets flags)
ADD     R9, R8, #9      ; R9 = 7 + 9 = 16
MVN     R10, R9         ; R10 = NOT(16)
BL      function        ; call function
STR     R10, [R0, #12]  ; store R10 at [R0+12]
LDR     R11, [R0, #12]  ; load R11 = R10
B MAIN_PROGRAM;

function:
MOV R3, #8; R3 = 8
MOV R4, #2; R4 = 2
ADD R7, R3, R4;
MOV PC, LR; Return to MAIN_PROGRAM
```

## 🧠 Conclusion

This project successfully demonstrates the design and implementation of a **multicycle ARM processor** using **VHDL** in **Vivado IDE**.  
The processor executes a wide range of ARM instructions — including data processing, memory, and branch operations — through an efficient multicycle control scheme.  
All modules were verified through comprehensive testbenches to ensure accuracy and timing reliability.  
Its modular and scalable architecture provides a solid foundation for future enhancements such as **pipelining**, **interrupt handling**, and **extended instruction support**. 🚀

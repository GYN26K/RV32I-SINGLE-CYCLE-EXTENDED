# Extended 32-Instruction RISC-V ISA Design

This project extends the base RISC-V instruction set by designing a **custom 32-instruction ISA encoding using 5-bit instruction identifiers**.  

The goal is to simplify instruction decoding while maintaining support for essential arithmetic, logical, memory, and control operations.

---

## Instruction Encoding Strategy

- Each instruction is assigned a unique **5-bit ID**
- Total possible instructions = **2⁵ = 32**
- Instructions are grouped based on RISC-V formats:
  - R-type
  - I-type
  - Memory (Load/Store)
  - Branch (B-type)
  - Jump (J-type)

---

## Instruction Set Breakdown

### R-Type Instructions (10)

| ID | Instruction |
|----|------------|
| 0  | ADD        |
| 1  | SUB        |
| 2  | AND        |
| 3  | OR         |
| 4  | XOR        |
| 5  | SLL        |
| 6  | SRL        |
| 7  | SRA        |
| 8  | SLT        |
| 9  | SLTU       |

---

### I-Type Instructions (9)

| ID | Instruction |
|----|------------|
| 10 | ADDI       |
| 11 | ANDI       |
| 12 | ORI        |
| 13 | XORI       |
| 14 | SLTI       |
| 15 | SLTIU      |
| 16 | SLLI       |
| 17 | SRLI       |
| 18 | SRAI       |

---

### Memory Instructions (2)

| ID | Instruction |
|----|------------|
| 19 | LW         |
| 20 | SW         |

---

### Branch Instructions (6)

| ID | Instruction |
|----|------------|
| 21 | BEQ        |
| 22 | BNE        |
| 23 | BLT        |
| 24 | BGE        |
| 25 | BGEU       |
| 26 | BLTU       |

---

### Jump / Upper Instructions (4)

| ID | Instruction |
|----|------------|
| 27 | JAL        |
| 28 | JALR       |
| 29 | LUI        |
| 30 | AUIPC      |

---
## Architecture Description

### Single-Cycle Design

Each instruction in the processor is executed in a single clock cycle. All stages of instruction execution occur simultaneously:

- Instruction Fetch (IF)
- Instruction Decode (ID)
- Execute (EX)
- Memory Access (MEM)
- Write Back (WB)

This approach simplifies control logic at the cost of a longer clock period.

---

## Core Components

### Program Counter (PC)
- Holds the address of the current instruction
- Updates every clock cycle based on sequential or control flow instructions

### Instruction Memory
- Stores the program instructions
- Addressed by the Program Counter

### Register File
- Contains 32 general-purpose registers (x0–x31)
- Supports:
  - Two read ports
  - One write port

### Arithmetic Logic Unit (ALU)
Performs:
- Arithmetic operations (ADD, SUB)
- Logical operations (AND, OR, XOR)
- Shift operations (SLL, SRL, SRA)
- Comparison operations (SLT, etc.)

### Control Unit
Generates control signals based on the instruction:
- RegWrite
- ALUSrc
- MemRead
- MemWrite
- MemtoReg
- Branch
- Jump

### Data Memory
- Used for load (LW) and store (SW) instructions

---

## Instruction Set Design

The processor supports a **custom 40-instruction ISA**, extending the base RISC-V instruction set.

### Key Characteristics
- Uses opcode and function fields for instruction decoding
- Covers:
  - Arithmetic operations
  - Logical operations
  - Immediate operations
  - Memory access
  - Branching
  - Jump instructions

### Design Approach
Instead of compressing into a fixed 5-bit encoding:
- The design retains full instruction diversity
- Decoding logic is simplified for FPGA implementation
- Trade-off favors functionality over minimal encoding

---

## Fibonacci Sequence Implementation

### Objective
To demonstrate correct processor functionality by generating the Fibonacci sequence:

F(n) = F(n-1) + F(n-2)

### Register Usage Example
- x1: First number (0)
- x2: Second number (1)
- x3: Result
- x4: Loop counter

### Execution Flow

1. Initialize registers:
   - x1 = 0
   - x2 = 1

2. Loop:
   - ADD x3, x1, x2
   - Move values:
     - x1 ← x2
     - x2 ← x3
   - Repeat for desired number of iterations

---

## FPGA Implementation

### Target Hardware
- Basys 3 FPGA Board

### Output Display
- 7-segment display used to show Fibonacci numbers
- Optional use of LEDs for debugging internal states

### Clock Handling
- A clock divider is used to slow down execution
- Ensures outputs are human-readable on hardware

### Execution Flow on FPGA

1. Instructions are loaded into instruction memory
2. Processor executes instructions sequentially
3. Fibonacci values are computed
4. Results are sent to display module

---

## Design Highlights

- Supports full 40-instruction ISA
- Clean and modular single-cycle datapath
- Successfully implemented on FPGA hardware
- Demonstrates real-time computation using Fibonacci sequence

---

## Limitations

- Single-cycle design leads to a longer clock period
- Performance limited by the slowest instruction path
- No pipelining or parallel execution
- Increased instruction count slightly complicates control logic

---

## Conclusion

This project demonstrates the design and implementation of a custom single-cycle RISC-V processor with an extended instruction set. By executing a Fibonacci sequence on FPGA hardware, it validates both the datapath and control unit functionality in a practical and observable manner.

---

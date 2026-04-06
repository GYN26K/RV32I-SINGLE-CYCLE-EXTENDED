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
## Key Highlights

- Compact **5-bit instruction encoding**
- Simplified **decoder design**
- Covers all essential instruction categories
- Fully compatible with:
  - Arithmetic operations
  - Logical operations
  - Memory access
  - Branching and control flow

---

## Use Case

This custom ISA design is ideal for:
- FPGA-based CPU implementations
- Educational processor design
- Optimized control logic experiments
- Pipeline architecture extensions

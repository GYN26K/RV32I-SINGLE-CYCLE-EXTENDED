# Extended 32-Instruction RISC-V ISA Design

A custom 32-instruction RISC-V processor architecture engineered with a simplified 5-bit instruction identification scheme. This single-cycle architecture balances decoded control logic constraints with execution support for essential arithmetic, logical, memory, and control operational blocks mapped to FPGA hardware.

---

## Features

* **Custom 5-Bit ISA Encoding:** Tailored 5-bit identifiers for streamlined instruction decoding, maximizing the $2^5 = 32$ instruction address space.
* **Single-Cycle Datapath:** Concurrent processing of Instruction Fetch (IF), Decode (ID), Execute (EX), Memory (MEM), and Writeback (WB) stages within a single clock period.
* **On-Chip Peripheral Support:** Integrated multiplexing logic to drive a 4-digit Seven Segment Display for real-time hardware tracking.
* **Automated Vivado Toolchain:** Leverages headless TCL scripting to fully automate project creation, synthesis, implementation, and bitstream generation.

---

## Project Structure

```text
GYN26K/
├── design_files/          # Verilog RTL Source Code modules (.v)
├── constraint_files/      # Physical Constraints & Pin Mapping (.xdc)
├── simulation_files/      # Simulation testbenches for verification (.v)
├── tcl_files/             # Vivado Automation Scripts (riscv_singlecycle.tcl)
├── results/               # Extracted Hardware Bitstreams, Reports, and FPGA Photos
└── README.md              # Project Documentation
```

> **Note:** Auto-generated Vivado compilation directories (`build/`, `.Xil/`) and raw localized logs are excluded from version control to maintain a clean repository footprint.

---

## Instruction Encoding Strategy

The base RISC-V instruction set is mapped into a unique **5-bit instruction identifier** field, eliminating deep multi-stage opcode/funct3/funct7 decoding architectures.

### R-Type Instructions (10)
| ID | Instruction | Operational Subtype |
|:---:|:---|:---|
| 0 | ADD | Two's Complement Addition |
| 1 | SUB | Two's Complement Subtraction |
| 2 | AND | Bitwise Logical AND |
| 3 | OR | Bitwise Logical OR |
| 4 | XOR | Bitwise Logical Exclusive OR |
| 5 | SLL | Shift Left Logical |
| 6 | SRL | Shift Right Logical |
| 7 | SRA | Shift Right Arithmetic |
| 8 | SLT | Set Less Than (Signed) |
| 9 | SLTU | Set Less Than Unsigned |

### I-Type Instructions (9)
| ID | Instruction | Operational Subtype |
|:---:|:---|:---|
| 10 | ADDI | Add Immediate |
| 11 | ANDI | Bitwise AND Immediate |
| 12 | ORI | Bitwise OR Immediate |
| 13 | XORI | Bitwise XOR Immediate |
| 14 | SLTI | Set Less Than Immediate (Signed) |
| 15 | SLTIU | Set Less Than Immediate Unsigned |
| 16 | SLLI | Shift Left Logical Immediate |
| 17 | SRLI | Shift Right Logical Immediate |
| 18 | SRAI | Shift Right Arithmetic Immediate |

### Memory, Branch, & Control Instructions (12)
| ID | Instruction | Type | Operational Subtype |
|:---:|:---|:---:|:---|
| 19 | LW | Memory | Load Word from Data Memory |
| 20 | SW | Memory | Store Word to Data Memory |
| 21 | BEQ | Branch | Branch if Equal |
| 22 | BNE | Branch | Branch if Not Equal |
| 23 | BLT | Branch | Branch if Less Than (Signed) |
| 24 | BGE | Branch | Branch if Greater Than or Equal |
| 27 | JAL | Jump | Jump and Link |
| 28 | JALR | Jump | Jump and Link Register |
| 29 | LUI | Upper | Load Upper Immediate |
| 30 | AUIPC | Upper | Add Upper Immediate to PC |

---

## Execution & Automation Flow

### 1. Environment Setup
Ensure AMD Xilinx Vivado (v2024.2 recommended) is correctly installed and sourced in your system path environment.

```bash
git clone https://github.com/GYN26K/RV32I-SINGLE-CYCLE-EXTENDED
cd GYN26K/tcl_files
```

### 2. Run the Automated Build
Execute the core automation script in batch mode to generate the complete hardware configuration layout:

```bash
vivado -mode batch -source riscv_singlecycle.tcl
```

This automated script manages:
1. Environment initialization & workspace generation.
2. Sourcing Verilog RTL from `../design_files/`.
3. Applying constraints from `../constraint_files/`.
4. Synthesizing, placing, and routing the core layout.
5. Emitting timing metrics and the raw programming bitstream.

---

## Verification: Fibonacci Sequence Implementation

To validate the micro-architecture, the design executes an iterative hardware loop calculating the Fibonacci sequence: 

$$F(n) = F(n-1) + F(n-2)$$

### Hardware Implementation Details
* **Clock Management:** An internal clock divider scales down the high-frequency crystal oscillator on the Basys 3 board to sub-Hz speeds, making register adjustments human-readable.
* **Hardware Visuals:** Computed matrix elements inside destination registers are decoded dynamically and routed to drive the multiplexed on-board 4-digit Seven Segment Display.

---

## Design Artifacts & Outputs

Key extracted engineering metrics are saved inside the `results/` folder for immediate validation:

```text
results/
├── main_module.bit                      # Final compiled binary ready to flash onto the FPGA
└── main_module_timing_summary_routed.rpt # Confirmed timing closure, setup/hold slacks
```

---

## Limitations

* **Clock Frequency Limitations:** Critical-path propagation delay is constrained by the slowest execution sequence (typically the `LW` data memory lookup loop), limiting the maximum frequency ($F_{max}$).
* **No Pipelining:** Single-cycle instruction execution means internal resource utilization is isolated with an instruction-per-cycle limitation.

---

## Author

* **Yashmith**
* Department of Electronics and Communication Engineering (ECE)
* Indian Institute of Technology (IIT) Bhubaneswar

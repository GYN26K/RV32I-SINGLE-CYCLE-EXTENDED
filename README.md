# RV32I Single Cycle Extended Processor on FPGA

A RISC-V RV32I Single Cycle Extended Processor implemented in Verilog and automated using TCL scripting in AMD Xilinx Vivado.

---

## Features

* **RV32I Core:** Single-cycle implementation of the standard RISC-V 32-bit integer base instruction set architecture.
* **TCL Automation:** Complete Vivado flow from project creation to bitstream generation automated via a single script.
* **FPGA Resource Mapping:** Peripheral support including Seven Segment Display routing.
* **Portable Structure:** Uses relative paths across scripts for seamless execution across different systems.



## Project Structure

```text
RV32I-SINGLE-CYCLE-EXTENDED/
├── source_files/          # Verilog RTL Source Code (.v)
├── constraint_files/      # Physical Constraints & Pin Mapping (.xdc)
├── tcl_files/             # Vivado Automation Scripts (.tcl)
├── results/               # Extracted Timing/Utilization Reports & Screenshots
├── .gitignore             # Git exclusion rules for auto-generated files
└── README.md              # Project Documentation
```
> **Note:** The `build/` directory and volatile Vivado environment logs (`.log`, `.jou`, `.Xil/`) are intentionally omitted from version control tracking via `.gitignore` to maintain a lean repository footprint.



## Instruction Encoding Strategy

The base RISC-V instruction set is mapped into a unique **5-bit instruction identifier** field, eliminating multi-stage opcode/funct3/funct7 decoding architectures for standard hardware deployments.

### R-Type Instructions (10)

Used for register-to-register arithmetic, logic, and directional shift operations.

| ID | Instruction | Operational Subtype |
| --- | --- | --- |
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

Used for operational instructions involving an immediate value operand.

| ID | Instruction | Operational Subtype |
| --- | --- | --- |
| 10 | ADDI | Add Immediate |
| 11 | ANDI | Bitwise AND Immediate |
| 12 | ORI | Bitwise OR Immediate |
| 13 | XORI | Bitwise XOR Immediate |
| 14 | SLTI | Set Less Than Immediate (Signed) |
| 15 | SLTIU | Set Less Than Immediate Unsigned |
| 16 | SLLI | Shift Left Logical Immediate |
| 17 | SRLI | Shift Right Logical Immediate |
| 18 | SRAI | Shift Right Arithmetic Immediate |

### Memory Instructions (2)

Data transfer operations mapping between register ports and RAM spaces.

| ID | Instruction | Operational Subtype |
| --- | --- | --- |
| 19 | LW | Load Word from Address |
| 20 | SW | Store Word to Address |

### Branch Instructions (6)

Conditional program control logic operations evaluating programmatic deviations.

| ID | Instruction | Operational Subtype |
| --- | --- | --- |
| 21 | BEQ | Branch if Equal |
| 22 | BNE | Branch if Not Equal |
| 23 | BLT | Branch if Less Than (Signed) |
| 24 | BGE | Branch if Greater Than or Equal (Signed) |
| 25 | BGEU | Branch if Greater Than or Equal Unsigned |
| 26 | BLTU | Branch if Less Than Unsigned |

### Jump / Upper Instructions (4)

Unconditional jumps and upper-immediate register load configurations.

| ID | Instruction | Operational Subtype |
| --- | --- | --- |
| 27 | JAL | Jump and Link |
| 28 | JALR | Jump and Link Register |
| 29 | LUI | Load Upper Immediate |
| 30 | AUIPC | Add Upper Immediate to PC |

---

## Architectural Block Diagram

The single-cycle design relies on data path orchestration managed through dedicated architectural execution components:

```text
       ┌───────────┐      ┌────────────┐      ┌──────────────┐
  ────►│  Program  ├─────►│Instruction ├─────►│ Instruction  │
       │Counter(PC)│      │   Memory   │      │ Decode Stage │
       └─────▲─────┘      └────────────┘      └──────┬───────┘
             │                                       │
             │            ┌────────────┐             ▼
             │            │  Register  │       ┌───────────┐
             │            │ File (X32) │       │  Control  │
             │            └─────┬──────┘       │   Unit    │
             │                  │              └─────┬─────┘
             │                  ▼                    │
             │            ┌────────────┐             │
             │            │ Arithmetic │◄────────────┘
             │            │ Logic Unit │
             │            └─────┬──────┘
             │                  │
             │                  ▼
             └────────────[Data Memory]

```

* **Program Counter (PC):** Holds and drives the memory boundary pointer of the active instruction cycle, incrementing sequentially or jumping via conditional evaluation.
* **Instruction Memory:** Read-only address fabric driving stored micro-code contents to the decode datapath.
* **Register File:** Fully-dual synchronous port read structure supporting asynchronous single-write configurations for registers `x0` to `x31`.
* **Arithmetic Logic Unit (ALU):** High-speed functional execution array handling basic arithmetic, logical bit-masks, comparison structures, and data bit-shifts.
* **Control Unit:** Combinational decode array generating internal system metrics (`RegWrite`, `ALUSrc`, `MemRead`, `MemWrite`, `MemtoReg`, `Branch`, `Jump`).
* **Data Memory:** Synchronous random access block layout handling storage variables during runtime memory instructions.

---

## Execution Prerequisites

* **Synthesis Toolchain:** AMD Xilinx Vivado Design Suite (Optimized for 2024.2)
* **OS Target Environment:** Red Hat Enterprise Linux (RHEL) / Windows Subsystem for Linux (WSL)
* **FPGA Prototyping Target:** Basys 3 Development Board (Artix-7 XC7A35T-1CPG236C)

---

## Execution & Automation Flow

### 1. Repository Setup

```bash
git clone <repository_link>
cd RV32I-SINGLE-CYCLE-EXTENDED

```

### 2. Vivado Automated Compiling

Navigate to the operational script directory and execute the TCL pipeline configuration file in headless batch execution mode. Ensure your local environment variables have paths configured for active Vivado binaries.

```bash
cd tcl_files
vivado -mode batch -source riscv_singlecycle.tcl

```

---

## Verification: Fibonacci Sequence Implementation

To validate the micro-architecture, the design executes an iterative hardware loop calculating the Fibonacci sequence:

$$F(n) = F(n-1) + F(n-2)$$

### Internal Register Allocations

* `x1`: Current lower term ($F(n-2)$, initialized to `0`)
* `x2`: Current upper term ($F(n-1)$, initialized to `1`)
* `x3`: Destination register ($F(n)$ result)
* `x4`: Operational loop countdown matrix tracker

### Core Code Progression

1. **Initialization:** Load absolute boundary states into immediate storage.
2. **Loop Computation:** Execute `ADD x3, x1, x2` tracking pipeline results.
3. **Data Relocation:** Update states via operational register swap (`x1` $\leftarrow$ `x2`, `x2` $\leftarrow$ `x3`).
4. **Branch Condition:** Loop sequence tracking until counter depletion triggers branch exit bounds.

### Hardware Prototyping Setup

* **Clock Management:** A custom parameterizable digital counter array steps down high-frequency system clocks to sub-Hz execution speeds for human visual analysis.
* **Peripherals:** Computed matrix elements inside destination registers are decoded dynamically to drive the multiplexed on-board 4-digit Seven Segment Display.

---

## Design Artifacts & Outputs

Upon completion of the automation script, output files and metrics are mapped as shown below:

### Bitstream Destination

```text
build/riscv_extended_singlecycle.runs/impl_1/riscv_extended_singlecycle.bit

```

### Static Analysis Archiving

```text
results/
├── timing_report.txt          # Worst Negative Slack (WNS) and setup/hold timing limits
├── utilization_report.txt     # Look-Up Table (LUT), Flip-Flop (FF), and IO Pin assignment tables
├── synthesis_floorplan.png    # Pre-placement design block visualization
└── physical_layout.png       # Extracted post-route physical layout tracking

```

---

## Constraints & System Limitations

* **Clock Frequency Limitations:** Critical-path delay is bound by the slowest execution sequence (typically the `LW` instruction loop), constraining the maximum system operating frequency ($F_{max}$).
* **No Pipelining:** Single-cycle instruction processing means resource exploitation remains isolated, with low instruction throughput compared to modern pipelined architectures.
* **Control Complexity:** Accommodating an extended instruction vocabulary expands the sizing parameters of internal combinational decoding mux structures.

---

## Author

* **Yashmith**
* Department of Electronics and Communication Engineering (ECE)
* Indian Institute of Technology (IIT) Bhubaneswar

```

```

# 32_ALU

# 32-bit ALU Design in SystemVerilog

This repository contains the RTL SystemVerilog code and testbench for a 32-bit Arithmetic Logic Unit (ALU) design. The ALU supports various arithmetic and logical operations including addition, subtraction, multiplication, division, AND, OR, XOR, NOT, NAND, NOR, XNOR, shift left, and shift right.

## File Structure

- `design.sv`: Contains the RTL design of the 32-bit ALU and its submodules.
- `tb_breadboard.sv`: Contains the testbench to verify the functionality of the 32-bit ALU design.

## ALU Operations

The ALU supports the following operations, each identified by a specific opcode:

| Opcode | Operation   | Description                       |
|--------|-------------|-----------------------------------|
| 0x1    | ADD         | Addition                          |
| 0x2    | SUB         | Subtraction                       |
| 0x3    | MUL         | Multiplication                    |
| 0x4    | DIV         | Division                          |
| 0x6    | AND         | Bitwise AND                       |
| 0x7    | OR          | Bitwise OR                        |
| 0x8    | XOR         | Bitwise XOR                       |
| 0x9    | NOT         | Bitwise NOT (on B input)          |
| 0xA    | NAND        | Bitwise NAND                      |
| 0xB    | NOR         | Bitwise NOR                       |
| 0xC    | XNOR        | Bitwise XNOR                      |
| 0xD    | SHL         | Shift Left                        |
| 0xE    | SHR         | Shift Right                       |

## Usage

### Prerequisites

- Xilinx Vivado (or any compatible SystemVerilog simulation tool)

### Steps to Simulate

1. Clone the repository:

```bash
git clone https://github.com/MuddasirAttar/32_ALU.git
cd 32-bit-ALU
```

2. Open Xilinx Vivado (or your preferred simulation tool).

3. Create a new project and add `design.sv` and `tb_breadboard.sv` to the project.

4. Run the simulation to verify the functionality of the 32-bit ALU.

### Testbench

The testbench (`tb_breadboard.sv`) initializes the ALU inputs, applies different opcodes, and checks the output against expected results. If the output does not match the expected result, it displays an error message indicating which test failed.

## Modules

### ALU Submodules

- `AND_gate`
- `OR_gate`
- `XOR_gate`
- `NOT_gate`
- `NAND_gate`
- `NOR_gate`
- `XNOR_gate`
- `ADD_er`
- `SUB_er`
- `MUL_er`
- `DIV_er`
- `SHL_Logic`
- `SHR_Logic`
- `DFF`
- `DFF_register`
- `ERROR_Check`
- `MUX`
- `breadboard` (Top-level module integrating all submodules)

### Top-Level Module

The `breadboard` module is the top-level module that integrates all the submodules and performs the selected operation based on the provided opcode.

## Contributing

If you find any issues or have suggestions for improvements, feel free to create an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.




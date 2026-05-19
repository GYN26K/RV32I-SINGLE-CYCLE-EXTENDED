`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:18:05
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module alu(
    input  [31:0] a,
    input  [31:0] b,
    input  [5:0]  aluctrl,
    output reg [31:0] result,
    output zero
);

    always @(*) begin
        case(aluctrl)

        // R type
        0: result = a + b;// add
        1: result = a - b;// sub
        2: result = a & b;// and
        3: result = a | b;// or
        4: result = a ^ b;// xor
        5: result = a << b[4:0];// sll
        6: result = a >> b[4:0];// srl
        7: result = $signed(a) >>> b[4:0];// sra
        8: result = ($signed(a) < $signed(b)) ? 1 : 0;// slt

        // I type
        10: result = a + b;// addi
        11: result = a & b;// andi
        12: result = a | b;// ori
        13: result = a ^ b;// xori
        14: result = ($signed(a) < $signed(b)) ? 1 : 0;// slti
        15: result = (a < b) ? 1 : 0;// sltiu
        16: result = a << b[4:0];// slli
        17: result = a >> b[4:0];// srli
        18: result = $signed(a) >>> b[4:0];// srai

        19: result = a + b;// lw
        20: result = a + b;// sw

        // B - Type
        21: result = (a == b);// BEQ 
        22: result = (a != b);// BNE
        23: result = ($signed(a) < $signed(b));// BLT
        24: result = ($signed(a) >= $signed(b));// BGE
        25: result = (a >= b);// BGEU
        26: result = (a < b);// BLTU

        // J type
        27: result = a + 4;// jal
        28: result = a + b;// jalr

        // U type
        29: result = b;// lui
        30: result = a + b;// auipc

        default: result = 0;

        endcase
    end

    assign zero = (result == 0);

endmodule
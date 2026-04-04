`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:16:06
// Design Name: 
// Module Name: alu_control
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


module alu_control(

input [2:0] aluop,
input [2:0] funct3,
input [6:0] funct7,

output reg [5:0] aluctrl
);

    always @(*) begin

    case(aluop)

        // load/store
        3'b000: aluctrl = 0;   // ADD

        // branch
        3'b001: begin
            case(funct3)

            3'b000: aluctrl = 21; // beq
            3'b001: aluctrl = 22; // bne
            3'b100: aluctrl = 23; // blt
            3'b101: aluctrl = 24; // bge
            3'b110: aluctrl = 26; // bltu
            3'b111: aluctrl = 25; // bgeu

            endcase
        end

        // R type
        3'b010: begin
            case({funct7,funct3})

            {7'b0000000,3'b000}: aluctrl = 0; // add
            {7'b0100000,3'b000}: aluctrl = 1; // sub
            {7'b0000000,3'b111}: aluctrl = 2; // and
            {7'b0000000,3'b110}: aluctrl = 3; // or
            {7'b0000000,3'b100}: aluctrl = 4; // xor
            {7'b0000000,3'b001}: aluctrl = 5; // sll
            {7'b0000000,3'b101}: aluctrl = 6; // srl
            {7'b0100000,3'b101}: aluctrl = 7; // sra
            {7'b0000000,3'b010}: aluctrl = 8; // slt

            endcase
        end

    // I type
        3'b011: begin
            case(funct3)

            3'b000: aluctrl = 10; // addi
            3'b111: aluctrl = 11; // andi
            3'b110: aluctrl = 12; // ori
            3'b100: aluctrl = 13; // xori
            3'b010: aluctrl = 14; // slti
            3'b011: aluctrl = 15; // sltiu
            3'b001: aluctrl = 16; // slli
            3'b101: begin
                    if(funct7 == 7'b0000000) begin
                        aluctrl = 17; // srli
                    end
                    else begin 
                        aluctrl = 18; // srai
                    end
                end

            endcase
        end

        // JAL/JALR
        3'b100: aluctrl = 27;

        // LUI
        3'b101: aluctrl = 29;

        // AUIPC
        3'b110: aluctrl = 30;

        endcase

    end

endmodule


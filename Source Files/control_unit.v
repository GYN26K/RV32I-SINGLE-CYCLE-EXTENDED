`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:15:50
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [6:0] opcode,

    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg memtoreg,
    output reg alusrc,
    output reg branch,
    output reg jump,
    output reg [2:0] aluop,
    output reg [2:0] imm_sel,
    output reg pcsrc,
    output reg [1:0] resultsrc
);

always @(*) begin

    case(opcode)

        // R TYPE
        7'b0110011: begin
            regwrite = 1;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            alusrc   = 0;
            branch   = 0;
            jump     = 0;
            aluop    = 3'b010;
            imm_sel  = 3'b000;
            pcsrc    = 0;
            resultsrc= 2'b00;
        end

        // I TYPE
        7'b0010011: begin
            regwrite = 1;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            alusrc   = 1;
            branch   = 0;
            jump     = 0;
            aluop    = 3'b011;
            imm_sel  = 3'b000;
            pcsrc    = 0;
            resultsrc= 2'b00;
        end

        // LOAD
        7'b0000011: begin
            regwrite = 1;
            memread  = 1;
            memwrite = 0;
            memtoreg = 1;
            alusrc   = 1;
            branch   = 0;
            jump     = 0;
            aluop    = 3'b000;
            imm_sel  = 3'b000;
            pcsrc    = 0;
            resultsrc= 2'b01;
        end

        // STORE
        7'b0100011: begin
            regwrite = 0;
            memread  = 0;
            memwrite = 1;
            memtoreg = 0;
            alusrc   = 1;
            branch   = 0;
            jump     = 0;
            aluop    = 3'b000;
            imm_sel  = 3'b001;
            pcsrc    = 0;
            resultsrc= 2'b00;
        end

        // BRANCH
        7'b1100011: begin
            regwrite = 0;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            alusrc   = 0;
            branch   = 1;
            jump     = 0;
            aluop    = 3'b001;
            imm_sel  = 3'b010;
            pcsrc    = branch; // actual decision uses zero outside
            resultsrc= 2'b00;
        end

        // JAL
        7'b1101111: begin
            regwrite = 1;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            alusrc   = 0;
            branch   = 0;
            jump     = 1;
            aluop    = 3'b100;
            imm_sel  = 3'b100;
            pcsrc    = 1;
            resultsrc= 2'b10;
        end

        // JALR
        7'b1100111: begin
            regwrite = 1;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            alusrc   = 1;
            branch   = 0;
            jump     = 1;
            aluop    = 3'b100;
            imm_sel  = 3'b000;
            pcsrc    = 1;
            resultsrc= 2'b10;
        end

        // LUI
        7'b0110111: begin
            regwrite = 1;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            alusrc   = 1;
            branch   = 0;
            jump     = 0;
            aluop    = 3'b101;
            imm_sel  = 3'b011;
            pcsrc    = 0;
            resultsrc= 2'b11;
        end

        // AUIPC
        7'b0010111: begin
            regwrite = 1;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            alusrc   = 1;
            branch   = 0;
            jump     = 0;
            aluop    = 3'b110;
            imm_sel  = 3'b011;
            pcsrc    = 0;
            resultsrc= 2'b00;
        end

        default: begin
            regwrite = 0;
            memread  = 0;
            memwrite = 0;
            memtoreg = 0;
            alusrc   = 0;
            branch   = 0;
            jump     = 0;
            aluop    = 0;
            imm_sel  = 3'b000;
            pcsrc    = 0;
            resultsrc= 2'b00;
        end

    endcase

end

endmodule
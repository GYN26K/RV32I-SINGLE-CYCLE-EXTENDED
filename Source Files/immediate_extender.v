`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:26:58
// Design Name: 
// Module Name: immediate_extender
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


module immediate_extender(
    input [24:0] imm,
    input [2:0] imm_sel,
    output reg [31:0] immext
);

    always @(*) begin
        case(imm_sel)

        3'b000: immext = {{20{imm[24]}}, imm[24:13]}; // I-type

        3'b001: immext = {{20{imm[24]}}, imm[24:18], imm[4:0]}; // S-type

        3'b010: immext = {{19{imm[24]}}, imm[24], imm[0], imm[23:18], imm[4:1], 1'b0}; // B-type

        3'b011: immext = {imm[24:5], 12'b0}; // U-type

        3'b100: immext = {{11{imm[24]}}, imm[24], imm[12:5], imm[13], imm[23:14], 1'b0}; // J-type

        default: immext = 32'b0;

        endcase
    end

endmodule
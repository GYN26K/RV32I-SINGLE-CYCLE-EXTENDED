`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 18:25:29
// Design Name: 
// Module Name: instruction_memory
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


module instr_memo(
    input [31:0] pc,
    output reg [31:0] instr
);

    reg [31:0] memory [0:31];

    initial begin
        memory[0] = 32'h00100093; // addi x1,x0,1
        memory[1] = 32'h00000113; // addi x2,x0,0
        memory[2] = 32'h002081B3; // add  x3,x1,x2
        memory[3] = 32'h00008133; // add  x2,x1,x0
        memory[4] = 32'h000180B3; // add  x1,x3,x0
        memory[5] = 32'hFF5FF06F; // jal  x0,loop
    end

    always @(*) instr <= memory[pc[6:2]];

endmodule
    

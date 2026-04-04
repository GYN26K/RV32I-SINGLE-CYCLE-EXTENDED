`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:17:03
// Design Name: 
// Module Name: register_file
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


module reg_file(
    input clk,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] wd,
    input regwrite,
    output [31:0] rd1,
    output [31:0] rd2
);

    reg [31:0] regf [31:0];

    always @(posedge clk) begin
        if(regwrite && rd != 0)
            regf[rd] <= wd;
    end

    assign rd1 = (rs1 != 0) ? regf[rs1] : 32'b0;
    assign rd2 = (rs2 != 0) ? regf[rs2] : 32'b0;

endmodule
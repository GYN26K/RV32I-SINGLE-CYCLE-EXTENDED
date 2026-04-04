`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:30:28
// Design Name: 
// Module Name: mux_for_alu
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


module mux_for_alu(
    input [31:0] rd2 ,
    input [31:0] immext ,
    input alusrc ,
    output [31:0] b
);

    assign b = alusrc ? immext : rd2 ;

endmodule

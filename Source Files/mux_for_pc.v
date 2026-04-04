`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:30:41
// Design Name: 
// Module Name: mux_for_pc
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


module mux_for_pc(
    input pcsrc ,
    input [31:0] pcplus4 ,
    input [31:0] pctarget ,
    output [31:0] pcnext   
);

    assign pcnext = pcsrc ? pctarget : pcplus4 ;

endmodule

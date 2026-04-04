`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:35:20
// Design Name: 
// Module Name: pctarget
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


module pc_target(
    input [31:0] pc ,
    input [31:0] immext ,
    output [31:0] pctarget 
);

    assign pctarget = pc + immext ;

endmodule

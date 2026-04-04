`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:31:03
// Design Name: 
// Module Name: mux_for_result
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


module mux_for_result(
    input [31:0] readdata,
    input [31:0] aluresult,
    input [31:0] pcplus4,
    input [31:0] immext,
    input [1:0] resultsrc,
    output reg [31:0] result
);

    always @(*) begin
        case(resultsrc)

            2'b00: result = aluresult;
            2'b01: result = readdata;
            2'b10: result = pcplus4;
            2'b11: result = immext;
            default: result = 32'b0;
            
        endcase
    end

endmodule

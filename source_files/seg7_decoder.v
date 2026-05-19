`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 23:52:15
// Design Name: 
// Module Name: seg7_decoder
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

module seg7_decoder(
    input [3:0] num,
    output reg [7:0] seg
);

    always @(*) begin
        case(num)
            4'd0 : seg = 8'b00000001;
            4'd1 : seg = 8'b01001111;
            4'd2 : seg = 8'b00010010;
            4'd3 : seg = 8'b00000110;
            4'd4 : seg = 8'b01001100;
            4'd5 : seg = 8'b00100100;
            4'd6 : seg = 8'b00100000;
            4'd7 : seg = 8'b00001111;
            4'd8 : seg = 8'b00000000;
            4'd9 : seg = 8'b00000100;
            default: seg = 8'b11111111;
        endcase
    end

endmodule
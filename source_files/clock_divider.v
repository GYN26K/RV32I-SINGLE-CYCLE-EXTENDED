`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 23:49:27
// Design Name: 
// Module Name: clock_divider
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


module clk_div(
    input clk,
    input rst,
    output reg clk1
);

    reg [26:0] count;

    always @(posedge clk) begin
        if(rst) begin
                count <= 0;
            clk1 <= 0;
        end
        else begin
            if(count == 27'd100000000) begin
                clk1 <= ~clk1;
                count <= 0;
            end
            else
                count <= count + 1;
        end
    end

endmodule


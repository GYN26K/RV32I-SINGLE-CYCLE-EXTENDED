`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 18:20:27
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input clk ,
    input reset ,
    input [31:0] pcnext ,
    output reg [31:0] pc 
    );

    always @(posedge clk) begin
        if(reset) begin
            pc <= 32'b0 ;
        end
        else begin
            pc <= pcnext ;
        end
    end


endmodule

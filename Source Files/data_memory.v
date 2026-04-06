`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:22:40
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input clk ,
    input we , // write or not
    input [31:0] addr ,
    input [31:0] wd , // write data
    output [31:0] rd // read data
);

    reg [31:0] mem [31:0] ;
    
    always@(posedge clk ) begin 
        if(we) begin 
            mem[addr[6:2]] <= wd ;
        end
    end

    assign rd = mem[addr[6:2]];

endmodule


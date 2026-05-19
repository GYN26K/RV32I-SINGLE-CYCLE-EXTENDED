`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 23:50:58
// Design Name: 
// Module Name: main_file
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


`timescale 1ns / 1ps

module main_module(
    input clk,
    input reset,
    output [6:0] seg,
    output [3:0] an
);

    wire slowclk;
    wire [31:0] result;

    wire [3:0] ones;
    wire [3:0] tens;
    wire [3:0] hundreds;
    wire [3:0] thousands;

    clk_div divider(
        .clk(clk),
        .rst(reset),
        .clk1(slowclk)
    );

    top_module top_module(
        .clk(slowclk),
        .reset(reset),
        .result(result)
    );

    bin_to_bcd convert(
        .bin(result),
        .ones(ones),
        .tens(tens),
        .hundreds(hundreds),
        .thousands(thousands)
    );

    display_mux display(
        .clk(clk),
        .d0(ones),
        .d1(tens),
        .d2(hundreds),
        .d3(thousands),
        .an(an),
        .seg(seg)
    );

endmodule

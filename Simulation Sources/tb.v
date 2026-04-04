`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 23:41:43
// Design Name: 
// Module Name: tb
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

module tb_top_module;

    reg clk;
    reg reset;
    wire [31:0] result;

    // Instantiate DUT
    top_module uut (
        .clk(clk),
        .reset(reset),
        .result(result)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        reset = 1;

        // Hold reset for few cycles
        #20;
        reset = 0;

        // Run simulation
        #200;

        // Finish
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time = %0t | reset = %b | result = %h", $time, reset, result);
    end

endmodule

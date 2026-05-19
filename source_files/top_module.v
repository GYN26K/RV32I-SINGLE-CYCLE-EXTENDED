`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:46:42
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk , 
    input reset ,
    output [31:0] result 
);

    wire [31:0] pc ;
    wire [31:0] pcnext ;
    
    
    wire [31:0] instr ;
    wire [2:0] aluop ;
    wire [6:0] opcode ;
    wire [24:0] imm ;
    wire [4:0] rs1 ;
    wire [4:0] rs2 ;
    wire [2:0] funct3 ;
    wire [6:0] funct7 ;
    wire [4:0] rd ;

    wire [5:0] aluctrl ;

    wire regwrite ;
    wire memread ;
    wire memwrite ;
    wire memtoreg ;
    wire alusrc ;
    wire branch ;
    wire jump ;

    wire [2:0] imm_sel ;
    wire pcsrc ;
    wire [1:0] resultsrc ;

    wire [31:0] addr ;
    wire [31:0] wd ;
    wire [31:0] readdata ;
    wire [31:0] immext ;

    wire [31:0] pcplus4 ;
    wire [31:0] pctarget ;
    wire [31:0] rd1 ;
    wire [31:0] rd2 ;
    wire [31:0] aluresult ;
    wire [31:0] b; 
    wire zero ;
    wire dummy ;

    program_counter program_counter(
        .clk(clk) , 
        .reset(reset) , 
        .pcnext(pcnext) , 
        .pc(pc) 
        );

    mux_for_pc mux_for_pc(
        .pcsrc(pcsrc ) ,
        .pcplus4(pcplus4) ,
        .pctarget(pctarget) ,
        .pcnext(pcnext)
    );

    instr_memo instr_memo(
        .pc(pc) , 
        .instr(instr)
    );

    instr_decoder instr_decoder(
        .instr(instr) , 
        .opcode(opcode) , 
        .imm(imm ) , 
        .rs1(rs1) , 
        .funct3(funct3) , 
        .funct7(funct7) , 
        .rd(rd) , 
        .rs2(rs2)
    );

    immediate_extender immediate_extender(
        .imm(imm ) , 
        .imm_sel(imm_sel) , 
        .immext(immext )
        );

    alu_control alu_control(
        .aluop(aluop) , 
        .funct3(funct3) , 
        .funct7(funct7) , 
        .aluctrl(aluctrl)
        );

    alu alu(
        .a(rd1) , 
        .b(b) , 
        .aluctrl(aluctrl) , 
        .result(aluresult) ,
        .zero(zero)
        );

    mux_for_alu mux_for_alu (
        .rd2(rd2) , 
        .immext(immext) , 
        .alusrc(alusrc) , 
        .b(b)
        );

    mux_for_result mux_for_result(
        .readdata(readdata) , 
        .aluresult(aluresult) , 
        .pcplus4(pcplus4) , 
        .immext(immext) , 
        .resultsrc(resultsrc) , 
        .result(result)
        );

    pcadder pcadder(
        .pc(pc) , 
        .pcplus4(pcplus4)
        );

    pc_target pc_target(
        .pc(pc) , 
        .immext(immext) , 
        .pctarget(pctarget)
        );

    control_unit cu (
        .opcode(opcode),
        .regwrite(regwrite),
        .memread(memread),
        .memwrite(memwrite),
        .memtoreg(memtoreg),
        .alusrc(alusrc),
        .branch(branch),
        .jump(jump),
        .aluop(aluop),
        .imm_sel(imm_sel),
        .pcsrc(dummy),
        .resultsrc(resultsrc)
    );

    data_memory dm (
        .clk(clk),
        .we(memwrite),
        .addr(aluresult),
        .wd(writedata),
        .rd(readdata)
    );

    reg_file rf (
        .clk(clk),
       .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(result),
        .regwrite(regwrite),
        .rd1(rd1),
        .rd2(rd2)
    );

    assign pcsrc = (branch & zero) | jump;

endmodule

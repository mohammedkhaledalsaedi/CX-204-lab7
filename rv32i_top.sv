`timescale 1ns / 1ps


module rv32i_top(

input logic clk, reset_n
    );
    
    
    
    logic [31:0]instruction;
//    assign instruction = G2.instruction; //important
    logic [6:0]opcode;
    assign opcode = instruction[6:0];
    logic reg_write, alu_src, mem_write, mem_to_reg, branch;
    logic [3:0]alu_ctrl;
    logic [2:0]func3;
    assign func3 = instruction[14:12];
    logic [6:0]func7;
    assign func7 = instruction[31:25];
    logic [1:0]alu_op;
    
    
    control_unit G1(
        .instruction(instruction),
        .opcode(opcode),
        .func7(func7),
        .func3(func3),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .branch(branch),
        .alu_ctrl(alu_ctrl)
    );
    
    
    data_path G2(
        .clk(clk),
        .reset_n(reset_n),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .alu_ctrl(alu_ctrl),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .func3(func3),
        .instruction(instruction)
    );
    
    
    
    
endmodule

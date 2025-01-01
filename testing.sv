`timescale 1ns / 1ps

module control_unit_tb;

    // Inputs
    logic [6:0] opcode;
    logic func7;
    logic [2:0] func3;

    // Outputs
    logic reg_write;
    logic mem_write;
    logic mem_to_reg;
    logic alu_op;
    logic alu_src;
    logic branch;
    logic [3:0] alu_ctrl;

    // Instantiate the control_unit module
    control_unit uut (
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

    // Test vectors
    initial begin
        $display("Testing Control Unit...");
        // Test Case 1: R-type instruction
        opcode = 7'b0110011; // R-type opcode
        func3 = 3'b000;      // ADD instruction
        func7 = 1'b0;        // Default func7
        #10;
        $display("R-type ADD: reg_write=%b, mem_write=%b, branch=%b, alu_ctrl=%b",
                 reg_write, mem_write, branch, alu_ctrl);

        // Test Case 2: I-type instruction (e.g., ADDI)
        opcode = 7'b0010011; // I-type opcode
        func3 = 3'b000;      // ADDI
        func7 = 1'b0;
        #10;
        $display("I-type ADDI: reg_write=%b, mem_write=%b, branch=%b, alu_ctrl=%b",
                 reg_write, mem_write, branch, alu_ctrl);

        // Test Case 3: Load instruction
        opcode = 7'b0000011; // Load opcode
        func3 = 3'b010;      // LW
        func7 = 1'b0;
        #10;
        $display("Load LW: reg_write=%b, mem_write=%b, mem_to_reg=%b, alu_src=%b",
                 reg_write, mem_write, mem_to_reg, alu_src);

        // Test Case 4: Store instruction
        opcode = 7'b0100011; // Store opcode
        func3 = 3'b010;      // SW
        func7 = 1'b0;
        #10;
        $display("Store SW: reg_write=%b, mem_write=%b, mem_to_reg=%b, alu_src=%b",
                 reg_write, mem_write, mem_to_reg, alu_src);

        // Test Case 5: Branch instruction
        opcode = 7'b1100011; // Branch opcode
        func3 = 3'b000;      // BEQ
        func7 = 1'b0;
        #10;
        $display("Branch BEQ: reg_write=%b, mem_write=%b, branch=%b, alu_ctrl=%b",
                 reg_write, mem_write, branch, alu_ctrl);

        // Finish simulation
        $finish;
    end

endmodule

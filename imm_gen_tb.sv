`timescale 1ns / 1ps

module imm_gen_tb;

logic [31:0] instruction;
logic [31:0] imm;

imm_gen dut (
.instruction(instruction),
.imm(imm)
    );

initial begin

instruction = 32'b000000000001_00001_000_00010_0010011; #10; // addi x2, x1, 1
        
instruction = 32'b111111111111_00001_010_00010_0000011; #10; // lw x2, -1(x1)

instruction = 32'b1111111_00010_00001_010_00010_0100011; #10; // sw x2, -1(x1)

instruction = 32'b1111111_00010_00001_000_00000_1100011; #10; // beq x1, x2, -2
$finish;
end

endmodule

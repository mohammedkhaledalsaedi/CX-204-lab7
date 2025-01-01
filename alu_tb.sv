`timescale 1ns / 1ps


module alu_tb;

logic [3:0] alu_ctrl; // control signal
logic [31:0]op1, op2; //alu inputs
logic [31:0] alu_result;
logic zero;

alu dut (

.alu_ctrl(alu_ctrl),
.op1(op1),
.op2(op2),
.alu_result(alu_result),
.zero(zero)
);


initial begin

//alu_ctrl = 4'b0000; op1 = 3; op2 = 3; #10; //ADD
//alu_ctrl = 4'b1000; op1 = 3; op2 = 4; #10; //SUB
//alu_ctrl = 4'b0001; op1 = 3; op2 = 2; #10; //SLL
//alu_ctrl = 4'b0010; op1 = -3; op2 = 4; #10; //SLT
alu_ctrl = 4'b0011; op1 = -3; op2 = 1; #10; //SLTU
//alu_ctrl = 4'b0100; op1 = 2; op2 = 3; #10; //XOR
//alu_ctrl = 4'b0101; op1 = 'hFFFFFFFE; op2 = 1; #10; //SRL
//alu_ctrl = 4'b1101; op1 = 'hFFFFFFFE; op2 = 'h1; #10; //SRA
//alu_ctrl = 4'b0110; op1 = 1; op2 = 3; #10; //OR
//alu_ctrl = 4'b0111; op1 = 1; op2 = 3; #10; //AND



$finish;
end




endmodule

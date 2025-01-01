`timescale 1ns / 1ps


module data_path_tb;

logic reset_n, clk;
logic reg_write;
logic alu_src;
logic mem_write;
logic [3:0]alu_ctrl;
logic mem_to_reg;
logic branch; 
logic [2:0]func3;



data_path dut (
.clk(clk),
.reset_n(reset_n),
.branch(branch),
.reg_write,
.alu_src,
.mem_write,
.alu_ctrl,
.mem_to_reg,
.func3(func3)
);



initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin

// Load 10 into t0 ( addi t0, x0, 10)
reset_n = 0;

reg_write = 1'b1;
alu_src = 1'b0;
mem_write = 1'b1;
alu_ctrl = 4'b0000;
mem_to_reg = 1'b0;
branch = 1'b0; 
func3 =3'b010; 
#10;

reset_n = 1;

reg_write = 1'b1;
alu_src = 1'b1;
mem_write = 1'b1;
alu_ctrl = 4'b0000;
mem_to_reg = 1'b0;
branch = 1'b0; 
func3 =3'b010;
#10;

// Load 5 into t1 ( addi t1, x0, 5)

reg_write = 1'b1;
#1;
alu_src = 1'b0; 
mem_write = 1'b0;
alu_ctrl = 4'b0000;
mem_to_reg = 1'b0;
branch = 1'b0;
func3 =3'b010;
#10;

// Add t2 = t0 + t1 ( add t2, t1, t0)

reg_write = 1'b1;

alu_src = 1'b0;
mem_write = 1'b0;
alu_ctrl = 4'b0000;
mem_to_reg = 1'b0;
branch = 1'b0; 
func3 =3'b010;
#10;


$finish;
end
endmodule

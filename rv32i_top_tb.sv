`timescale 1ns / 1ps


module rv32i_top_tb;

logic reset_n, clk;
//logic [31:0]instruction;
//logic reg_write;
//logic alu_src;
//logic mem_write;
//logic [3:0]alu_ctrl;
//logic mem_to_reg;
//logic branch; 
//logic [2:0]func3;



rv32i_top dut (
.clk(clk),
.reset_n(reset_n)
//.instruction(instruction)
);



initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin

reset_n = 0; #5;

reset_n = 1; #15;


$finish;
end
endmodule

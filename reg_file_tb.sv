`timescale 1ns / 1ps


module reg_file_tb;

logic reset_n, clk, reg_write;
logic [4:0]raddr1, raddr2, waddr;
logic [31:0]rdata1, rdata2;
logic [31:0]wdata;


reg_file dut (

.clk(clk),
.reset_n(reset_n),
.reg_write(reg_write),
.raddr1(raddr1),
.raddr2(raddr2),
.waddr(waddr),
.wdata(wdata),
.rdata1(rdata1),
.rdata2(rdata2)

);

initial begin 
clk = 0;
forever #1 clk = ~clk;
end

initial begin
reset_n = 0; reg_write = 1; raddr1 = 'b00000; raddr2 = 'b00000; waddr = 'b10011; wdata = 'h00000000; #10; //Reset



reset_n = 1; reg_write = 1; raddr1 = 'b00000; raddr2 = 'b00000; waddr = 'b10101; wdata = 'h0F0F0F0F; #50; // Register 21 should have 0F0F0F0F 
reset_n = 1; reg_write = 1; raddr1 = 'b10101; raddr2 = 'b00000; waddr = 'b00000; wdata = 'h222222FF; #50; // Register 0 should stay always ZERO
reset_n = 1; reg_write = 0; raddr1 = 'b10101; raddr2 = 'b00000; waddr = 'b00001; wdata = 'h222222FF; #50; // Reading phase not Writing!!
reset_n = 1; reg_write = 1; raddr1 = 'b10101; raddr2 = 'b00000; waddr = 'b00001; wdata = 'h222222FF; #50; // Now its Writing

$finish;
end
endmodule

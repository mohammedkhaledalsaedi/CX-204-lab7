`timescale 1ns / 1ps


module data_mem_tb;
logic reset_n, mem_write, clk;
logic [31:0]addr, wdata;

logic [2:0]func3;

logic [31:0]rdata;





data_mem dut (

.clk(clk),
.reset_n(reset_n),
.mem_write(mem_write),
.addr(addr),
.wdata(wdata),
.rdata(rdata),
.func3(func3)

);



initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin

reset_n = 0; mem_write = 1; addr = 'h00000004; wdata = 'hFF00FF00; func3 = 'b10; #10;
reset_n = 1; mem_write = 1; addr = 'h00000008; wdata = 'hFFFFFFFF; func3 = 'b10; #10;
reset_n = 1; mem_write = 1; addr = 'h0000000c; wdata = 'hAAAAAAAA; func3 = 'b10; #10;
reset_n = 1; mem_write = 1; addr = 'h00000010; wdata = 'hBBBBBBBB; func3 = 'b10; #10;

reset_n = 1; mem_write = 1; addr = 'h00000014; wdata = 'hABCDEDEF; func3 = 'b00; #10;
reset_n = 1; mem_write = 1; addr = 'h00000018; wdata = 'hABCDEDEF; func3 = 'b01; #10;




$finish;
end
endmodule
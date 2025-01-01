`timescale 1ns / 1ps


module inst_mem_tb;

logic [31:0]address, instruction;

inst_mem dut(
.address(address),
.instruction(instruction)
);

initial begin
    
    address = 'h00000000; #10;
    address = 'h00000001; #10;
    address = 'h0000000A; #10;
    
    address = 'h1000000A; #10;


end
endmodule

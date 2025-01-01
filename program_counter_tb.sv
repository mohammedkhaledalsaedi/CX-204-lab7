`timescale 1ns / 1ps


module program_counter_tb;
localparam n = 32;

logic reset_n, clk;
logic [31:0]data_in, data_o;

program_counter #(.n(n)) dut (

.clk(clk),
.reset_n(reset_n),
.data_in(data_in),
.data_o(data_o)
);

initial begin
clk = 0;
forever #1 clk = ~ clk;
end

initial begin

reset_n = 0; data_in = 4; #2;
reset_n = 1; data_in = 8; #10;
reset_n = 1; data_in = 12; #10;

$finish;
end

endmodule

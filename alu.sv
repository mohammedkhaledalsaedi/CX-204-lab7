`timescale 1ns / 1ps

module alu (
    input logic [31:0] op1, op2,
    input logic [3:0] alu_ctrl , //selector 
    output logic [31:0] alu_result,
    output logic zero
    );

always_comb begin
    case (alu_ctrl)
        4'b0000 : alu_result = op1 + op2;
        4'b1000 : alu_result = op1 - op2;
        4'b0001 : alu_result = op1 << op2;
        4'b0010 : alu_result = $signed(op1) < $signed(op2);
        4'b0011 : alu_result = $unsigned(op1) < $unsigned(op2);
        4'b0100 : alu_result = op1 ^ op2;
        4'b0101 : alu_result = op1 >> op2;
        4'b1101 : alu_result = $signed(op1) >>> $signed(op2);
        4'b0110 : alu_result = op1 | op2;
        4'b0111 : alu_result = op1 & op2;
        
        default : alu_result = 0;
    endcase
end



//zero flag

always_comb begin
    zero = 0;
    if (alu_result == 0) zero = 1;
    else zero = 0;

end


//assign zero = ~(|alu_result);



endmodule

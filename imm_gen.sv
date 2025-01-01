`timescale 1ns / 1ps


module imm_gen(

input logic [31:0]instruction,
output logic [31:0]imm

    );
    
    logic [6:0]opcode;
    
    assign opcode = instruction[6:0];
    
    always_comb begin 
        case (opcode)
        7'b0010011 : imm = { {20{instruction[31]}}, instruction[31:20]}; //concatination for selection and
        7'b0000011 : imm = { {20{instruction[31]}}, instruction[31:20]}; //sign extend the last bit 20 times
        7'b0100011 : imm = { {20{instruction[31]}}, instruction[31:25] , instruction[11:7]};
        7'b1100011 : imm = { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        
        default: imm = 32'b0;
        endcase
    end
    
    
endmodule

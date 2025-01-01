`timescale 1ns / 1ps


module alu_control(
input logic [31:0]instruction,
input logic [2:0]func3,
input logic [6:0]func7,
input logic [1:0]alu_op,
output logic [3:0]alu_ctrl
    );
    
//    logic [2:0]func3;
//    logic [6:0]func7;
//    logic [31:0]instruction;
//    assign func3 = instruction[14:12];
//    assign func7 = instruction[31:25];
    
    always_comb begin
        case (alu_op)
            //Load & Store
            2'b00: begin
                alu_ctrl = 4'b0000;  
            end
            //beq
            2'b01: begin
                alu_ctrl = 4'b1000;  
            end
            //R-type
            2'b10: begin
                alu_ctrl = {func7[5],func3};
             end
             //I-type
             2'b11: begin
                    alu_ctrl = {1'b0,func3[2:0]};
             end   
               default: alu_ctrl = 4'b0000;       
        endcase
    end   
endmodule

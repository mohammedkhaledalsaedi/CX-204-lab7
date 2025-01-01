`timescale 1ns / 1ps


module main_control(
input logic [31:0]instruction, //input??
input logic [6:0]opcode,
output logic branch, mem_write, mem_to_reg, alu_src,
output logic [1:0]alu_op,
output logic reg_write
    );
    
//    logic [31:0]instruction;
//    assign opcode = instruction[6:0];
    
    always_comb begin
    case (opcode)
        7'b0110011 : begin      //R-type 
            reg_write = 1;
            mem_write = 0;
            mem_to_reg = 0;
            alu_op = 2'b10;
            alu_src = 0;
            branch = 0;
        end
        
        
        7'b0010011 : begin      //I-type (immediate)
            reg_write = 1;
            mem_write = 0;
            mem_to_reg = 0;
            alu_op = 2'b11;
            alu_src = 1;
            branch = 0;
        end
        
        
        
        7'b0000011 : begin       //load
            reg_write = 1;
            mem_write = 0;
            mem_to_reg = 1;
            alu_op = 2'b00;
            alu_src = 1;
            branch = 0;
        end
        
        
        7'b0100011 : begin      //store
            reg_write = 0;
            mem_write = 1;
            mem_to_reg = 1;
            alu_op = 2'b00;
            alu_src = 1;
            branch = 0;
        end
        
        
        
        7'b1100011 : begin      //beq
            reg_write = 0;
            mem_write = 0;
            mem_to_reg = 1;
            alu_op = 2'b01;
            alu_src = 0;
            branch = 1;
        end
        
        default : begin        //default
            reg_write = 0;
            mem_write = 0;
            mem_to_reg = 0;
            alu_op = 2'b00;
            alu_src = 0;
            branch = 0;
        end
    endcase
    end
    
    
endmodule

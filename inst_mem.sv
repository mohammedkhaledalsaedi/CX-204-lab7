`timescale 1ns / 1ps


module inst_mem(
input logic [31:0]address,
output logic [31:0]instruction
    );
    
    
    logic [31:0]memory[0:255];
    
    initial $readmemh("/home/it/Downloads/ISA/CX-204-Lab6/Mohammed_Alsaedi/rtl/machine.hex",memory);
    
    always_comb begin
        
        instruction = memory[address>>2];
        
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    //another method:
    
//    assign instruction = memory[address];

    
endmodule

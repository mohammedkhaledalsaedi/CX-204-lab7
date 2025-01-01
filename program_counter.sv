`timescale 1ns / 1ps


module program_counter (
    input logic [31:0]data_in,
    input logic clk,
    input logic reset_n,
    output logic [31:0]data_o
    );
    
    
    
    
always_ff @ (posedge clk, negedge reset_n)
    begin        
        if (reset_n == 0) data_o <= 0;
        else data_o <= data_in;
    end
    
endmodule

`timescale 1ns / 1ps


module data_path(
input logic clk, reset_n,
input logic reg_write,
input logic alu_src,
input logic mem_write,
input logic [3:0]alu_ctrl,
input logic mem_to_reg,
input logic branch,
input logic [2:0]func3,
output logic [31:0]instruction
    );
    
    
    logic [31:0]next_pc;
    logic [31:0]current_pc; 
    logic [31:0]pc_plus_4;  
    logic memtoreg;  
//    logic [31:0]instruction;  

    logic [4:0]rs1, rs2, rd;
    
    reg [31:0]reg_rdata1;
    reg [31:0]reg_rdata2;
    logic [31:0]reg_wdata;
    logic [31:0]imm; 
    logic [31:0]pc_jump;    
    
     logic pc_sel;
     logic zero;
//     logic branch = 0; 
    


    logic [31:0]alu_result;
    
    logic [31:0]alu_op2;


    
    

    logic [31:0]mem_rdata;  
    
    
    assign func3 = instruction[14:12]; 
    
    
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];
        

    
    assign pc_jump = current_pc + imm; // alu/adder

     
     assign pc_sel = branch & zero;
//assign pc_sel = 0;
//     assign next_pc = (pc_sel == 0) ? pc_plus_4 : pc_jump;
      assign next_pc = pc_sel ? pc_jump : pc_plus_4;
    
    assign alu_op2 = alu_src ? imm : reg_rdata2;  //<------ MUX
    

    
    
    assign reg_wdata = mem_to_reg ? mem_rdata : alu_result;
    

    
    assign pc_plus_4 = current_pc + 32'h4;
    
    
    
    program_counter PC (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(next_pc),
        .data_o(current_pc)
    );
    
    
//////////////////////////////////////////////// 


    
    inst_mem ROM(
        .address(current_pc),
        .instruction(instruction)
    );
    
    
//////////////////////////////////////////////// 

    
 
    
    reg_file Register (
        .clk(clk),
        .reset_n(reset_n),
        .reg_write(reg_write),
        .raddr1(rs1),
        .raddr2(rs2),
        .waddr(rd),
        .wdata(reg_wdata),
        .rdata1(reg_rdata1),
        .rdata2(reg_rdata2)
    );
    
////////////////////////////////////////////////
    
    
    

    
    imm_gen IMM_Generator (
        .instruction(instruction),
        .imm(imm)
    
    );
    
    
    
  
    
    
//////////////////////////////////////////////// 

  
    
    
    alu ALU(
        .alu_ctrl(alu_ctrl),
        .op1(reg_rdata1),
        .op2(alu_op2),
        .alu_result(alu_result),
        .zero(zero)
    );
    
////////////////////////////////////////////////




    
    data_mem RAM (
        .clk(clk),
        .reset_n(reset_n),
        .mem_write(mem_write),
        .addr(alu_result),
        .wdata(reg_rdata2),
        .rdata(mem_rdata),
        .func3(func3) //to control Byte, Half-word and word
    
    );
    

    
    
    
endmodule

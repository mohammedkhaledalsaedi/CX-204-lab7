`timescale 1ns / 1ps


module data_mem(

input logic clk, reset_n, mem_write,
input logic [31:0]addr, //full address         NOTE: [31:2] is the addresses of words only!!
input logic [31:0]wdata, //write data (e.g., storing from Registers to memory)

input logic [2:0]func3,

output logic [31:0]rdata //read data
    );
    
    
    logic [31:0]dmem[0:1023]; // it needs adjustments for the flexibility of selecting bytes halfs or words
                              // in the following:
    
    always_comb begin
        case (func3[2:0])
        3'b000 : case (addr[1:0])
            'b00 : rdata = {{24{dmem[addr[31:2]][7]}}, dmem[addr[31:2]][7:0]}; //first byte of nth word location 
            'b01 : rdata = {{24{dmem[addr[31:2]][15]}}, dmem[addr[31:2]][15:8]}; //second byte of nth word location 
            'b10 : rdata = {{24{dmem[addr[31:2]][23]}}, dmem[addr[31:2]][23:16]}; //third byte of nth word location 
            'b11 : rdata = {{24{dmem[addr[31:2]][31]}}, dmem[addr[31:2]][31:24]}; //fourth byte of nth word location 
        endcase
        
        3'b001 : case (addr[1])
            'b0 : rdata = {{16{dmem[addr[31:2]][15]}}, dmem[addr[31:2]][15:0]}; //first half (hw) of nth word location 
            'b1 : rdata = {{16{dmem[addr[31:2]][31]}}, dmem[addr[31:2]][31:16]}; //second half (hw) of nth word location 
        endcase
        
        3'b010 : rdata = dmem[addr[31:2]]; //word addressable
     // -----------------------------------------------------------------------------
        3'b100 : case (addr[1:0]) // ---------- LBU
            'b00 : rdata = {24'b0, dmem[addr[31:2]][7:0]}; //first byte of nth word location 
            'b01 : rdata = {24'b0, dmem[addr[31:2]][15:8]}; //second byte of nth word location 
            'b10 : rdata = {24'b0, dmem[addr[31:2]][23:16]}; //third byte of nth word location 
            'b11 : rdata = {24'b0, dmem[addr[31:2]][31:24]}; //fourth byte of nth word location 
        endcase
        
        3'b101 : case (addr[1]) // ---------- LHU
            'b0 : rdata = {16'b0, dmem[addr[31:2]][15:0]}; //first half (hw) of nth word location 
            'b1 : rdata = {16'b0, dmem[addr[31:2]][31:16]}; //second half (hw) of nth word location 
        endcase
        
        default: rdata = 32'b0;
        
        endcase
    end
    
    
    
    always_ff @ (posedge clk, negedge reset_n) begin
        
        if (reset_n == 0) 
         dmem <= '{default: 32'b0};

        else if(mem_write) begin
        
        case (func3[1:0])
        'b00 : case (addr[1:0])
            'b00 : dmem[addr[31:2]] [7:0] <= wdata[7:0];
            'b01 : dmem[addr[31:2]] [15:8] <= wdata[7:0];
            'b10 : dmem[addr[31:2]] [23:16] <= wdata[7:0];
            'b11 : dmem[addr[31:2]] [31:24] <= wdata[7:0];
            endcase
        
        'b01 : case (addr[1])
            'b0 : dmem[addr[31:2]] [15:0] <= wdata[15:0];
            'b1 : dmem[addr[31:2]] [31:16] <= wdata[15:0];
            endcase
        
        'b10 : dmem[addr[31:2]] [31:0] <= wdata; //wdata in default is wdata[31:0]
        
        endcase
        
//        case (func3[2:0])
//        'b100 : case (addr[1:0])
//            'b00 : dmem[addr[31:2]] [7:0] <= wdata[7:0];
//            'b01 : dmem[addr[31:2]] [15:8] <= wdata[7:0];
//            'b10 : dmem[addr[31:2]] [23:16] <= wdata[7:0];
//            'b11 : dmem[addr[31:2]] [31:24] <= wdata[7:0];
//            endcase
        
//        'b101 : case (addr[1])
//            'b0 : dmem[addr[31:2]] [15:0] <= wdata[15:0];
//            'b1 : dmem[addr[31:2]] [31:16] <= wdata[15:0];
//            endcase
        
//        'b110 : dmem[addr[31:2]] [31:0] <= wdata; //wdata in default is wdata[31:0]
        
//        endcase
        
        end
    
    
    
    
    end
    
    
    
    
    

endmodule

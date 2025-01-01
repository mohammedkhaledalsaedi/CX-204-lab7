`timescale 1ns / 1ps

module reg_file(
    input logic clk, reset_n, reg_write,
    input logic [4:0] raddr1, raddr2, waddr, // Considered as pointers to point to addresses
    input logic [31:0] wdata,
    output logic [31:0] rdata1, rdata2
);
    // 32x32-bit register file
    logic [31:0] file [31:0];

    // Read operations
    assign rdata1 = (raddr1 == 5'b00000) ? '0 : file[raddr1];
    assign rdata2 = (raddr2 == 5'b00000) ? '0 : file[raddr2];

    // Always block for reset and write operations
    always_ff @ (posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // Reset all registers to 0 using array assignment
            file <= '{default: '0};
        end else if (reg_write && waddr != 5'b00000) begin
            // Write operation (ignoring waddr = 0)
            file[waddr] <= wdata;
        end
    end
endmodule

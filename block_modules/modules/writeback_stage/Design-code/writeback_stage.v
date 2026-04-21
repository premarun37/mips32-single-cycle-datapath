`timescale 1ns / 1ps

module writeback_stage (
    input         clk,
    input         regwrite,     // Enables register write
    input         memtoreg,     // Select ALU or memory
    input  [4:0]  writereg,     // Destination register
    input  [31:0] alu_result,
    input  [31:0] mem_data,
    output [31:0] writeback_data
);

    // Write-back MUX
    assign writeback_data = memtoreg ? mem_data : alu_result;

    // Register file (write only shown here)
    reg [31:0] regfile [0:31];

    always @(posedge clk) begin
        if (regwrite && writereg != 0)
            regfile[writereg] <= writeback_data;
    end
endmodule

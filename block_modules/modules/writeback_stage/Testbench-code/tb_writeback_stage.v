`timescale 1ns / 1ps

module tb_writeback_stage;

    reg clk;
    reg regwrite;
    reg memtoreg;
    reg [4:0] writereg;
    reg [31:0] alu_result;
    reg [31:0] mem_data;

    wire [31:0] writeback_data;

    // Clock generation
    always #5 clk = ~clk;
    writeback_stage uut (
        .clk(clk),
        .regwrite(regwrite),
        .memtoreg(memtoreg),
        .writereg(writereg),
        .alu_result(alu_result),
        .mem_data(mem_data),
        .writeback_data(writeback_data)
    );
    initial begin
        clk = 0;
        regwrite = 0;
        memtoreg = 0;
        writereg = 0;
        alu_result = 0;
        mem_data = 0;
        // --------------------------------
        // Case 1: ALU result write (add)
        // --------------------------------
        #10;
        regwrite   = 1;
        memtoreg   = 0;
        writereg   = 5'd8;      // $t0
        alu_result = 32'd25;
        #10;
        regwrite = 0;
        // --------------------------------
        // Case 2: Memory data write (lw)
        // --------------------------------
        #10;
        regwrite = 1;
        memtoreg = 1;
        writereg = 5'd9;        // $t1
        mem_data = 32'd100
        #10;
        regwrite = 0;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | RegWrite=%b MemtoReg=%b | WriteReg=%d | WriteBack=%d",
                 $time, regwrite, memtoreg, writereg, writeback_data);
    end

endmodule

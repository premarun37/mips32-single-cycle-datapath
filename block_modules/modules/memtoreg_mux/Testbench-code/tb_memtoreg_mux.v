`timescale 1ns / 1ps

module tb_memtoreg_mux;

    reg  [31:0] alu_result;
    reg  [31:0] mem_data;
    reg         memtoreg;
    wire [31:0] writeback_data;

    // Instantiate DUT
    memtoreg_mux uut (
        .alu_result(alu_result),
        .mem_data(mem_data),
        .memtoreg(memtoreg),
        .writeback_data(writeback_data)
    );

    initial begin
        $display("Time | MemtoReg | ALU_Result | Mem_Data | WriteBack");
        $monitor("%4t |    %b     |   %d      |   %d     |   %d",
                 $time, memtoreg, alu_result, mem_data, writeback_data);

        // Case 1: Write ALU result (add, addi)
        alu_result = 32'd50;
        mem_data   = 32'd100;
        memtoreg   = 1'b0;
        #10;

        // Case 2: Write memory data (lw)
        memtoreg   = 1'b1;
        #10;

        // Case 3: Change values, ALU writeback
        alu_result = 32'd200;
        mem_data   = 32'd300;
        memtoreg   = 1'b0;
        #10;

        // Case 4: Memory writeback
        memtoreg   = 1'b1;
        #10;

        $finish;
    end

endmodule

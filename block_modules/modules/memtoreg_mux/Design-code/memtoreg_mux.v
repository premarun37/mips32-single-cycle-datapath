`timescale 1ns / 1ps

module memtoreg_mux(
        input [31:0] alu_result,mem_data,
        input memtoreg,
        output [31:0] writeback_data       
    );
    assign writeback_data = (memtoreg) ? mem_data : alu_result ;
endmodule

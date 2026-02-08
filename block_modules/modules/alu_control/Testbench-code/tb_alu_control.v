`timescale 1ns / 1ps

module tb_alu_control;

    reg  [1:0] aluop;
    reg  [5:0] funct;
    wire [3:0] alu_ctrl;

    alu_control uut (
        .aluop(aluop),
        .funct(funct),
        .alu_ctrl(alu_ctrl)
    );

    initial begin
        // lw/sw
        aluop = 2'b00; funct = 6'bxxxxxx; #10;

        // beq
        aluop = 2'b01; funct = 6'bxxxxxx; #10;

        // R-type ADD
        aluop = 2'b10; funct = 6'b100000; #10;

        // R-type SUB
        aluop = 2'b10; funct = 6'b100010; #10;

        // R-type AND
        aluop = 2'b10; funct = 6'b100100; #10;

        // R-type OR
        aluop = 2'b10; funct = 6'b100101; #10;

        // R-type SLT
        aluop = 2'b10; funct = 6'b101010; #10;

        $finish;
    end

endmodule

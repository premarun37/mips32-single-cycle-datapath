`timescale 1ns / 1ps

module tb_alu;

    reg  [31:0] a, b;
    reg  [3:0]  alu_ctrl;
    wire [31:0] result;
    wire        zero;

    alu uut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );

    initial begin
        // ADD
        a = 10; b = 20; alu_ctrl = 4'b0010; #10;

        // SUB
        a = 20; b = 20; alu_ctrl = 4'b0110; #10;

        // AND
        a = 32'hF0F0; b = 32'h0FF0; alu_ctrl = 4'b0000; #10;

        // OR
        a = 32'hF0F0; b = 32'h0FF0; alu_ctrl = 4'b0001; #10;

        // SLT
        a = -5; b = 10; alu_ctrl = 4'b0111; #10;

        $finish;
    end

endmodule

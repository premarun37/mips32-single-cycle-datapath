`timescale 1ns / 1ps

module tb_regdst_mux;

    reg [4:0] rt, rd;
    reg regdst;
    wire [4:0] writereg;

    regdst_mux uut (
        .rt(rt),
        .rd(rd),
        .regdst(regdst),
        .writereg(writereg)
    );

    initial begin
        rt = 5'd9;
        rd = 5'd8;

        regdst = 0; #10;  // lw/addi → rt
        regdst = 1; #10;  // R-type → rd

        $finish;
    end

endmodule

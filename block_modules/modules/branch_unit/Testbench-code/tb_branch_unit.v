`timescale 1ns / 1ps

module tb_branch_unit;

    reg branch, zero;
    wire pcsrc;   // Correct name

    branch_unit uut (
        .branch(branch),
        .zero(zero),
        .pcsrc(pcsrc)
    );

    initial begin
        $display("Time | Branch Zero | PCSrc");
        $monitor("%4t |   %b      %b   |   %b",$time, branch, zero, pcsrc);

        branch = 0; zero = 0; #10;
        branch = 0; zero = 1; #10;
        branch = 1; zero = 0; #10;
        branch = 1; zero = 1; #10;

        $finish;
    end

endmodule

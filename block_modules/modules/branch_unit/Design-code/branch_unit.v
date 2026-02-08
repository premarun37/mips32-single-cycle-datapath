`timescale 1ns / 1ps

module branch_unit(
        input branch,zero,
        output pcsrc
    );
    assign pcsrc = branch & zero;
endmodule

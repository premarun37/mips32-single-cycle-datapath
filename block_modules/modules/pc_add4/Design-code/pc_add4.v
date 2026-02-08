`timescale 1ns / 1ps

module pc_add4(
        input [31:0] pc,
        output [31:0] pc_plus
    );
    assign pc_plus=pc+4;
endmodule

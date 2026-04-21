`timescale 1ns / 1ps

module pcsrc_mux(
        input [31:0] pc_plus4,
        input [31:0] branch_target,
        input pcsrc,
        output [31:0] pc_next
    );
    assign pc_next=pcsrc? branch_target : pc_plus4;
endmodule

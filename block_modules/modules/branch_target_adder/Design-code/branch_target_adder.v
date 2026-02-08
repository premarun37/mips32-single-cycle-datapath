`timescale 1ns / 1ps

module branch_target_adder(
        input [31:0] pc_plus4,
        input [31:0] sign_ext_imm,
        output [31:0] branch_target
    );
    assign branch_target= pc_plus4 + (sign_ext_imm << 2);
endmodule

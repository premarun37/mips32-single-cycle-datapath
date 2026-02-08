`timescale 1ns / 1ps

module tb_branch_target_adder();

    reg  [31:0] pc_plus4;
    reg  [31:0] sign_ext_imm;
    wire [31:0] branch_target;

    // Instantiate DUT
    branch_target_adder uut (
        .pc_plus4(pc_plus4),
        .sign_ext_imm(sign_ext_imm),
        .branch_target(branch_target)
    );

    initial begin
        // Case 1: Positive offset
        pc_plus4     = 32'h0000_0004;
        sign_ext_imm = 32'd1;        // 1 << 2 = 4
        #10;

        // Case 2: Larger positive offset
        pc_plus4     = 32'h0000_0010;
        sign_ext_imm = 32'd4;        // 4 << 2 = 16
        #10;

        // Case 3: Zero offset (branch to PC+4)
        pc_plus4     = 32'h0000_0020;
        sign_ext_imm = 32'd0;
        #10;

        // Case 4: Negative offset (branch backward)
        pc_plus4     = 32'h0000_0020;
        sign_ext_imm = -32'd2;       // -2 << 2 = -8
        #10;

        // Case 5: Overflow case
        pc_plus4     = 32'hFFFF_FFFC;
        sign_ext_imm = 32'd1;        // wraps around
        #10;

        $finish;
    end

endmodule


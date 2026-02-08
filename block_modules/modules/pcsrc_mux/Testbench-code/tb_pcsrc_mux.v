`timescale 1ns / 1ps

module tb_pcsrc_mux;

    reg  [31:0] pc_plus4;
    reg  [31:0] branch_target;
    reg         pcsrc;
    wire [31:0] pc_next;

    pcsrc_mux uut (
        .pc_plus4(pc_plus4),
        .branch_target(branch_target),
        .pcsrc(pcsrc),
        .pc_next(pc_next)
    );

    initial begin
        // Case 1: PCSrc = 0 → PC+4
        pc_plus4      = 32'h0000_0004;
        branch_target = 32'h0000_0040;
        pcsrc         = 1'b0;
        #10;

        // Case 2: PCSrc = 1 → Branch target
        pcsrc = 1'b1;
        #10;

        // Case 3: Change inputs, PCSrc = 0
        pc_plus4      = 32'h0000_0010;
        branch_target = 32'h0000_0080;
        pcsrc         = 1'b0;
        #10;

        // Case 4: PCSrc = 1
        pcsrc = 1'b1;
        #10;

        $finish;
    end

endmodule

`timescale 1ns / 1ps

module tb_control_unit;

    reg  [5:0] opcode;
    wire regwrite, regdst, alusrc, branch;
    wire memread, memwrite, memtoreg;
    wire [1:0] aluop;

    control_unit uut (
        .opcode(opcode),
        .regwrite(regwrite),
        .regdst(regdst),
        .alusrc(alusrc),
        .branch(branch),
        .memread(memread),
        .memwrite(memwrite),
        .memtoreg(memtoreg),
        .aluop(aluop)
    );

    initial begin
        $monitor("Opcode=%b | RW=%b RDst=%b ALUSrc=%b Branch=%b MR=%b MW=%b M2R=%b ALUOp=%b",
                  opcode, regwrite, regdst, alusrc, branch,
                  memread, memwrite, memtoreg, aluop);

        opcode = 6'b000000; #10; // R-type
        opcode = 6'b100011; #10; // lw
        opcode = 6'b101011; #10; // sw
        opcode = 6'b000100; #10; // beq
        opcode = 6'b001000; #10; // addi

        $finish;
    end

endmodule

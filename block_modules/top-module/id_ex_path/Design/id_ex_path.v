`timescale 1ns / 1ps

module id_ex_datapath (
    input         clk,
    input         regwrite,
    input         alusrc,
    input  [4:0]  rs,
    input  [4:0]  rt,
    input  [4:0]  rd,
    input  [15:0] imm,
    input  [31:0] writedata,

    output [31:0] alu_in1,
    output [31:0] alu_in2
);

    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] imm_ext;

    // Register File
    register_file RF (
        .clk(clk),
        .regwrite(regwrite),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .writedata(writedata),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Sign Extend
    sign_extend SE (
        .imm_in(imm),
        .imm_out(imm_ext)
    );

    // ALUSrc MUX
    alusrc_mux ASM (
        .reg_data2(read_data2),
        .imm_ext(imm_ext),
        .alusrc(alusrc),
        .alu_in2(alu_in2)
    );

    // ALU input 1 is always rs value
    assign alu_in1 = read_data1;

endmodule

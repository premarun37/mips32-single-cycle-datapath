`timescale 1ns /1ps

module mips_single_cycle(
    input  clk,
    input  rst,

    // REQUIRED outputs (prevents logic removal)
    output [31:0] pc_out,
    output [31:0] instruction_out,
    output [31:0] alu_result_out
);

    // ========== WIRE DECLARATIONS ==========
    
    // PC-related signals
    wire [31:0] pc;
    wire [31:0] pc_plus4;
    wire [31:0] pc_next;
    
    // Instruction and its fields
    wire [31:0] instruction;
    wire [5:0] opcode;
    wire [4:0] rs, rt, rd;
    wire [5:0] funct;
    wire [15:0] imm;
    
    // Control signals
    wire regwrite, regdst, alusrc, branch;
    wire memread, memwrite, memtoreg;
    wire [1:0] aluop;
    wire [3:0] alu_ctrl;
    
    // Register file signals
    wire [4:0] writereg;
    wire [31:0] read_data1, read_data2;
    wire [31:0] writeback_data;
    
    // ALU signals
    wire [31:0] imm_ext;
    wire [31:0] alu_in2;
    wire [31:0] alu_result;
    wire zero;
    
    // Branch signals
    wire [31:0] branch_target;
    wire pcsrc;
    
    // Memory signals
    wire [31:0] mem_readdata;
    
    // ========== INSTRUCTION FIELD EXTRACTION ==========
    assign opcode = instruction[31:26];
    assign rs     = instruction[25:21];
    assign rt     = instruction[20:16];
    assign rd     = instruction[15:11];
    assign funct  = instruction[5:0];
    assign imm    = instruction[15:0];
    
    // ========== FETCH STAGE ==========
    
    pc PC (
        .clk(clk),
        .rst(rst),
        .pc_nxt(pc_next),
        .pc(pc)
    );
    
    pc_add4 PC_ADD4 (
        .pc(pc),
        .pc_plus(pc_plus4)
    );
    
    instruction_memory IMEM (
        .pc(pc),
        .instruction(instruction)
    );
    
    // ========== DECODE STAGE ==========
    
    control_unit CONTROL (
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
    
    regdst_mux REGDST_MUX (
        .rt(rt),
        .rd(rd),
        .regdst(regdst),
        .writereg(writereg)
    );
    
    register_file REGFILE (
        .clk(clk),
        .regwrite(regwrite),
        .rs(rs),
        .rt(rt),
        .rd(writereg),
        .writedata(writeback_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    sign_extend SIGN_EXT (
        .imm_in(imm),
        .imm_out(imm_ext)
    );
    
    // ========== EXECUTE STAGE ==========
    
    alusrc_mux ALUSRC_MUX (
        .reg_data2(read_data2),
        .imm_ext(imm_ext),
        .alusrc(alusrc),
        .alu_in2(alu_in2)
    );
    
    alu_control ALU_CTRL (
        .aluop(aluop),
        .funct(funct),
        .alu_ctrl(alu_ctrl)
    );
    
    alu ALU (
        .a(read_data1),
        .b(alu_in2),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(zero)
    );
    
    branch_target_adder BRANCH_ADDER (
        .pc_plus4(pc_plus4),
        .sign_ext_imm(imm_ext),
        .branch_target(branch_target)
    );
    
    branch_unit BRANCH_UNIT (
        .branch(branch),
        .zero(zero),
        .pcsrc(pcsrc)
    );
    
    // ========== MEMORY STAGE ==========
    
    data_memory DMEM (
        .clk(clk),
        .memread(memread),
        .memwrite(memwrite),
        .address(alu_result),
        .writedata(read_data2),
        .readdata(mem_readdata)
    );
    
    // ========== WRITEBACK STAGE ==========
    
    memtoreg_mux MEMTOREG_MUX (
        .alu_result(alu_result),
        .mem_data(mem_readdata),
        .memtoreg(memtoreg),
        .writeback_data(writeback_data)
    );
    
    pcsrc_mux PCSRC_MUX (
        .pc_plus4(pc_plus4),
        .branch_target(branch_target),
        .pcsrc(pcsrc),
        .pc_next(pc_next)
    );

    // ========== TOP-LEVEL OUTPUT CONNECTIONS ==========
    assign pc_out          = pc;
    assign instruction_out = instruction;
    assign alu_result_out  = alu_result;

endmodule

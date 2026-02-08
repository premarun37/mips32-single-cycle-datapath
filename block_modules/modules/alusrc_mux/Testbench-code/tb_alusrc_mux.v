`timescale 1ns / 1ps

module tb_alusrc_mux();

        reg [31:0] reg_data2;
        reg [31:0] imm_ext;
        reg alusrc;
        wire [31:0] alu_in2;
        
         alusrc_mux uut (
        .reg_data2(reg_data2),
        .imm_ext(imm_ext),
        .alusrc(alusrc),
        .alu_in2(alu_in2)
    );
    
        initial begin
             reg_data2 = 32'd20;
             imm_ext = 32'd5;
             alusrc=0;#10;
             alusrc=1;#10;
             imm_ext =-32'd4;
             alusrc=1;#10;                  
        $finish;
        end
endmodule

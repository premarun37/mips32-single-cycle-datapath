`timescale 1ns / 1ps

module tb_pc_add4();

    reg  [31:0] pc;
    wire [31:0] pc_plus;

    pc_add4 uut (
        .pc(pc),
        .pc_plus(pc_plus)
    );

    initial begin 
        pc = 32'd0;         #10;
        pc = 32'd4;         #10;
        pc = 32'd8;         #10;
        pc = 32'd12;        #10;
        pc = 32'd16;        #10;
        pc = 32'd20;        #10;
        pc = 32'd100;       #10;
        pc = 32'h0000_00FC; #10;
        pc = 32'hFFFF_FFFC; #10; // wraps to 0

        $finish;
    end

endmodule

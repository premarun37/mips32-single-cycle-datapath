`timescale 1ns / 1ps

module tb_pc();
    reg clk,rst;
    reg [31:0] pc_nxt;
    wire [31:0] pc;
    
    pc uut (.clk(clk),
            .rst(rst),
            .pc_nxt(pc_nxt),
            .pc(pc)
            );
    always #5 clk=~clk;
    initial begin
        clk=0;
        rst=1;
        pc_nxt=32'b0;
        
        #12 rst=0;
        
        #10 pc_nxt=32'd4;
        #10 pc_nxt=32'd8;
        #10 pc_nxt=32'd12;
        #10 pc_nxt=32'd16;
        #10 pc_nxt=32'd20;
        
        #20;
        $finish;
    end
    
    initial begin
        $monitor("Time = %0t | rst = %0b | pc_nxt = %0b | pc = %0b ",$time, rst, pc_nxt, pc);
    end
endmodule

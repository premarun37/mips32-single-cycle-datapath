`timescale 1ns / 1ps

module tb_instruction_memory();
    reg  [31:0] pc;
    wire [31:0] instruction;

    // Instantiate Instruction Memory
    instruction_memory uut (
        .pc(pc),
        .instruction(instruction)
    );

    initial begin
        $display("Time\tPC\t\tPC[31:2]\tInstruction");
        $monitor("%0t\t%h\t%d\t\t%h",
                  $time, pc, pc[31:2], instruction);

        // Apply PC values (word-aligned)
        pc = 32'd0;    #10;   // mem[0]
        pc = 32'd4;    #10;   // mem[1]
        pc = 32'd8;    #10;   // mem[2]
        pc = 32'd12;   #10;   // mem[3]
        pc = 32'd16;   #10;   // mem[4]

        // Out-of-range access (no instruction loaded)
        pc = 32'd20;   #10;

        $finish;
    end


endmodule

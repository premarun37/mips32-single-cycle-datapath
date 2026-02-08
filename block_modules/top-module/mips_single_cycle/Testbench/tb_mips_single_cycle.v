`timescale 1ns /1ps
module tb_mips_single_cycle;
    reg clk;
    reg rst;
    // Instantiate the CPU
    mips_single_cycle uut (
        .clk(clk),
        .rst(rst)
    );
    // Clock generation: 10ns period
    always #5 clk = ~clk;
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        
        $display("\n========================================");
        $display("   MIPS Single Cycle Processor Test    ");
        $display("========================================");
        
        // Hold reset for a full clock cycle
        #10; // Wait for first rising edge
        
        // Release reset on negative edge of clock
        @(negedge clk);
        rst = 0;
        $display("\n[%0t] Reset released", $time);
        
        // Wait one more cycle so PC=0 instruction executes
        @(negedge clk);
        
        $display("\n=== Execution Trace ===");
        $display("Time\tCycle\tPC\tInstr\t\tOpcode\tRW\tALU\t\tWReg\tWData");
        $display("----\t-----\t--\t-----\t\t------\t--\t---\t\t----\t-----");
        
        // Run for 10 clock cycles
        repeat(10) begin
            @(posedge clk);
            #1; // Small delay for signals to settle
            $display("%0t\t%0d\t%h\t%h\t%b\t%b\t%h\t%d\t%h",
                $time, 
                ($time-25)/10,
                uut.pc, 
                uut.instruction,
                uut.opcode,
                uut.regwrite,
                uut.alu_result,
                uut.writereg,
                uut.writeback_data
            );
        end
        
        $display("\n========================================");
        $display("        Final Register State           ");
        $display("========================================");
        $display("$zero (R0)  = %d (0x%h)", uut.REGFILE.regfile[0], uut.REGFILE.regfile[0]);
        $display("$t0   (R8)  = %d (0x%h)", uut.REGFILE.regfile[8], uut.REGFILE.regfile[8]);
        $display("$t1   (R9)  = %d (0x%h)", uut.REGFILE.regfile[9], uut.REGFILE.regfile[9]);
        $display("$t2   (R10) = %d (0x%h)", uut.REGFILE.regfile[10], uut.REGFILE.regfile[10]);
        $display("$t3   (R11) = %d (0x%h)", uut.REGFILE.regfile[11], uut.REGFILE.regfile[11]);
        
        $display("\n========================================");
        $display("           Expected Results            ");
        $display("========================================");
        $display("$t0 = 5");
        $display("$t1 = 3");
        $display("$t2 = 8  (5+3)");
        $display("$t3 = 11 (3+8)");
        
        // Verify correctness
        if (uut.REGFILE.regfile[8] == 32'd5 &&
            uut.REGFILE.regfile[9] == 32'd3 &&
            uut.REGFILE.regfile[10] == 32'd8 &&
            uut.REGFILE.regfile[11] == 32'd11) begin
            $display("\n✅✅✅ ALL TESTS PASSED! ✅✅✅");
        end else begin
            $display("\n❌ TEST FAILED - Register values incorrect");
            $display("Got: $t0=%d, $t1=%d, $t2=%d, $t3=%d",
                uut.REGFILE.regfile[8],
                uut.REGFILE.regfile[9],
                uut.REGFILE.regfile[10],
                uut.REGFILE.regfile[11]);
        end
        
        $display("\n");
        $finish;
    end
endmodule

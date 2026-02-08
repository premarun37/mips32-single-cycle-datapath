`timescale 1ns / 1ps

module tb_register_file();

    reg         clk;
    reg         regwrite;
    reg  [4:0]  rs, rt, rd;
    reg  [31:0] writedata;
    wire [31:0] read_data1, read_data2;

    register_file uut (
        .clk(clk),
        .regwrite(regwrite),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .writedata(writedata),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        regwrite = 0;
        rs = 0; rt = 0; rd = 0;
        writedata = 0;

        //for write , only rd is used 
        // Write 10 into register $t0 (reg 8)
        #10;
        regwrite = 1;
        rd = 5'd8;
        writedata = 32'd10;

        // Write 20 into register $t1 (reg 9)
        #10;
        rd = 5'd9;
        writedata = 32'd20;

        // Stop writing
        #10;
        regwrite = 0;
        
        //for read , only rs,rt are used
        // Read $t0 and $t1
        rs = 5'd8;
        rt = 5'd9;

        #10;

        // Try writing to $zero (should fail)
        regwrite = 1;
        rd = 5'd0;
        writedata = 32'd999;

        #10;
        regwrite = 0;
        rs = 5'd0;

        #10;
        $finish;
    end

    initial begin
        $monitor("Time=%0t | rs=%d rt=%d rd=%d | RD1=%d RD2=%d",
                  $time, rs, rt, rd, read_data1, read_data2);
    end

endmodule


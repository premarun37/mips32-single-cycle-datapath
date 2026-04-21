`timescale 1ns / 1ps

module tb_data_memory;

    reg clk;
    reg memread;
    reg memwrite;
    reg  [31:0] address;
    reg  [31:0] writedata;
    wire [31:0] readdata;

    // Instantiate Data Memory
    data_memory uut (
        .clk(clk),
        .memread(memread),
        .memwrite(memwrite),
        .address(address),
        .writedata(writedata),
        .readdata(readdata)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        memread  = 0;
        memwrite = 0;
        address  = 0;
        writedata = 0;

        // -------------------------------
        // STORE WORD (sw)
        // mem[1] = 100
        // -------------------------------
        #10;
        memwrite = 1;
        memread  = 0;
        address  = 32'd4;     // 4 >> 2 = 1
        writedata = 32'd100;

        #10;                  // write occurs at posedge

        // -------------------------------
        // LOAD WORD (lw)
        // read mem[1]
        // -------------------------------
        memwrite = 0;
        memread  = 1;
        address  = 32'd4;

        #10;                  // combinational read

        // -------------------------------
        // STORE another value
        // mem[2] = 55
        // -------------------------------
        memread  = 0;
        memwrite = 1;
        address  = 32'd8;     // 8 >> 2 = 2
        writedata = 32'd55;

        #10;

        // -------------------------------
        // LOAD mem[2]
        // -------------------------------
        memwrite = 0;
        memread  = 1;
        address  = 32'd8;

        #10;

        // -------------------------------
        // Disable read
        // -------------------------------
        memread = 0;

        #10;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | memread=%b memwrite=%b | addr=%d | writedata=%d | readdata=%d",
                 $time, memread, memwrite, address, writedata, readdata);
    end

endmodule

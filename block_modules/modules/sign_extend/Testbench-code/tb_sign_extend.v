`timescale 1ns / 1ps

module tb_sign_extend();

    reg  [15:0] imm_in;
    wire [31:0] imm_out;

    // Instantiate the sign extension module
    sign_extend uut (
        .imm_in(imm_in),
        .imm_out(imm_out)
    );

    initial begin
        $display("Time\timm_in (hex)\timm_out (hex)");
        $monitor("%0t\t%h\t\t%h", $time, imm_in, imm_out);

        // Positive immediate
        imm_in = 16'h0005;   #10;   // +5

        // Another positive value
        imm_in = 16'h007F;   #10;   // +127

        // Zero
        imm_in = 16'h0000;   #10;

        // Negative value (-1)
        imm_in = 16'hFFFF;   #10;

        // Negative value (-4)
        imm_in = 16'hFFFC;   #10;

        // Most negative 16-bit number
        imm_in = 16'h8000;   #10;

        $finish;
    end

endmodule


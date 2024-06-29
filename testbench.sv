`timescale 1ns/1ps

module tb_breadboard();

  // Declare testbench signals
  logic clk;
  logic reset;
  logic [31:0] A;
  logic [31:0] B;
  logic [3:0] opcode;
  logic [31:0] C;
  logic ERR_out;

  // Instantiate the design under test (DUT)
  breadboard DUT (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .opcode(opcode),
    .C(C),
    .ERR_out(ERR_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100 MHz clock
  end

  // Test procedure
  initial begin
    // Initialize signals
    reset = 1;
    A = 32'h0;
    B = 32'h0;
    opcode = 4'h0;

    // Release reset
    #10 reset = 0;

    // Test ADD operation
    #10 A = 32'h00000010; B = 32'h00000020; opcode = 4'h1;
    #10 if (C !== 32'h00000030) $display("Test ADD failed");

    // Test SUB operation
    #10 A = 32'h00000020; B = 32'h00000010; opcode = 4'h2;
    #10 if (C !== 32'h00000010) $display("Test SUB failed");

    // Test MUL operation
    #10 A = 32'h00000010; B = 32'h00000010; opcode = 4'h3;
    #10 if (C !== 32'h00000100) $display("Test MUL failed");

    // Test DIV operation
    #10 A = 32'h00000004; B = 32'h00000002; opcode = 4'h4;
    #10 if (C !== 32'h00000005) $display("Test DIV failed");

    // Test AND operation
    #10 A = 32'h000000FF; B = 32'h0000FF00; opcode = 4'h6;
    #10 if (C !== 32'h00000000) $display("Test AND failed");

    // Test OR operation
    #10 A = 32'h000000FF; B = 32'h0000FF00; opcode = 4'h7;
    #10 if (C !== 32'h0000FFFF) $display("Test OR failed");

    // Test XOR operation
    #10 A = 32'h000000FF; B = 32'h0000FF00; opcode = 4'h8;
    #10 if (C !== 32'h0000FFFF) $display("Test XOR failed");

    // Test NOT operation
    #10 B = 32'h0000FFFF; opcode = 4'h9;
    #10 if (C !== ~A) $display("Test NOT failed");

    // Test NAND operation
    #10 A = 32'h000000FF; B = 32'h0000FF00; opcode = 4'hA;
    #10 if (C !== 32'hFFFFFFFF) $display("Test NAND failed");

    // Test NOR operation
    #10 A = 32'h000000FF; B = 32'h0000FF00; opcode = 4'hB;
    #10 if (C !== 32'hFFFF0000) $display("Test NOR failed");

    // Test XNOR operation
    #10 A = 32'h000000FF; B = 32'h0000FF00; opcode = 4'hC;
    #10 if (C !== 32'hFFFF0000) $display("Test XNOR failed");

    // Test SHL operation
    #10 A = 32'h00000001; opcode = 4'hD;
    #10 if (C !== 32'h00000002) $display("Test SHL failed");

    // Test SHR operation
    #10 A = 32'h00000002; opcode = 4'hE;
    #10 if (C !== 32'h00000001) $display("Test SHR failed");

    // Finish simulation
    #10 $finish;
  end

endmodule

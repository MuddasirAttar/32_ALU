module AND_gate(A, B, Out); //AND gate
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  assign Out = (A & B);
endmodule

module OR_gate(A, B, Out); //OR gate
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  assign Out = (A | B);
endmodule

module XOR_gate(A, B, Out); //XOR gate
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  assign Out = (A ^ B);
endmodule

module NOT_gate(A, Out); //NOT gate
  input logic [31:0] A;
  output logic [31:0] Out;
  assign Out = ~A;
endmodule

module NAND_gate(A, B, Out); //NAND gate
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  assign Out = ~(A & B);
endmodule

module NOR_gate(A, B, Out); //NOR gate
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  assign Out = ~(A | B);
endmodule

module XNOR_gate(A, B, Out); //XNOR gate
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  assign Out = ~(A ^ B);
endmodule

module ADD_er(A, B, SUM, Cout); //ADDER
  input logic [31:0] A;
  input logic [31:0] B;
  output logic Cout;
  output logic [31:0] SUM;
  logic [32:0] SUM_local;
  always @(*) begin
    SUM_local = A + B;
  end
  assign SUM = SUM_local[31:0]; //SUM
  assign Cout = SUM_local[32];  //Cout
endmodule

module SUB_er(A, B, Out); //subtractor
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  logic [31:0] SUB_local;
  always @(*) begin
    SUB_local = A - B;
  end
  assign Out = SUB_local[31:0];
endmodule

module MUL_er(A, B, Out); //multiplier
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  logic [31:0] MUL_local;
  always @(*) begin
    MUL_local = A * B;
  end
  assign Out = MUL_local[31:0];
endmodule

module DIV_er(A, B, Out, Remainder); //divider/remainder
  input logic [31:0] A;
  input logic [31:0] B;
  output logic [31:0] Out;
  output logic [31:0] Remainder;
  logic [31:0] DIV_local;
  logic [31:0] REMAIN_local;
  always @(*) begin
    DIV_local = A / B;
    REMAIN_local = A % B;
  end
  assign Out = DIV_local[31:0];
  assign Remainder = REMAIN_local[31:0];
endmodule

module SHL_Logic(A, Out); //1-bit logic shift left
  input logic [31:0] A;
  output logic [31:0] Out;
  logic [31:0] SHL_local;
  always @(*) begin
    SHL_local = (A << 1);
  end
  assign Out = SHL_local[31:0];
endmodule

module SHR_Logic(A, Out); //1-bit logic shift right
  input logic [31:0] A;
  output logic [31:0] Out;
  logic [31:0] SHR_local;
  always @(*) begin
    SHR_local = (A >> 1);
  end
  assign Out = SHR_local[31:0];
endmodule

module DFF(input logic clk, input logic inputA, output logic Out); //DFF for ERROR state
  always @(posedge clk) begin
    Out = inputA;
  end
endmodule

module DFF_register(input logic clk, input logic reset, input logic [31:0] inputA, output logic [31:0] Out); //ACC
  logic [31:0] rst;
  always @(posedge clk) begin
    if (reset == 1) begin
      rst = 0;
    end else begin
      rst = inputA;
    end
  end
  assign Out = rst;
endmodule

module ERROR_Check(input logic clk, input logic rst, input logic add_of, output logic LED); //ERROR-CHECK
  wire Overflow_ERR;
  assign Overflow_ERR = add_of;
  wire ERROR_wire;
  logic ERROR_value;

  DFF ERROR_CHECKER(clk, Overflow_ERR, ERROR_wire);
  always @(*) begin
    ERROR_value = ERROR_wire;
    if (rst == 0) begin
      ERROR_value = 0;
    end
  end
  assign LED = ERROR_wire;
endmodule

module MUX(input logic [31:0] channels [15:0], input logic [3:0] select, output logic [31:0] Out); //16 channels(32bit) - Multiplexer
  assign Out = channels[select];
endmodule

module breadboard(input logic clk, input logic reset, input logic [31:0] A, input logic [31:0] B, input logic [3:0] opcode, output logic [31:0] C, output logic ERR_out); //breadboard
  logic [31:0] curA;
  logic [31:0] curB;
  logic [31:0] curC;
  logic curERROR;

  logic [31:0] nextA;
  logic [31:0] nextB;
  logic [31:0] nextC;
  logic nextERROR;

  logic [31:0] zeros_wire = 32'b0;
  logic [31:0] ADD_out_wire;
  logic carry_error_wire;
  logic [31:0] SUB_out_wire;
  logic [31:0] MUL_out_wire;
  logic [31:0] DIV_out_wire;
  logic [31:0] remainder_wire;
  logic [31:0] AND_out_wire;
  logic [31:0] OR_out_wire;
  logic [31:0] XOR_out_wire;
  logic [31:0] NOT_out_wire;
  logic [31:0] NAND_out_wire;
  logic [31:0] NOR_out_wire;
  logic [31:0] XNOR_out_wire;
  logic [31:0] SHL_out_wire;
  logic [31:0] SHR_out_wire;

  logic [31:0] MUX_channels [15:0];

  assign MUX_channels[0] = curC;
  assign MUX_channels[1] = ADD_out_wire;
  assign MUX_channels[2] = SUB_out_wire;
  assign MUX_channels[3] = MUL_out_wire;
  assign MUX_channels[4] = DIV_out_wire;
  assign MUX_channels[5] = remainder_wire;
  assign MUX_channels[6] = AND_out_wire;
  assign MUX_channels[7] = OR_out_wire;
  assign MUX_channels[8] = XOR_out_wire;
  assign MUX_channels[9] = NOT_out_wire;
  assign MUX_channels[10] = NAND_out_wire;
  assign MUX_channels[11] = NOR_out_wire;
  assign MUX_channels[12] = XNOR_out_wire;
  assign MUX_channels[13] = SHL_out_wire;
  assign MUX_channels[14] = SHR_out_wire;
  assign MUX_channels[15] = zeros_wire;

  logic [31:0] MUX_out_wire;
  logic ERROR_result;

  ADD_er ADD1(A, B, ADD_out_wire, carry_error_wire);
  SUB_er SUB1(A, B, SUB_out_wire);
  MUL_er MUL1(A, B, MUL_out_wire);
  DIV_er DIV1(A, B, DIV_out_wire, remainder_wire);
  AND_gate AND1(A, B, AND_out_wire);
  OR_gate OR1(A, B, OR_out_wire);
  XOR_gate XOR1(A, B, XOR_out_wire);
  NOT_gate NOT1(B, NOT_out_wire);  // Note: Corrected input
  NAND_gate NAND1(A, B, NAND_out_wire);
  NOR_gate NOR1(A, B, NOR_out_wire);
  XNOR_gate XNOR1(A, B, XNOR_out_wire);
  SHL_Logic SHL1(A, SHL_out_wire);
  SHR_Logic SHR1(A, SHR_out_wire);

  MUX MUX1(MUX_channels, opcode, MUX_out_wire);
  DFF_register DFF_ACC(clk, reset, MUX_out_wire, curC);
  ERROR_Check ERR1(clk, reset, carry_error_wire, ERROR_result);

  always @(*) begin
    nextA = A;
    nextB = B;
    nextC = MUX_out_wire;
    nextERROR = carry_error_wire;
  end

  assign C = curC;
  assign ERR_out = ERROR_result;
endmodule

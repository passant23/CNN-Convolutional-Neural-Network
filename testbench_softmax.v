`timescale 1ns / 1ps

module testbench_softmax();
reg clock;
reg reset;
parameter datawidth=32;
reg [datawidth-1:0]input_fp;
wire [datawidth-1:0]output_fp;


softmax_fn s(clock,
reset,
input_fp,
output_fp);

initial begin
clock=1'b1;
reset=1'b0;
//0
input_fp=32'b00000000000000000000000000000000;
#30
//1
input_fp=32'b00111111100000000000000000000000;
#30
//-1
input_fp=32'b10111111100000000000000000000000;
#30
//0.5
input_fp=32'b00111111000000000000000000000000;
#30
//-0.5
input_fp=32'b10111111000000000000000000000000;
#30
//0.2
input_fp=32'b00111110010011001100110011001101;
#30
//2
input_fp=32'b01000000000000000000000000000000;
#30
//0.6
input_fp=32'b00111111000110011001100110011010;
#30
//-0.2
input_fp=32'b10111110010011001100110011001101;
#30
//0.7
input_fp=32'b00111111001100110011001100110011;
#300
$finish;
end
always begin
forever #15 clock = ~clock;
end
always@(negedge clock)
begin
#30;
end
endmodule

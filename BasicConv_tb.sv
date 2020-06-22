`timescale 1ns / 1ps

module BasicConv_tb;
// Setting the clock //
localparam Period = 0.1; 
reg [31:0] A;
reg [31:0] A_temp;
reg [31:0] B_temp;
reg clk,start;
reg [31:0] B;
wire [31:0] C;


assign A_temp =32'b01000000010000000000000000000000; //3
assign B_temp =32'b00111111100000000000000000000000; //1

BasicConv bconv(
.A(A),
.B(B),
.start(start),
.clk(clk),
.C(C)
);

always
      begin
      #(Period/2) clk = ~clk;
      end
initial
begin
start=0;
clk=0;
//#(Period/2) //  1st Rising edge: Assign pixel of image
A=A_temp;
B=B_temp; 
#Period // Next Falling edge
start=1;
$stop;
end



endmodule
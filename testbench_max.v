`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2020 12:09:33 AM
// Design Name: 
// Module Name: testbench_max
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_max();
parameter datawidth=32;
reg [datawidth-1:0] input1;
reg [3:0]index1;
reg [datawidth-1:0] input2;
reg [3:0] index2;
wire [datawidth-1:0] maximum;
wire [3:0] indexmaximum;

max maxi(input1,index1,input2,index2,maximum,indexmaximum);
initial begin
input1=32'h70691111;
index1=4'h7;
input2=32'h09f81142;
index2=4'h3;
#30
//same exponent and different mantissa
input1=32'h10691111;
index1=4'h2;
input2=32'h10698142;  
index2=4'h8;
#30
input1=32'h4bcc1f11;
index1=4'h5;
input2=32'h01f4bb42;
index2=4'h6;
#30
input1=32'h23391001;
index1=4'h0;
input2=32'h07fab142;
index2=4'h4;
#30
input1=32'h2ff91201;
index1=4'h1;
input2=32'h0beab1f1;
index2=4'h3;
#30
input1=32'h33bb1901;
index1=4'h0;
input2=32'h09fabbe2;
index2=4'h7;
#30
input1=32'h4cef1f13;
index1=4'h4;
input2=32'h6166fb42;
index2=4'h9;
#420
$finish;
end
endmodule

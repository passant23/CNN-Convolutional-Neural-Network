`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2020 08:09:38 AM
// Design Name: 
// Module Name: fp_avg_tb
// Project Name: 
// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////

include "fp_avg.sv";
module fp_avg_tb;
reg [31:0] In1;  
reg start,clk;
wire [31:0] avg;

// Setting the clock //
localparam Period = 0.1;  // Period of the clock = 100 ps


always
      begin
      #(Period/2) clk = ~clk;
      end

initial
begin
start=0;
clk=0;
#((3*Period)/2) //  2nd Rising edge: Assign pixel of image and set the start bit
start=1;
In1=32'b00111111100000000000000000000000;  // 1st Pixel = 1 
#Period // 3rd Rising edge
In1=32'b01000000000000000000000000000000; // 2nd Pixel = 2
#Period // 4th Rising edge
In1=32'b01000000010000000000000000000000; // 3rd Pixel = 3
#Period // 5th Rising edge
In1=32'b01000000100000000000000000000000; // 4th Pixel =4
#((3*Period)/2)
$stop;
end

fp_avg a(
. In1(In1),
.clk(clk),
.start(start),
.avg(avg)
);
endmodule

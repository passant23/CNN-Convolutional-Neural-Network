`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2020 12:42:57 PM
// Design Name: 
// Module Name: softmaxLayer
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


module softmaxLayer(clock,
reset,
inputlayer,
outputlayer
    );
parameter datawidth=32;
input clock;
input reset;
input [datawidth-1:0] inputlayer [9:0][1][1];  
output reg [datawidth-1:0] outputlayer [9:0][1][1];
wire [datawidth-1:0] outputlayertemp [9:0][1][1];

genvar i;
 generate
 for(i=0;i<10;i=i+1)
 begin
softmax_fn s (clock,reset,inputlayer[i][0][0],outputlayertemp[i][0][0]);    //the exponentiel output of the 10 inputs

//fp_add add_softmax(softmaxout[i],softmaxout[i+1],softmaxout[i+1]);   
end
endgenerate

always@(*)
begin
outputlayer=outputlayertemp;
end
endmodule
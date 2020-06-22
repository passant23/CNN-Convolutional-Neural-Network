`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2020 12:26:26 PM
// Design Name: 
// Module Name: max
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

//this module compares 2 numbers and return the maximum
module max(input1,index1,input2,index2,maximum,indexmaximum);

parameter datawidth=32;
input [datawidth-1:0] input1,input2;  
input [3:0] index1,index2;
output reg [datawidth-1:0] maximum;
output reg [3:0] indexmaximum;

wire [7:0] exponent1,exponent2;
wire [22:0] mantissa1,mantissa2;


genvar i;
generate
for(i=0;i<1;i=i+1)
begin
    assign exponent1=input1[30:23];    //passing the exponent of 1st input
    assign exponent2=input2[30:23];    //passing the exponent of the 2nd input
    assign mantissa1=input1[22:0];     //passing the mantissa of the 1st input 
    assign mantissa2=input2[22:0];     //passing the mantissa of the 2nd input 
end
endgenerate

always @(*)
begin
    if(exponent1>exponent2)        //comparing the exponent without the sign bit since all number are +ve after applying the exponential function
      begin
        maximum=input1;            //the max
        indexmaximum=index1;        //the index of the max to map it outside to the right picture 
      end
     else if (exponent1<exponent2)  //comparing the exponent without the sign bit since all number are +ve after applying the exponential function
      begin
        maximum=input2;               //the max
        indexmaximum=index2;         //the index of the max to map it outside to the right picture
       end   
      else if(mantissa1>mantissa2)     //if the xponents are equals we compare the mantissa
         begin
               maximum=input1;         //the max
               indexmaximum=index1;    //the index of the max to map it outside to the right picture
            end
            else
            begin
               maximum=input2;          //the max
               indexmaximum=index2;     //the index of the max to map it outside to the right picture
            end
      
end 
endmodule


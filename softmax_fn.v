`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2020 06:13:35 AM
// Design Name: 
// Module Name: softmax_fn
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


module softmax_fn(clock,
reset,
input_fp,
output_fp);

 input clock;
 input reset;
 input [datawidth-1:0] input_fp ;  
 output reg [datawidth-1:0] output_fp;
 
 parameter datawidth=32;
 

 //fp_add and fp_mull variables 
 wire [datawidth-1:0] out_add_12terms,out_add_23terms,out_add_34terms,out_add_45terms,out_add_56terms,out_add_67terms;
 wire [datawidth-1:0] out_mull_x2,out_mull_2,out_mull_x3,out_mull_3,out_mull_x4,out_mull_4,out_mull_x5,out_mull_5,out_mull_x6,out_mull_6;
 
 genvar i;
 generate
 for(i=0;i<1;i=i+1)
 begin
 
 //e^x = 1 + x + x^2/2 + x^3/6 + x^4/24 + x^5/120 + x^6/720
 //1st and 2nd term
 fp_add add_12terms(32'b00111111100000000000000000000000,input_fp,out_add_12terms);         //x+1
 //since the numbers are constants i will use the floating point module instead on division 
//3rd term
 fpmul mull_x2(input_fp,input_fp,out_mull_x2);                                  //x^2
 fpmul mull_2(out_mull_x2,32'b00111111000000000000000000000000,out_mull_2);     //x^2 * 1/2
 fp_add add_23terms(out_add_12terms,out_mull_2,out_add_23terms);                //1+x+(x^2/2)
 //4th term
 fpmul mull_x3(out_mull_x2,input_fp,out_mull_x3);           //x^3
 fpmul mull_3(out_mull_x3,32'b00111110001010101010101010101011,out_mull_3);    //x^3 * 1/6
 fp_add add_34terms(out_add_23terms,out_mull_3,out_add_34terms);                // 1 + x + x^2/2 + x^3/6
 //5th term
 fpmul mull_x4(out_mull_x3,input_fp,out_mull_x4);          //x^4
 fpmul mull_4(out_mull_x4,32'b00111101001010101010101010101011,out_mull_4);     //x^4 * 1/24
 fp_add add_45terms(out_add_34terms,out_mull_4,out_add_45terms);                //1 + x + x^2/2 + x^3/6 + x^4/24
 //6th term
 fpmul mull_x5(out_mull_x4,input_fp,out_mull_x5);          //x^5
 fpmul mull_5(out_mull_x5,32'b00111100000010001000100010001001,out_mull_5);      //x^5 * 1/120
 fp_add add_56terms(out_add_45terms,out_mull_5,out_add_56terms);                //1 + x + x^2/2 + x^3/6 + x^4/24 + x^5/120
 //7th term
 fpmul mull_x6(out_mull_x5,input_fp,out_mull_x6);          //x^6
 fpmul mull_6(out_mull_x6,32'b00111010101101100000101101100001,out_mull_6);      //x^6 * 1/720
 fp_add add_67terms(out_add_56terms,out_mull_6,out_add_67terms) ;               //1 + x + x^2/2 + x^3/6 + x^4/24 + x^5/120 + x^6/720
 
 
 end
 endgenerate
 
 always @(negedge clock)
 begin
 output_fp<=out_add_67terms;
  end  
endmodule
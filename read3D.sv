`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2020 07:02:46 PM
// Design Name: 
// Module Name: read3D
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


//This module stores a text file into a 3D array of dim3  xdim1 xdim2
module read3D(out);
parameter file="A:/Filter1_IEEE.txt",
dim1=2,dim2=2,dim3=6 ;

output reg [31:0] out [dim3] [dim1][dim2];
genvar i;

generate for(i=0;i<dim3; i=i+1)
begin

read #(file,dim1,dim2)
reading2D(out[i]);

end

endgenerate 
  
endmodule
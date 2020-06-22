`timescale 1ns / 1ps
//This module stores a text file into a 2D array of dim  xdim 
module read(out);
parameter file="C:/Users/passant/Desktop/m.txt",
dim1=2,dim2=2 ;
reg [31:0] mem [dim1][dim2]; 
output reg [31:0] out [dim1][dim2];
initial begin
    $readmemh(file,mem);
end

assign out =mem;


endmodule
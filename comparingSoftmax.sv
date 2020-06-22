`timescale 1ns / 1ps
//THIS MODULE FINDS THE BIGGEST VALUE AMONGS ALL THE SOFTMAX OUTPUTS
module comparingSoftmax(clock,softmax_out,max_out,max_index);

parameter datawidth=32;
input clock;
input [datawidth-1:0] softmax_out [9:0][1][1];  
output reg [datawidth-1:0] max_out;
output reg [3:0] max_index;

reg [datawidth-1:0] max_1,max_2,max_3,max_4,max_5,max_6,max_7,max_8,max_9 ;  
reg [3:0] index_max_1,index_max_2,index_max_3,index_max_4,index_max_5,index_max_6,index_max_7,index_max_8,index_max_9;

//finding the maximum by calling the max function that returns the maximum of 2 numbers


max maximum_1(softmax_out[0][0][0],0,softmax_out[1][0][0],i+1,max_1,index_max_1);   
max maximum_2(max_1,index_max_1,softmax_out[2][0][0],2,max_2,index_max_2);
max maximum_3(max_2,index_max_2,softmax_out[3][0][0],3,max_3,index_max_3);
max maximum_4(max_3,index_max_3,softmax_out[4][0][0],4,max_4,index_max_4);
max maximum_5(max_4,index_max_4,softmax_out[5][0][0],5,max_5,index_max_5);
max maximum_6(max_5,index_max_5,softmax_out[6][0][0],6,max_6,index_max_6);
max maximum_7(max_6,index_max_6,softmax_out[7][0][0],7,max_7,index_max_7);
max maximum_8(max_7,index_max_7,softmax_out[8][0][0],8,max_8,index_max_8);
max maximum_9(max_8,index_max_8,softmax_out[9][0][0],9,max_9,index_max_9);


//the maximum of all 10 softmax outputs and its index to map it to the correct picture
assign max_out=max_9;
assign max_index=index_max_9;

endmodule
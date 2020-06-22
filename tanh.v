/////////////////////////////////////////////////////////////
module tanh(clk,input_data,output_data);
  parameter datawidth=32; 
  input clk;
  input [datawidth-1:0] input_data ;  
  output reg [datawidth-1:0] output_data;

  wire[datawidth-1:0] out_adder1,
  out_adder2,  out_adder3,  out_adder4,
  out_multiplier1,
  out_multiplier2,
  out_multiplier3, out_multiplier4,out_multiplier5, out_multiplier6,out_multiplier7, out_multiplier8,out_multiplier9, out_multiplier10,out_multiplier11, out_multiplier12,out_multiplier13,out_multiplier14, out_multiplier15;
  
 
genvar j;
 generate
      
     for(j=0; j<1; j=j+1)
     begin
 
fpmul multiplier1 (input_data,input_data,out_multiplier1);  
fpmul multiplier2 (input_data,out_multiplier1,out_multiplier2);  
fpmul multiplier3 (32'b10111110101010101010101010101011,out_multiplier2,out_multiplier3);     //fp_mul (input_fc[i], weightCaches_fc[DATA_WIDTH*i+:DATA_WIDTH] ,y_part[i]); 
 fp_add adder2( input_data,out_multiplier3,out_adder2);
 fpmul multiplier4 (input_data,input_data,out_multiplier4);  
fpmul multiplier5 (input_data,out_multiplier4,out_multiplier5);
fpmul multiplier6 (input_data,out_multiplier5,out_multiplier6);  
fpmul multiplier7 (input_data,out_multiplier6,out_multiplier7);    
fpmul multiplier8 (32'b00111110000010001000100010001001,out_multiplier7,out_multiplier8); 
fp_add adder3( out_adder2,out_multiplier8,out_adder3);
fpmul multiplier9 (input_data,input_data,out_multiplier9);  
fpmul multiplier10 (input_data,out_multiplier9,out_multiplier10);
fpmul multiplier11 (input_data,out_multiplier10,out_multiplier11);  
fpmul multiplier12 (input_data,out_multiplier11,out_multiplier12);  
fpmul multiplier13 (input_data,out_multiplier12,out_multiplier13);
fpmul multiplier14 (input_data,out_multiplier13,out_multiplier14);  
fpmul multiplier15 (32'b10111101010111010000110111010001,out_multiplier14,out_multiplier15);     
fp_add adder4(out_adder3,out_multiplier15,out_adder4);   
	
            end
endgenerate
always @(negedge clk)
begin
output_data<=out_adder4;

end
endmodule
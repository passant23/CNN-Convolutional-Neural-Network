module ConvMF (Image,Filters,clk,start,Out);

 parameter       Felements = 5, //5x5
                 Ielements = 32, //32x32
                 Oelements = 28, //28x28
                 FilterNum = 6,
                 DATA_WIDTH = 32;
                 
input [(DATA_WIDTH-1):0] Image [Ielements][Ielements]; //32x32
input [(DATA_WIDTH-1):0] Filters [FilterNum][Felements][Felements]; //5x5x6
input     clk ,start;
output reg [(DATA_WIDTH-1):0] Out [FilterNum][Oelements][Oelements]; //28x28x6

wire [(DATA_WIDTH-1):0] out_conv [Oelements][Oelements]; //28x28
reg [6:0] i,l; //Max is 120 filters => 2^7=128
genvar  j,k,z;
 

generate
     for(j=0; j<FilterNum; j=j+1)
     begin

     Conv1F #(Felements,Ielements,Oelements,DATA_WIDTH)conv(
     .Image(Image),
     .Filter(Filters[j]),
     .clk(clk),
     .start(start),
     .Out(Out[j])
     );
     
     end  
endgenerate 
endmodule
module avg_3D (ImagesIn,clk,start,ImagesOut,valid);

 parameter       Felements = 3, //6x5
                 In_elements = 10; //28x28
                     
input [31:0] ImagesIn [Felements] [In_elements][In_elements]; //28x28
input     clk ,start;
output reg [31:0] ImagesOut [Felements][In_elements/2][In_elements/2]; //6x14x14
reg [9:0] counter=-1;
output reg valid;

//wire [31:0] out_image [Out_elements][Out_elements]; //14x14
//reg [6:0] i; //
genvar  i;
 

generate
     for(i=0; i<Felements; i=i+1)
     begin

     AvgLayer #(In_elements) avg1(
     .ImageIn(ImagesIn[i]),
     .ImageOut(ImagesOut[i]),
     .start(start),
     .clk(clk)
     );
     
     end  
endgenerate 


always@(posedge clk)
begin

counter=counter+1;
if (counter == ((In_elements*In_elements)+ ((In_elements*In_elements)/4) +2) )
valid=1;
else
valid=0;
end
endmodule
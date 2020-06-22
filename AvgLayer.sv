`timescale 1ns / 1ps


module AvgLayer(ImageIn,ImageOut,start,clk);
parameter  size=10;

input start,clk;
input [31:0] ImageIn [size][size];
output reg [31:0] ImageOut [size/2][size/2];
reg [31:0] imageout; //[size/2][size/2];
reg [31:0] Current_Pixel;
reg [3:0] counter;
reg [4:0] rowIn,colIn,PRow,PCol,rowOut,colOut;
reg [1:0] CounterCol,CounterRow;
reg fpStart;
reg reset;
wire [31:0] fpavg_out;




fp_avg AveragePool(
.In1(Current_Pixel),
.clk(clk),
.start(fpStart),
.avg(fpavg_out)
);

always@(posedge clk)
begin
if(start==0)
begin
// Initizalizig indices and the counter
rowIn =0;
colIn=0;
CounterRow=0;
CounterCol=0;
PRow=0;
PCol=-1; 
rowOut=0; 
colOut=-1;
counter = 0; // counter to assign the value after 4 iterations
fpStart=0;
reset=0;
end
else  // Start = 1
begin
if (rowIn<size) // Rows of ImageIn
begin
  if (colIn<size) // Columns of ImageIn
    begin
      if (reset==1)
      fpStart=0;
      else
      fpStart=1;
      if (CounterCol<2 && counter!=5)
      begin
      PCol= PCol +1;
      CounterCol= CounterCol + 1;
      if (counter!=6)  
      counter = counter + 1; // number of pixels
      
      Current_Pixel = ImageIn[PRow] [PCol];
      reset=0;
      end
      else if (CounterCol==2 && counter!=5) // Taking the two pixels in the same row
      begin
      PRow= PRow + 1; // Going to the row below
      PCol = colIn;
      CounterCol=0;
      counter = counter + 1; // number of pixels
      Current_Pixel = ImageIn[PRow] [PCol];
      end
      if (counter == 4)
      begin

      // Re-initializing

      CounterCol=0;
      PRow=rowIn;
      colIn= colIn+ 2;
      PCol= colIn-1;
      counter = counter + 1;
      reset=1;
      end
      // Resetting the accumulation, and sending a 0 pixel 
      else if (counter==5)
      begin
      Current_Pixel=0;
      counter=counter+1;
       reset=0;
      end
      // At the 6th cycle, avg is ready so it's assigned to the output matrix
      else if (counter==6)
      begin
             counter=1;
            if (rowOut<size/2)
            begin
               
             if (colOut<(size/2)-1 | colOut==5'b11111)
              begin
              colOut=colOut+1; 
              end
              else begin
              colOut=0;
              rowOut=rowOut+1;
              end
            ImageOut[rowOut][colOut]= fpavg_out;
            end
      end
    end 
  else 
   begin
     if (counter==5)
        begin
         Current_Pixel=0;
         counter=counter+1;
          reset=0;
          fpStart=0;
        end
      else
      begin
      fpStart=1;
    rowIn=rowIn+2;
    colIn= 0;
    PRow= rowIn;
    PCol = colIn;
    CounterCol= CounterCol + 1; 
    Current_Pixel = ImageIn[PRow] [PCol];
    counter=1;
    if (rowOut<size/2)
                begin
                  if (colOut<(size/2)-1 || colOut==5'b11111)
                 begin
                  colOut=colOut+1; 
                  end
                  else begin
                  colOut=0;
                  rowOut=rowOut+1;
                  end
                  ImageOut[rowOut][colOut]= fpavg_out;
                end
    end
end
end  
end
end    
endmodule

       
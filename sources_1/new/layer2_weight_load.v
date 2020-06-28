`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 18:12:52
// Design Name: 
// Module Name: layer2_weight_load
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


module layer2_weight_load(
     input clk,
     output reg signed[255:0] layer2_weight,
     output reg enable1,
     output reg enable2,
     output reg enable3,
     output reg enable4,
     output reg enable5,
     output reg enable6
    );
     reg[7:0] addra;
     reg enable;
     reg[7:0] count;
     reg[7:0] index;
     reg[3:0] i; 
     initial begin
         addra<=0;
         enable<=1;
         count<=0;
     end
     wire signed[255:0] temp;
     layer2_weight m(.clka(clk),.ena(enable),.addra(addra),.douta(temp));
    always@(posedge clk)
    begin
      if(enable)
      begin
      if(count<'d155)
       count<=count+1;
      else
       count<=count;
      if(addra<'d149)
        addra<=addra+1;
      else
       addra<=addra;
       layer2_weight<=temp;
      end
    end     
    always@(posedge clk)
    begin
        if(count<2)
       {enable1,enable2,enable3,enable4,enable5,enable6}<=6'b000000;
       else
        begin
          index=count-2;
           i=index/25;
         // $display("index:%d,i:%d,weight1:%b",index,i,weight1);
          {enable6,enable5,enable4,enable3,enable2,enable1}=1<<i;
          //$display("%d,%d,%d,%d,%d,%d",enable6,enable5,enable4,enable3,enable2,enable1);
        end
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/17 20:53:38
// Design Name: 
// Module Name: softmax
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


module softmax(
       input clk,
       input enable,
       input [179:0] din,
       output reg[3:0] dout,
       output reg finish
    );
    wire signed[17:0] digit[0:9];
    integer i;
    assign {digit[0],digit[1],digit[2],digit[3],digit[4],digit[5],digit[6],digit[7],digit[8],digit[9]}= din;
    reg signed[17:0] temp;
    always@(posedge clk)
    begin
      if(enable)
      begin
       //$display("%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",digit[0],digit[1],digit[2],digit[3],digit[4],digit[5],digit[6],digit[7],digit[8],digit[9]);
        temp=digit[0];
        dout=0;
        for(i=1;i<10;i=i+1)
        begin
           if(digit[i]>temp)
           begin
             temp=digit[i];
             dout=i;
           end
        end
        finish=1;
      //  $finish();
      end
      else
         finish=0;
    end
endmodule

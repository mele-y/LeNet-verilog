`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/08 17:58:01
// Design Name: 
// Module Name: mult_16_2
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


module mult_16_2(
          input signed[15:0] a,
          input signed[15:0] b,
          output reg signed[15:0] q
    );
      wire signed[31:0] temp;
      mult_16_basic m(.A(a),.B(b),.P(temp));
      always@(temp)
       begin
         // temp=a*b;
         q={temp[31],temp[27:13]};
       end
endmodule

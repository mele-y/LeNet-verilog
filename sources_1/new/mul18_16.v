`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/21 16:19:12
// Design Name: 
// Module Name: mul18_16
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


module mul18_16(
        input signed[17:0] a,
        input signed[15:0] b,
        output reg signed[15:0] q
    );
(*use_dsp="yes"*)reg signed[33:0] temp;
     always@(a or b)
      begin
       temp=a*b;
       q={temp[33],temp[29:15]};
      end
endmodule

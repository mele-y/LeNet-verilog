`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/27 09:13:58
// Design Name: 
// Module Name: mult16_16
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


module mult16_16(
        input signed[15:0] a,
        input signed[15:0] b,
        output reg signed[15:0] q
    );
    reg signed[31:0] temp;
    always@(a or b)
    begin
     temp=a*b;
     q={temp[31],temp[28:14]};
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/04 19:54:16
// Design Name: 
// Module Name: mult_16
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


module mult_16(
       input signed[15:0] a,
       input signed[15:0] b,
       output reg signed[15:0] q
    );
    wire signed[31:0] temp;
    mult_16_basic m(.A(a),.B(b),.P(temp));
    always@(temp)
    begin
       q={temp[31],temp[29:15]};
    end
endmodule

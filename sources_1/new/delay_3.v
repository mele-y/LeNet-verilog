`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 16:21:32
// Design Name: 
// Module Name: delay_3
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


module delay_3(
    input clk,
input din,
output reg dout
    );
    reg a,b;
        always@(posedge clk)
    begin
       a<=din;
       b<=a;
       dout<=b;
    end
endmodule

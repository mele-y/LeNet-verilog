`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/12 20:32:36
// Design Name: 
// Module Name: delay1
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


module delay1(
    input clk,
    input din,
    output reg dout,
    input reset
    );
    always@(posedge clk or posedge reset)
    begin
    if(reset)
     dout<=0;
     else
       dout<=din;
    end
endmodule

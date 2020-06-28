`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/02 17:18:39
// Design Name: 
// Module Name: finish_delay1
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


module finish_delay1(
     input clk,
     input din,
     output reg dout
    );
    always@(posedge clk)
    begin
     dout<=din;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/27 15:46:52
// Design Name: 
// Module Name: datadelay2
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


module datadelay2(
       input clk,
       input signed[15:0] din,
       output reg signed[15:0] dout,
       input reset
    );
    reg signed[15:0] temp;
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    begin
      temp<=0;
      dout<=0;
    end
    else
    begin
     temp<=din;
     dout<=temp;
     end
    end
endmodule

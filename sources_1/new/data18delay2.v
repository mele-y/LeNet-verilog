`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/13 11:45:56
// Design Name: 
// Module Name: data18delay2
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


module data18delay2(
 input clk,
      input signed[17:0] din,
      output reg signed[17:0] dout,
      input reset
   );
   reg signed[17:0] temp;
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

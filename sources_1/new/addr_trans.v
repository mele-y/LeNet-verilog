`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/21 15:57:37
// Design Name: 
// Module Name: addr_trans
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


module addr_trans(
         input[8:0] din,
         output reg[8:0] dout
    );
    always@(din)
    begin
    if(din<'d256)
     dout<=din;
    else
     dout<=din-'d256;
    end
endmodule

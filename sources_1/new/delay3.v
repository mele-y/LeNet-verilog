`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/10 13:27:41
// Design Name: 
// Module Name: delay3
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


module delay2(
    input clk,
    input reset,
    input din,
    output reg dout
    );
    reg a;
    initial begin
    a<=0;
    dout<=0;
    end
    always@(posedge clk or posedge reset)
    begin
       if(reset)
       begin
       a<=0;
       dout<=0;
       end
       else
       begin
        a<=din;
        dout<=a;
        end
    end
endmodule

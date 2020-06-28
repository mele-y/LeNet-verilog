`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/21 17:22:46
// Design Name: 
// Module Name: layer3_PE
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


module layer3_PE(
     input clk,
     input reset,
     input signed[15:0] bias,
     input signed[17:0] din1,
     input signed[15:0] din2,
     input ena,
     output reg signed[15:0] dout,
     output reg finish
    );
    initial begin
         dout<=0;
         count<=0;
         finish<=0;
    end
    reg[8:0] count;
    wire signed[15:0] temp;
    mul18_16 m(.a(din1),.b(din2),.q(temp));
   always@(posedge clk or posedge reset)
   begin
     if(reset)
     begin
        dout<=0;
        count=0;
        finish<=0;
     end
     else
     begin
        if(ena)
        begin
            dout=dout+temp;
            count=count+1;
        end
        if(count=='d256)
        begin
         dout=dout+bias;
         if(dout<0)
            dout=0;
         finish=1;
        end
        else
         finish=0;
    end     
   end
endmodule

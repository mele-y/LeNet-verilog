`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/27 09:03:31
// Design Name: 
// Module Name: layer4_PE
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


module layer4_PE(
        input clk,
        input reset,
        input signed[15:0] bias,
        input signed[15:0] din1,
        input signed[15:0] din2,
        input ena,
        output reg signed[15:0] dout,
        output reg finish
    );

    reg[8:0] count;
    wire signed[15:0] temp;
    mult16_16 m(.a(din1),.b(din2),.q(temp));
    initial begin
     count<=0;
     finish<=0;
     dout=0;
    end
    always@(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            count<=0;
            dout<=0;
            finish<=0;
        end
        else
        begin
            if(ena)
            begin
                dout=dout+temp;
                count=count+1;
                if(count=='d120)
                begin
                dout=dout+bias;
                if(dout<0)
                    dout=0;
                finish=1;
                end
            end            
            else
             finish=0;
        end
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/28 10:02:35
// Design Name: 
// Module Name: layer5_PE
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


module layer5_PE(
         input clk,
         input reset,
         input signed[15:0] bias,
         input signed[15:0] din1,
         input signed[15:0] din2,
         input ena,
         output reg signed[17:0] dout,
         output reg finish
    );
        reg[8:0] count;
        wire signed[15:0] temp;
        mult16_16 m(.a(din1),.b(din2),.q(temp));
        initial begin
            dout<=0;
            finish<=0;
            count<=0;
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
                    if(count=='d84)
                    begin
                        dout=dout+bias;
                        $display("%d",dout);
                        //$finish();
                         finish=1;
                    end
                    else
                     finish=0;
                end
                else
                  finish=0;
            end
            
        end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/08 18:06:35
// Design Name: 
// Module Name: layer2_input
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


module layer1_saver(
    input clk,
   // input reset,
    input pool_out,
    input pool_finish,
    input signed[15:0] datain,
    output reg signed[15:0] dataout,
    output reg w,
    output reg[8:0] addr,
    output reg flag,
    output reg save_finish
    );
   // reg flag;//0则存储在上半区，1则存储在下半区，实现ping-pong buffer
    reg clk_delay;
    reg[7:0] count;
    initial
    begin
    addr<=0;
    w<=0;
    flag<=0;
    count<=0;
    clk_delay<=0;
    save_finish<=0;
    end

    always@(posedge clk )
    begin
    /*
       if(reset)
       begin
       dataout<=0;
            count<=0;
            addr<=0;
            w<=0;
       end
       else*/

        if(pool_out)
        begin
            dataout=datain;
            w=1;
            if(flag)
                addr=200+count;
            else
                addr=count;
            if(count>=143)
                begin
                  flag=flag+1;
                  save_finish=1;
                  //$display("%d,%d,%d",count,flag,save_finish);
                end
                else
                   save_finish<=0;
            if(count<'d143)
                count=count+1;
            else
               count=0; 
                     //$display("din:%d,dout:%d,w:%d,addr:%d,count:%d",datain,dataout,w,addr,count);          
         end
         else
            w=0;
     end
    
endmodule

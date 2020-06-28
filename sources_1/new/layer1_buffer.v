`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/31 18:22:21
// Design Name: 
// Module Name: layer1_buffer
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


module layer1_buffer(
    input signed[15:0] datain,
    input clk,
    input save,
    output reg signed[15:0] dataout,
    output reg layer2_en
    );
    reg signed[15:0] buffer[0:319];
    reg[8:0] offset;
    reg[8:0] count;
    reg[8:0] addr;
    reg flag,flag2;
    reg save_com;
    reg read_start;
    initial begin
    count<=0;
    flag<=0;
    offset<=0;
    flag2<=0;
    save_com<=0;
    read_start<=0;
    addr<=0;
    end
    always@(posedge clk)
    begin
     if(save)
     begin
        if(flag)
            offset='d160;
        else
            offset='d0;
         buffer[offset+count]=datain;
         count=count+1;
         if(count=='d144)
         begin
          count=0;
          flag=~flag;
          save_com=1;
         end
     end
     else
        save_com=0;
    end
    always@(posedge clk)
    begin
        if(save_com)
            read_start=1;
        if(read_start)
        begin
            if(!flag2)
                dataout=buffer[addr];
            else
                dataout=buffer[addr+160];
              //  $display("%d,%d",dataout,addr);
            layer2_en=1;
            addr=addr+1;
            if(addr=='d160)
            begin
                addr=0;
                flag2=~flag2;
                read_start=0;
            end 
        end
        else
            layer2_en=0;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/20 16:01:13
// Design Name: 
// Module Name: layer3_input
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


module layer3_input(
    input clk,
    input save_finish,
    input flag,
    output reg[8:0] addr,
    output reg rea
    );
    reg read_start;
    reg[8:0] offset;
    reg[8:0] read_count;
    initial begin
     addr<=0;
     rea<=0;
     read_start<=0;
     offset<=0;
     read_count<=0;
    end
    always@(posedge clk)
    begin
      if(save_finish)
      begin
        read_start<=1;
        if(flag)
            offset<=0;
        else
            offset<=256;
      end
      if(read_count=='d256)
       read_start<=0;
    end
    always@(posedge clk)
    begin
     if(read_start)
     begin
        rea=1;
        addr=read_count+offset;
     if(read_count<'d256)
        read_count=read_count+1;
     else
        read_count=0;
       // $display("%d,%d",rea,addr);
    end
    else
      rea<=0;
    end

endmodule

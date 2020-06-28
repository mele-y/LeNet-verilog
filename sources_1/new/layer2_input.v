`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 13:52:18
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


module layer2_input(
        input clk,
       // input reset,
        input flag,
        input save_finish,
        output reg[8:0]addr,
        output reg read_enable

    );
      reg read_start;
      reg[8:0] read_count;
      reg[8:0] offset;
      initial begin
       read_count<=0;
       read_start<=0;
       read_enable<=0;
      end
   always@(posedge clk)
        begin
           if(save_finish)
           begin 
             read_start<=1;
             if(flag)
                offset<=0;
             else
                 offset<=200;
             // $display("flag:%d",flag);     
           end        
         if(read_count=='d199)
              read_start<=0; 
      end
      always@(posedge clk )
      begin  
         if(read_start)
         begin
            read_enable<=1;
            addr<=offset+read_count;
            if(read_count=='d199)
            begin
              // $finish();
               read_count<=0;
            end
            else
              read_count<=read_count+1;
         // $display("enable:%d,addr:%d,read_count:%d",read_enable,addr,read_count);
         end
         else
         begin
           read_enable<=0;
         end
      end
endmodule

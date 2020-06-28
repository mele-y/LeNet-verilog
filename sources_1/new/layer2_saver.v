`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/19 21:32:56
// Design Name: 
// Module Name: layer2_saver
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


module layer2_saver(
           input clk,
           input signed[17:0] din,
           input save,
           output reg save_finish,
           output reg signed[17:0] dout,
           output reg[8:0] addr,
           output reg flag,
           output reg w
    );
      reg[8:0] count;
      initial begin
       count<=0;
       dout<=0;
       w<=0;
       flag<=0;
       addr<=0;
       save_finish<=0;
      end
      always@(posedge clk )
      begin
          if(save)
          begin
             dout<=din;
             w<=1;
           if(flag)
              addr<=count+256;
           else
              addr<=count;
           if(count<'d255)
              count<=count+1;
           else
               count<=0;
          end
          else
            w<=0;         
        if(count>=255)
            begin
             flag<=flag+1;
             save_finish<=1;
            end
           else
             save_finish<=0; 
      end
     /* always@(posedge clk)
      begin
         if(w)
          $display("%d,%d",addr,dout);
      end*/
      
endmodule

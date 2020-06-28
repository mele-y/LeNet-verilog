`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 11:56:36
// Design Name: 
// Module Name: layer1_weight_load
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


module layer1_weight_load(
     input clk,
     output  signed[95:0] weights,
     output reg wen
    );
     reg[4:0] addr;
     reg[4:0] count;
     reg enable;
     layer1_weight m(.clka(clk),.addra(addr),.ena(enable),.douta(weights));
     initial begin
     addr<=0;
     enable<=1;
     count<=0;
     end
     
     always@(posedge clk)
     begin
         if(enable)
         begin
          if(count<30)
           count<=count+1;
          else
           count<=count;
          if(addr<24)
            addr<=addr+1;
          else
           addr<=addr;
         end
        
     end
     always@(posedge clk)
     begin
            if(count<1)
                wen<=0;
            else
                wen<=1;
              
     end
endmodule

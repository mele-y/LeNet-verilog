`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 12:25:17
// Design Name: 
// Module Name: layer1
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


module layer1(
          input clk,
          input reset,
          input signed[95:0] weights,
          input wen,
          input signed[15:0] datain,
          input enable,
          output[95:0] dout,
          output[5:0] layer1_out,
          output[5:0] layer1_finish
    );   
      
        wire en;
         delay2 d(.clk(clk),.din(enable),.dout(en),.reset(reset));
         wire  signed[15:0] weight[0:5];
         wire signed[15:0]  bias[0:5];
        assign bias[0]=16'b10000111001;
         assign bias[1]=16'b10010001111;
         assign bias[2]=16'b1010100011;
         assign bias[3]=16'b1010100101;
         assign bias[4]=16'b10000110001;
         assign bias[5]=16'b1001011110;
         assign {weight[0],weight[1],weight[2],weight[3],weight[4],weight[5]}=weights;
         genvar k;
         wire signed[15:0] conv_dout[0:5];
         wire conv_out[0:5];
         wire conv_finish[0:5];
         wire pool_out[0:5];
         wire pool_finish[0:5];
         wire signed[15:0] pool_dout[0:5];
         reg[10:0] count;
         assign dout={pool_dout[0],pool_dout[1],pool_dout[2],pool_dout[3],pool_dout[4],pool_dout[5]};
         assign layer1_out={pool_out[0],pool_out[1],pool_out[2],pool_out[3],pool_out[4],pool_out[5]};
         assign layer1_finish={pool_finish[0],pool_finish[1],pool_finish[2],pool_finish[3],pool_finish[4],pool_finish[5]};
         //layer1_conv_PE pe(.clk(clk),.reset(reset),.datain(datain),.enable(en),.weight(weight[0]),.weight_enable(wen),.bias(bias[0]),.conv_out(conv_out[0]),.conv_finish(conv_finish[0]),.dataout(conv_dout[0]));
         
         initial begin
             count=0;
         end
         
         generate 
         for(k=0;k<6;k=k+1)
         begin:label
            layer1_conv_PE pe(.clk(clk),.reset(reset),.datain(datain),.enable(en),.weight(weight[k]),.weight_enable(wen),.bias(bias[k]),.conv_out(conv_out[k]),.conv_finish(conv_finish[k]),.dataout(conv_dout[k]));
            layer1_maxpool pool(.clk(clk),.reset(reset),.enable(conv_out[k]),.datain(conv_dout[k]),.pool_out(pool_out[k]),.pool_finish(pool_finish[k]),.dataout(pool_dout[k]));
         end
         endgenerate
         always@(posedge clk)
         begin
            if(pool_out[0])
            begin
                count=count+1;
                if(count<='d144)
                $display("%d",pool_dout[0]);
            end
            if(pool_finish[0])
              $finish();
         end
         //layer1_maxpool pool(.clk(clk),.reset(reset),.enable(conv_out[0]),.datain(conv_dout[0]),.pool_out(pool_out[0]),.pool_finish(pool_finish[0]),.dataout(dout));
         /*
         always@(posedge clk)
         begin
         if(en)
         begin
          $display("%d,%d",datain,count);
          count=count+1;
         end
         end*/
       
 endmodule

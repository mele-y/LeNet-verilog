`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/28 09:55:13
// Design Name: 
// Module Name: layer5
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


module layer5(
       input clk,
       input reset,
       input signed[15:0] din,
       input[159:0] weight_in,
       input ena,
       output fc_finish,
       output [179:0] dout
    );
     wire signed[15:0] weights[0:9];
     wire signed[15:0] bias[0:9];
     wire en;
     wire signed[15:0] datain;
     //datadelay2 d2(.clk(clk),.din(din),.dout(datain),.reset(reset));
     //delay2 d1(.clk(clk),.din(ena),.dout(en),.reset(reset));
     genvar k;
     integer i;
     assign {weights[0],weights[1],weights[2],weights[3],weights[4],weights[5],weights[6],weights[7],weights[8],weights[9]}=weight_in;
     assign bias[0]=16'b1011011;
     assign bias[1]=16'b10010011;
     assign bias[2]=16'b110001100;
     assign bias[3]=16'b11101001;
     assign bias[4]=16'b100010;
     assign bias[5]=16'b1001110;
     assign bias[6]=16'b1100100;
     assign bias[7]=16'b1101111;
     assign bias[8]=16'b101011011;
     assign bias[9]=16'b101111010;
     wire finish[0:9];
     wire signed[17:0] result[0:9];
     generate
     for(k=0;k<10;k=k+1)
     begin:mult_add
        layer5_PE pe(.clk(clk),.reset(reset),.bias(bias[k]),.din1(din),.din2(weights[k]),.ena(ena),.finish(finish[k]),.dout(result[k]));
     end
     endgenerate
     assign fc_finish=finish[0];
     assign dout={result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9]};
     /*
     always@(posedge clk)
     begin
        if(en)
        $display("%d",datain);
     end*/
endmodule

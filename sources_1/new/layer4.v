`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/27 08:59:02
// Design Name: 
// Module Name: layer4
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


module layer4(
        input clk,
        input reset,
        input signed[15:0] din,
        input [1343:0] weight_in,
        input ena,
        output [1343:0] dout,
        output  save,
        output fc_finish
    );
    wire en;
    wire signed[15:0] datain;
    //delay2 d(.clk(clk),.din(ena),.dout(en),.reset(reset));
    //datadelay2 d1(.clk(clk),.din(din),.dout(datain));
    wire signed[15:0] weights[0:83];
    assign {weights[0],weights[1],weights[2],weights[3],weights[4],weights[5],weights[6],weights[7],weights[8],weights[9],weights[10],weights[11],weights[12],weights[13],weights[14],weights[15],weights[16],weights[17],weights[18],weights[19],weights[20],weights[21],weights[22],weights[23],weights[24],weights[25],weights[26],weights[27],weights[28],weights[29],weights[30],weights[31],weights[32],weights[33],weights[34],weights[35],weights[36],weights[37],weights[38],weights[39],weights[40],weights[41],weights[42],weights[43],weights[44],weights[45],weights[46],weights[47],weights[48],weights[49],weights[50],weights[51],weights[52],weights[53],weights[54],weights[55],weights[56],weights[57],weights[58],weights[59],
    weights[60],weights[61],weights[62],weights[63],weights[64],weights[65],weights[66],weights[67],weights[68],weights[69],weights[70],weights[71],weights[72],weights[73],weights[74],weights[75],weights[76],weights[77],weights[78],weights[79],weights[80],weights[81],weights[82],weights[83]}=weight_in;
    wire signed[15:0] bias[0:83];
    assign bias[0]=16'b11100001;
    assign bias[1]=16'b11101100;
    assign bias[2]=16'b11011110;
    assign bias[3]=16'b11011011;
    assign bias[4]=16'b11110111;
    assign bias[5]=16'b11100011;
    assign bias[6]=16'b10110100;
    assign bias[7]=16'b11111010;
    assign bias[8]=16'b10110011;
    assign bias[9]=16'b10111110;
    assign bias[10]=16'b10101011;
    assign bias[11]=16'b11000100;
    assign bias[12]=16'b11000100;
    assign bias[13]=16'b11101010;
    assign bias[14]=16'b11100011;
    assign bias[15]=16'b11000001;
    assign bias[16]=16'b10101101;
    assign bias[17]=16'b10101011;
    assign bias[18]=16'b10110110;
    assign bias[19]=16'b11000011;
    assign bias[20]=16'b11101100;
    assign bias[21]=16'b10101110;
    assign bias[22]=16'b10111011;
    assign bias[23]=16'b100001111;
    assign bias[24]=16'b11001111;
    assign bias[25]=16'b10101011;
    assign bias[26]=16'b11010011;
    assign bias[27]=16'b11100100;
    assign bias[28]=16'b10111111;
    assign bias[29]=16'b11001000;
    assign bias[30]=16'b11001011;
    assign bias[31]=16'b10111110;
    assign bias[32]=16'b10100100;
    assign bias[33]=16'b11011010;
    assign bias[34]=16'b10101010;
    assign bias[35]=16'b11101000;
    assign bias[36]=16'b11000101;
    assign bias[37]=16'b100000111;
    assign bias[38]=16'b11110001;
    assign bias[39]=16'b11001011;
    assign bias[40]=16'b100001110;
    assign bias[41]=16'b100011010;
    assign bias[42]=16'b10100101;
    assign bias[43]=16'b11010110;
    assign bias[44]=16'b11110011;
    assign bias[45]=16'b11001100;
    assign bias[46]=16'b11111110;
    assign bias[47]=16'b11010111;
    assign bias[48]=16'b10111011;
    assign bias[49]=16'b11010000;
    assign bias[50]=16'b11000011;
    assign bias[51]=16'b11010100;
    assign bias[52]=16'b100001111;
    assign bias[53]=16'b11011101;
    assign bias[54]=16'b11011110;
    assign bias[55]=16'b11100110;
    assign bias[56]=16'b11010011;
    assign bias[57]=16'b11100110;
    assign bias[58]=16'b11010001;
    assign bias[59]=16'b10110011;
    assign bias[60]=16'b100010011;
    assign bias[61]=16'b11100000;
    assign bias[62]=16'b11010101;
    assign bias[63]=16'b11101000;
    assign bias[64]=16'b11011110;
    assign bias[65]=16'b11001101;
    assign bias[66]=16'b11101000;
    assign bias[67]=16'b11011000;
    assign bias[68]=16'b100010001;
    assign bias[69]=16'b10110100;
    assign bias[70]=16'b11000110;
    assign bias[71]=16'b11111001;
    assign bias[72]=16'b100000011;
    assign bias[73]=16'b11001010;
    assign bias[74]=16'b10111010;
    assign bias[75]=16'b11010111;
    assign bias[76]=16'b10110100;
    assign bias[77]=16'b11110110;
    assign bias[78]=16'b11011000;
    assign bias[79]=16'b11110011;
    assign bias[80]=16'b11110010;
    assign bias[81]=16'b11001101;
    assign bias[82]=16'b11001101;
    assign bias[83]=16'b11001100;

    wire signed[15:0] result[0:83];
    assign dout={result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15],result[16],result[17],result[18],result[19],result[20],result[21],result[22],result[23],result[24],result[25],result[26],result[27],result[28],result[29],result[30],result[31],result[32],result[33],result[34],result[35],result[36],result[37],result[38],result[39],result[40],result[41],result[42],result[43],result[44],result[45],result[46],result[47],result[48],result[49],result[50],result[51],result[52],result[53],result[54],result[55],result[56],result[57],result[58],result[59],result[60],result[61],result[62],result[63],result[64],result[65],result[66],result[67],result[68],result[69],result[70],result[71],result[72],result[73],result[74],result[75],result[76],result[77],result[78],result[79],result[80],result[81],result[82],result[83]};
    wire finish[0:83];
    assign save= finish[0];
    integer i;
    genvar k;
    generate
    for(k=0;k<84;k=k+1)
    begin:mult_add
         layer4_PE pe(.clk(clk),.reset(reset),.bias(bias[k]),.din1(din),.din2(weights[k]),.ena(ena),.dout(result[k]),.finish(finish[k]));
    end
    endgenerate
  assign fc_finish=finish[0];
    
    /*
    always@(posedge clk)
    begin
        if(finish[0])
        begin
        for(i=0;i<84;i=i+1)
           $display("%d,%d",i,result[i]);
        end
    end*/
endmodule
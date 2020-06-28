`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/20 19:03:42
// Design Name: 
// Module Name: layer3
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


module layer3(
        input clk,
        input reset,
        input signed[17:0] din,
        input[1919:0] weight_in,
        input ena,
        output[0:1919] dout,
        output  save,
        output fc_finish
    );
      wire signed[15:0] weights[0:119];
      wire signed[15:0] bias[0:119];
 assign bias[0]=16'b11001111;
      assign bias[1]=16'b100001000;
      assign bias[2]=16'b10011010;
      assign bias[3]=16'b11101001;
      assign bias[4]=16'b11000010;
      assign bias[5]=16'b100000100;
      assign bias[6]=16'b11000100;
      assign bias[7]=16'b10110010;
      assign bias[8]=16'b10011101;
      assign bias[9]=16'b11101010;
      assign bias[10]=16'b10100011;
      assign bias[11]=16'b11001000;
      assign bias[12]=16'b11011110;
      assign bias[13]=16'b11001110;
      assign bias[14]=16'b11100101;
      assign bias[15]=16'b11001011;
      assign bias[16]=16'b11010100;
      assign bias[17]=16'b11010000;
      assign bias[18]=16'b10100000;
      assign bias[19]=16'b10101011;
      assign bias[20]=16'b11100010;
      assign bias[21]=16'b11110010;
      assign bias[22]=16'b11010000;
      assign bias[23]=16'b11010100;
      assign bias[24]=16'b10111010;
      assign bias[25]=16'b11001100;
      assign bias[26]=16'b11011101;
      assign bias[27]=16'b11001100;
      assign bias[28]=16'b10101111;
      assign bias[29]=16'b11101101;
      assign bias[30]=16'b11010110;
      assign bias[31]=16'b11000001;
      assign bias[32]=16'b11010101;
      assign bias[33]=16'b10111110;
      assign bias[34]=16'b100011110;
      assign bias[35]=16'b11100011;
      assign bias[36]=16'b11000000;
      assign bias[37]=16'b11010000;
      assign bias[38]=16'b10010000;
      assign bias[39]=16'b11001001;
      assign bias[40]=16'b11001010;
      assign bias[41]=16'b11001001;
      assign bias[42]=16'b10100011;
      assign bias[43]=16'b10101100;
      assign bias[44]=16'b11110101;
      assign bias[45]=16'b11110010;
      assign bias[46]=16'b11100101;
      assign bias[47]=16'b11010011;
      assign bias[48]=16'b11101101;
      assign bias[49]=16'b10101000;
      assign bias[50]=16'b11001100;
      assign bias[51]=16'b11101011;
      assign bias[52]=16'b11011100;
      assign bias[53]=16'b11000101;
      assign bias[54]=16'b11001011;
      assign bias[55]=16'b11001100;
      assign bias[56]=16'b11110000;
      assign bias[57]=16'b11101000;
      assign bias[58]=16'b11010010;
      assign bias[59]=16'b11010011;
      assign bias[60]=16'b11011101;
      assign bias[61]=16'b10110011;
      assign bias[62]=16'b10110111;
      assign bias[63]=16'b100011010;
      assign bias[64]=16'b11001001;
      assign bias[65]=16'b11001100;
      assign bias[66]=16'b10110111;
      assign bias[67]=16'b11100011;
      assign bias[68]=16'b11010001;
      assign bias[69]=16'b11010111;
      assign bias[70]=16'b100001110;
      assign bias[71]=16'b11110111;
      assign bias[72]=16'b11100111;
      assign bias[73]=16'b11010100;
      assign bias[74]=16'b100001011;
      assign bias[75]=16'b11100000;
      assign bias[76]=16'b11010101;
      assign bias[77]=16'b11111111;
      assign bias[78]=16'b10110110;
      assign bias[79]=16'b10111010;
      assign bias[80]=16'b11000010;
      assign bias[81]=16'b11111110;
      assign bias[82]=16'b11001100;
      assign bias[83]=16'b11010110;
      assign bias[84]=16'b10001101;
      assign bias[85]=16'b11001100;
      assign bias[86]=16'b11000010;
      assign bias[87]=16'b11011100;
      assign bias[88]=16'b11100100;
      assign bias[89]=16'b10110011;
      assign bias[90]=16'b11111001;
      assign bias[91]=16'b10111110;
      assign bias[92]=16'b11000001;
      assign bias[93]=16'b11011001;
      assign bias[94]=16'b11001111;
      assign bias[95]=16'b100101001;
      assign bias[96]=16'b11100110;
      assign bias[97]=16'b11000010;
      assign bias[98]=16'b100010000;
      assign bias[99]=16'b11010110;
      assign bias[100]=16'b11010010;
      assign bias[101]=16'b11011000;
      assign bias[102]=16'b10110000;
      assign bias[103]=16'b100000101;
      assign bias[104]=16'b10010111;
      assign bias[105]=16'b10001110;
      assign bias[106]=16'b11011001;
      assign bias[107]=16'b11100010;
      assign bias[108]=16'b10111010;
      assign bias[109]=16'b10111100;
      assign bias[110]=16'b11000100;
      assign bias[111]=16'b11010110;
      assign bias[112]=16'b11010100;
      assign bias[113]=16'b11000001;
      assign bias[114]=16'b11101110;
      assign bias[115]=16'b100101100;
      assign bias[116]=16'b11110100;
      assign bias[117]=16'b11010101;
      assign bias[118]=16'b10111100;
      assign bias[119]=16'b10111100;


      reg [8:0] count;
      reg  en;
      integer i;
      initial begin
        count<=0;
      end     
       wire signed[15:0] result[0:119];
      wire finish[0:119];
      assign {weights[0],weights[1],weights[2],weights[3],weights[4],weights[5],weights[6],weights[7],weights[8],weights[9],weights[10],weights[11],weights[12],weights[13],weights[14],weights[15],weights[16],weights[17],weights[18],weights[19],weights[20],weights[21],weights[22],weights[23],weights[24],weights[25],weights[26],weights[27],weights[28],weights[29],weights[30],weights[31],weights[32],weights[33],weights[34],weights[35],weights[36],weights[37],weights[38],weights[39],weights[40],weights[41],weights[42],weights[43],weights[44],weights[45],weights[46],weights[47],weights[48],weights[49],weights[50],weights[51],weights[52],weights[53],weights[54],weights[55],weights[56],weights[57],weights[58],weights[59],
      weights[60],weights[61],weights[62],weights[63],weights[64],weights[65],weights[66],weights[67],weights[68],weights[69],weights[70],weights[71],weights[72],weights[73],weights[74],weights[75],weights[76],weights[77],weights[78],weights[79],weights[80],weights[81],weights[82],weights[83],weights[84],weights[85],weights[86],weights[87],weights[88],weights[89],weights[90],weights[91],weights[92],weights[93],weights[94],weights[95],weights[96],weights[97],weights[98],weights[99],weights[100],weights[101],weights[102],weights[103],weights[104],weights[105],weights[106],weights[107],weights[108],weights[109],weights[110],weights[111],weights[112],weights[113],weights[114],weights[115],weights[116],weights[117],weights[118],weights[119]}=weight_in;
      assign dout={result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15],result[16],result[17],result[18],result[19],result[20],result[21],result[22],result[23],result[24],result[25],result[26],result[27],result[28],result[29],result[30],result[31],result[32],result[33],result[34],result[35],result[36],result[37],result[38],result[39],result[40],result[41],result[42],result[43],result[44],result[45],result[46],result[47],result[48],result[49],result[50],result[51],result[52],result[53],result[54],result[55],result[56],result[57],result[58],result[59],result[60],result[61],result[62],result[63],result[64],result[65],result[66],result[67],result[68],result[69],result[70],result[71],result[72],result[73],result[74],result[75],result[76],result[77],result[78],result[79],result[80],result[81],result[82],result[83],result[84],result[85],result[86],result[87],result[88],result[89],result[90],result[91],result[92],result[93],result[94],result[95],result[96],result[97],result[98],result[99],result[100],result[101],result[102],result[103],result[104],result[105],result[106],result[107],result[108],result[109],result[110],result[111],result[112],result[113],result[114],result[115],result[116],result[117],result[118],result[119]};
      assign save=finish[0];
      //assign save={finish[0],finish[1],finish[2],finish[3],finish[4],finish[5],finish[6],finish[7],finish[8],finish[9],finish[10],finish[11],finish[12],finish[13],finish[14],finish[15],finish[16],finish[17],finish[18],finish[19],finish[20],finish[21],finish[22],finish[23],finish[24],finish[25],finish[26],finish[27],finish[28],finish[29],finish[30],finish[31],finish[32],finish[33],finish[34],finish[35],finish[36],finish[37],finish[38],finish[39],finish[40],finish[41],finish[42],finish[43],finish[44],finish[45],finish[46],finish[47],finish[48],finish[49],finish[50],finish[51],finish[52],finish[53],finish[54],finish[55],finish[56],finish[57],finish[58],finish[59],finish[60],finish[61],finish[62],finish[63],finish[64],finish[65],finish[66],finish[67],finish[68],finish[69],finish[70],finish[71],finish[72],finish[73],finish[74],finish[75],finish[76],finish[77],finish[78],finish[79],finish[80],finish[81],finish[82],finish[83],finish[84],finish[85],finish[86],finish[87],finish[88],finish[89],finish[90],finish[91],finish[92],finish[93],finish[94],finish[95],finish[96],finish[97],finish[98],finish[99],finish[100],finish[101],finish[102],finish[103],finish[104],finish[105],finish[106],finish[107],finish[108],finish[109],finish[110],finish[111],finish[112],finish[113],finish[114],finish[115],finish[116],finish[117],finish[118],finish[119]};
      genvar k;
      generate 
      for(k=0;k<120;k=k+1)
      begin: mult_add
       layer3_PE pe(.clk(clk),.reset(reset),.din1(din),.din2(weights[k]),.ena(ena),.dout(result[k]),.finish(finish[k]),.bias(bias[k]));
      end
      endgenerate
      assign fc_finish=finish[0];
      
      always@(posedge  clk or posedge reset)
      begin
        if(finish[0])
        begin
        for(i=0;i<120;i=i+1)
         $display(result[i]);
        end
      end
      
endmodule

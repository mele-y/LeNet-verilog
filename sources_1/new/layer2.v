`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/10 17:04:37
// Design Name: 
// Module Name: layer2
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


module layer2(
      input clk,
      //输入特征图
      input reset,
      input signed[15:0] datain1,
      input signed[15:0] datain2,
      input signed[15:0] datain3,
      input signed[15:0] datain4,
      input signed[15:0] datain5,
      input signed[15:0] datain6,
      //权值
      input signed[255:0] layer2_weight,

      //权值使能信号，每个使能信号控制16个PE
      input w1en,
      input w2en,
      input w3en,
      input w4en,
      input w5en,
      input w6en,
      //输入特征图使能信号
      input m1en,
      input m2en,
      input m3en,
      input m4en,
      input m5en,
      input m6en,
      output finish,
      
      output save,
      //output save_finish,
      output [286:0] layer2_dout
      //output[8:0] addr
    );
    integer count=0;
    wire signed[15:0] weight[0:15];
    wire conv_out[0:95];
    wire conv_finish[0:95];
    wire signed[15:0] conv_result[0:95]; 
    wire signed[15:0] bias[0:15];
    
    genvar k;
    assign {weight[0],weight[1],weight[2],weight[3],weight[4],weight[5],weight[6],weight[7],weight[8],weight[9],weight[10],weight[11],weight[12],weight[13],weight[14],weight[15]}=layer2_weight;
    assign bias[0]=16'b1001000010;
    assign bias[1]=16'b1101100001;
    assign bias[2]=16'b1100100101;
    assign bias[3]=16'b1100011110;
    assign bias[4]=16'b1111001011;
    assign bias[5]=16'b1000000011;
    assign bias[6]=16'b10001000110;
    assign bias[7]=16'b10001111100;
    assign bias[8]=16'b1101010010;
    assign bias[9]=16'b1100011000;
    assign bias[10]=16'b1101110001;
    assign bias[11]=16'b10000100011;
    assign bias[12]=16'b1110110011;
    assign bias[13]=16'b1111101011;
    assign bias[14]=16'b10000001111;
    assign bias[15]=16'b1100011000;
 
   // layer2_conv_PE conv(.clk(clk),.reset(reset),.datain(datain1),.enable(m1en),.weight(weight[0]),.weight_enable(w1en),.conv_out(conv_out[0]),.conv_finish(conv_finish[0]),.dataout(conv_result[0]));  
    
    //map1对应的16个卷积PE
    
    generate
    for(k=0;k<16;k=k+1)
    begin:label1
       layer2_conv_PE conv(.clk(clk),.reset(reset),.datain(datain1),.enable(m1en),.weight(weight[k]),.weight_enable(w1en),.conv_out(conv_out[k]),.conv_finish(conv_finish[k]),.dataout(conv_result[k]));    
    end
    endgenerate
   //map2对应的16个卷积PE
    generate
    for(k=0;k<16;k=k+1)
    begin:label2
       layer2_conv_PE conv(.clk(clk),.reset(reset),.datain(datain2),.enable(m2en),.weight(weight[k]),.weight_enable(w2en),.conv_out(conv_out[k+16]),.conv_finish(conv_finish[k+16]),.dataout(conv_result[k+16])); 
    end
    endgenerate
    
    generate
    for(k=0;k<16;k=k+1)
    begin:label3
       layer2_conv_PE conv(.clk(clk),.reset(reset),.datain(datain3),.enable(m3en),.weight(weight[k]),.weight_enable(w3en),.conv_out(conv_out[k+32]),.conv_finish(conv_finish[k+32]),.dataout(conv_result[k+32]));    
    end
    endgenerate
    

    generate
    for(k=0;k<16;k=k+1)
    begin:label4
       layer2_conv_PE conv(.clk(clk),.reset(reset),.datain(datain4),.enable(m4en),.weight(weight[k]),.weight_enable(w4en),.conv_out(conv_out[k+48]),.conv_finish(conv_finish[k+48]),.dataout(conv_result[k+48]));    
    end
    endgenerate
    
    generate
    for(k=0;k<16;k=k+1)
    begin:label5
       layer2_conv_PE conv(.clk(clk),.reset(reset),.datain(datain5),.enable(m5en),.weight(weight[k]),.weight_enable(w5en),.conv_out(conv_out[k+64]),.conv_finish(conv_finish[k+64]),.dataout(conv_result[k+64]));    
    end
    endgenerate
        generate
    for(k=0;k<16;k=k+1)
    begin:label6
       layer2_conv_PE conv(.clk(clk),.reset(reset),.datain(datain6),.enable(m6en),.weight(weight[k]),.weight_enable(w6en),.conv_out(conv_out[k+80]),.conv_finish(conv_finish[k+80]),.dataout(conv_result[k+80]));    
    end
    endgenerate
    
   // addr_6 ad(.clk(clk),.reset(reset),.datain1(conv_result[0]),.datain2(conv_result[16]),.datain3(conv_result[32]),.datain4(conv_result[48]),.datain5(conv_result[64]),.datain6(conv_result[80])
  //  ,.en1(conv_out[0]),.en2(conv_out[1]),.en3(conv_out[2]),.en4(conv_out[3]),.en5(conv_out[4]),.en6(conv_out[5]),.bias(bias[0]));
    wire signed[17:0] din[0:15];
    wire add_out[0:15];
    wire signed[17:0] pool_result[0:15];
    wire pool_out[0:15];
    wire pool_finish[0:15];
    
    generate
    for(k=0;k<16;k=k+1)
    begin:add
      addr_6 ad(.clk(clk),.reset(reset),.datain1(conv_result[k]),.datain2(conv_result[k+16]),.datain3(conv_result[k+32]),.datain4(conv_result[k+48]),.datain5(conv_result[k+64]),.datain6(conv_result[k+80])
        ,.en1(conv_out[k]),.en2(conv_out[k+16]),.en3(conv_out[k+32]),.en4(conv_out[k+48]),.en5(conv_out[k+64]),.en6(conv_out[k+80]),.bias(bias[k]),.dout(din[k]),.add_out(add_out[k]));
      layer2_maxpool pool(.clk(clk),.reset(reset),.datain(din[k]),.enable(add_out[k]),.pool_out(pool_out[k]),.pool_finish(pool_finish[k]),.dataout(pool_result[k]));
    end
    endgenerate
    //wire save;
    //wire save_finish;
    //wire signed[17:0] layer2_dout;
    //wire[8:0] addr;
    //layer2_buffer buffer(.clk(clk),.reset(reset),.datain1(pool_result[0]),.datain2(pool_result[1]),.datain3(pool_result[2]),.datain4(pool_result[3]),.datain5(pool_result[4]),.datain6(pool_result[5]),.datain7(pool_result[6]),.datain8(pool_result[7]),.datain9(pool_result[8]),.datain10(pool_result[9]),.datain11(pool_result[10]),.datain12(pool_result[11]),.datain13(pool_result[12]),.datain14(pool_result[13]),.datain15(pool_result[14]),.datain16(pool_result[15])
    //,.en1(pool_out[0]),.en2(pool_out[1]),.en3(pool_out[2]),.en4(pool_out[3]),.en5(pool_out[4]),.en6(pool_out[5]),.en7(pool_out[6]),.en8(pool_out[7]),.en9(pool_out[8]),.en10(pool_out[9]),.en11(pool_out[10]),.en12(pool_out[11]),.en13(pool_out[12]),.en14(pool_out[13]),.en15(pool_out[14]),.en16(pool_out[15]),.save(save),.save_finish(save_finish),.dout(layer2_dout),.addr(addr));
    //layer2_maxpool pool(.clk(clk),.reset(reset),.datain(din[0]),.enable(add_out[0]));
    assign finish=pool_finish[0];
    assign save=pool_out[0];
    assign layer2_dout={pool_result[0],pool_result[1],pool_result[2],pool_result[3],pool_result[4],pool_result[5],pool_result[6],pool_result[7],pool_result[8],pool_result[9],pool_result[10],pool_result[11],pool_result[12],pool_result[13],pool_result[14],pool_result[15]};

    
endmodule

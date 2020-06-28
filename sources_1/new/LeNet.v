`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 12:34:08
// Design Name: 
// Module Name: LeNet
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


module LeNet(
         input clk,
         input signed[15:0] map_in,
         input en,
         output [3:0] class,
         output layer1_finish
    );

     //reg clk,en;
     wire en2;//layer1使能信号
     reg signed[15:0] datain;
    // wire   signed[15:0] map_in
     reg layer1_reset;//
     wire signed[95:0] weights;
     wire wen; 
    // input_rom m(.clka(clk),.addra(addr),.douta(map_in));
     layer1_weight_load layer1_weight(.clk(clk),.weights(weights),.wen(wen));
    
     wire  signed[15:0] l1_dout[0:5];
     wire pool_out[0:5];
     wire pool_finish[0:5];
     layer1 L1(.clk(clk),.reset(layer1_reset),.weights(weights),.wen(wen),.datain(map_in),.enable(en),.dout({l1_dout[0],l1_dout[1],l1_dout[2],l1_dout[3],l1_dout[4],l1_dout[5]})
     ,.layer1_out({pool_out[0],pool_out[1],pool_out[2],pool_out[3],pool_out[4],pool_out[5]})
     ,.layer1_finish({pool_finish[0],pool_finish[1],pool_finish[2],pool_finish[3],pool_finish[4],pool_finish[5]}));
     assign layer1_finish=pool_finish[0];
      wire signed[15:0] saver_dout[0:5];
      wire w[0:5];
      wire[8:0] save_addr[0:5];
      wire flag[0:5];
      wire save_finish[0:5];
      wire [8:0] read_addr[0:5];
      wire read_enable[0:5];
      wire signed[15:0] l2_din[0:5];
      wire conv2_enable[0:5];  
        reg layer2_reset;
      genvar k;
      generate
        for(k=0;k<6;k=k+1)
        begin:save
          layer1_saver saver(.clk(clk),.pool_out(pool_out[k]),.pool_finish(pool_finish[k]),.datain(l1_dout[k]),.dataout(saver_dout[k]),.w(w[k]),.addr(save_addr[k]),.flag(flag[k]),.save_finish(save_finish[k]));
          layer2_input read(.clk(clk),.flag(flag[k]),.save_finish(save_finish[k]),.addr(read_addr[k]),.read_enable(read_enable[k]));
          layer1_ram map_ram(.clka(clk),.addra(save_addr[k]),.dina(saver_dout[k]),.wea(w[k]),.clkb(clk),.enb(read_enable[k]),.doutb(l2_din[k]),.addrb(read_addr[0]));
          delay2 delay(.clk(clk),.din(read_enable[k]),.dout(conv2_enable[k]),.reset(layer2_reset));
        end
      endgenerate
      
     wire [255:0] layer2_weight;//输出weight
     wire w_enable[0:5];
     layer2_weight_load weight_load2(.clk(clk),.layer2_weight(layer2_weight),.enable1(w_enable[0]),.enable2(w_enable[1]),.enable3(w_enable[2]),.enable4(w_enable[3]),.enable5(w_enable[4]),.enable6(w_enable[5]));
     
     

    wire layer2_finish;
    wire save2;
    
    wire [286:0] layer2_dout;
    wire[7:0] addr2;
     layer2 l2(.clk(clk),.reset(layer2_reset),.datain1(l2_din[0]),.datain2(l2_din[1]),.datain3(l2_din[2]),.datain4(l2_din[3]),.datain5(l2_din[4]),.datain6(l2_din[5]),.layer2_weight(layer2_weight),.w1en(w_enable[0]),.w2en(w_enable[1]),.w3en(w_enable[2]),.w4en(w_enable[3]),.w5en(w_enable[4]),.w6en(w_enable[5])
     ,.m1en(conv2_enable[0]),.m2en(conv2_enable[1]),.m3en(conv2_enable[2]),.m4en(conv2_enable[3]),.m5en(conv2_enable[4]),.m6en(conv2_enable[5]),.save(save2),.layer2_dout(layer2_dout),.finish(layer2_finish));
     
      wire signed[17:0] layer3_din;
       wire l3_ena;
     layer2_buffer l2_buffer(.clk(clk),.save(save2),.din(layer2_dout),.addr(addr2),.dout(layer3_din),.layer3_en(l3_ena));
     
     

    // layer2_saver saver2(.clk(clk),.din(layer2_dout),.save(save2),.save_finish(save2_finish),.dout(ram_in),.addr(addr2),.flag(flag2),.w(w2));
    // layer3_input reader2(.clk(clk),.flag(flag2),.save_finish(save2_finish),.addr(addrb),.rea(rea));
    
   // layer2_ram l2ram(.clka(clk),.dina(ram_in),.addra(addr2),.wea(w2),.clkb(clk),.addrb(addrb),.enb(rea),.doutb(layer3_din));
    wire[1919:0] l3_weight;
    wire layer3_enable;
    wire signed[17:0] l3_din;
    layer3_weight_rom l3rom(.clka(clk),.addra(addr2),.ena(l3_ena),.douta(l3_weight));
    reg layer3_reset;
    delay2 d2(.clk(clk),.din(l3_ena),.dout(layer3_enable),.reset(layer3_reset));
    data18delay2 d3(.clk(clk),.din(layer3_din),.reset(layer3_reset),.dout(l3_din));
    wire [0:1919] l3_dout;
    wire l3_save;
    wire layer3_finish;
    layer3 l3(.clk(clk),.reset(layer3_reset),.din(l3_din),.weight_in(l3_weight),.ena(layer3_enable),.dout(l3_dout),.save(l3_save),.fc_finish(layer3_finish));
    
    wire layer4_en;
    wire l4en;
    wire signed[15:0] l4_din,layer4_din;
    wire[6:0] l4_weight_addr;
    reg layer4_reset;
    layer3_buffer l3_bf(.clk(clk),.din(l3_dout),.save(l3_save),.layer4_en(layer4_en),.dout(l4_din),.addr(l4_weight_addr));
    delay2 d4(.clk(clk),.din(layer4_en),.dout(l4en),.reset(layer4_reset));
    datadelay2 d5(.clk(clk),.reset(layer4_reset),.din(l4_din),.dout(layer4_din));
    wire[1343:0] l4_weight;
    wire[1343:0] l4_dout;
    layer4_weight_rom l4_rom(.clka(clk),.addra(l4_weight_addr),.ena(layer4_en),.douta(l4_weight));
    
    wire l4_save;
    wire layer4_finish;
    layer4 l4(.clk(clk),.reset(layer4_reset),.din(layer4_din),.ena(l4en),.weight_in(l4_weight),.dout(l4_dout),.save(l4_save),.fc_finish(layer4_finish));
    
    wire signed[15:0] layer5_din,l5_din;
    wire[6:0] l5_weight_addr;
    wire l5en;
    wire layer5_en;
    layer4_buffer l4bf(.clk(clk),.din(l4_dout),.save(l4_save),.dout(layer5_din),.addr(l5_weight_addr),.layer5_en(layer5_en));
    reg layer5_reset;
    delay2 d6(.clk(clk),.din(layer5_en),.dout(l5en),.reset(layer5_reset));
    datadelay2 d7(.clk(clk),.reset(layer5_reset),.din(layer5_din),.dout(l5_din));
    wire[159:0] l5_weight;
    layer5_weight_rom l5_weight_rom(.clka(clk),.addra(l5_weight_addr),.ena(l5en),.douta(l5_weight));
    
    wire layer5_finish;
    layer5 l5(.clk(clk),.reset(layer5_reset),.din(l5_din),.ena(l5en),.weight_in(l5_weight),.fc_finish(layer5_finish));
     initial begin
       layer1_reset=1;
       layer2_reset=1;
       datain=0;
       #1 layer1_reset=0;
       layer2_reset=0;
     end
     always@(posedge clk)
     begin
       if(layer1_finish)
       begin
         layer1_reset=1;
         #0.1 layer1_reset=0;
           $display("working1");
       end
      
      if(layer2_finish)
      begin
          layer2_reset=1;
         #0.1 layer2_reset=0;
         $display("working2");
      end
      
        if(layer3_finish)
      begin
      layer3_reset=1;
         #0.1 layer3_reset=0;
      end
      
       if(layer4_finish)
       begin
         layer4_reset=1;
         #0.1 layer4_reset=0;
       end
       
        if(layer5_finish)
        begin
     layer5_reset=1;
         #0.1 layer5_reset=0;
         end
     end
endmodule

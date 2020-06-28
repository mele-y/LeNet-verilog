`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/16 13:46:03
// Design Name: 
// Module Name: layer3_tb
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


module layer3_tb(
     input clk,
     wire signed[15:0] l4_din
    );
    //reg clk;
    reg layer3_reset;
    reg l3_ena;
    wire signed[17:0] layer3_din;
    reg [7:0] addr2;
    wire layer3_finish;
    //wire signed[17:0] l3_din;
    wire[1919:0] l3_weight;
    wire layer3_enable;
    wire[1919:0] l3_dout;
    wire l3_save;
    wire layer4_en;
    wire [7:0] l4_weight_addr;
   // wire layer3_finish;
    layer3_din_rom l3_din_rom(.clka(clk),.addra(addr2),.ena(l3_ena),.douta(layer3_din));
    delay2 d2(.clk(clk),.din(l3_ena),.dout(layer3_enable),.reset(layer3_reset));
    //data18delay2 d3(.clk(clk),.din(layer3_din),.reset(layer3_reset),.dout(l3_din));
    layer3_weight_rom l3rom(.clka(clk),.addra(addr2),.ena(l3_ena),.douta(l3_weight));
    layer3 l3(.clk(clk),.reset(layer3_reset),.din(layer3_din),.weight_in(l3_weight),.ena(layer3_enable),.dout(l3_dout),.save(l3_save),.fc_finish(layer3_finish));
    layer3_buffer l3_bf(.clk(clk),.din(l3_dout),.save(l3_save),.layer4_en(layer4_en),.dout(l4_din),.addr(l4_weight_addr));
    initial begin
     l3_ena<=1;
     layer3_reset<=0;
     addr2<=0;
    // clk<=0;
    end   
    always@(posedge clk)
    begin
      addr2<=addr2+1;
    end

endmodule

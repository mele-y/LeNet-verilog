`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/15 10:36:56
// Design Name: 
// Module Name: layer1_tb
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


module layer1_tb(
    input clk
    );
    //reg clk;
    reg layer1_reset;
    reg en;
    wire signed[15:0] datain;
    wire [95:0] weights;
    wire wen;
    reg[13:0] addr;
    layer1_weight_load layer1_weight(.clk(clk),.weights(weights),.wen(wen));
    wire  signed[15:0] l1_dout[0:5];
    wire pool_out[0:5];
    wire pool_finish[0:5];
    wire finish;
    assign finish=pool_finish[0];
    layer1 L1(.clk(clk),.reset(layer1_reset),.weights(weights),.wen(wen),.datain(datain),.enable(en),.dout({l1_dout[0],l1_dout[1],l1_dout[2],l1_dout[3],l1_dout[4],l1_dout[5]})
    ,.layer1_out({pool_out[0],pool_out[1],pool_out[2],pool_out[3],pool_out[4],pool_out[5]})
    ,.layer1_finish({pool_finish[0],pool_finish[1],pool_finish[2],pool_finish[3],pool_finish[4],pool_finish[5]}));
    input_rom m(.clka(clk),.douta(datain),.addra(addr));
    initial begin
         addr<=0;
       //  clk<=0;
         layer1_reset<=0;
         en<=1;
    end
    always@(posedge clk)
    begin
       addr<=addr+1;
    end
endmodule

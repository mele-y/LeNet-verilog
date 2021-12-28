`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 15:42:22
// Design Name: 
// Module Name: tb
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


module tb(
       
       output [3:0] index
    );
    reg clk;
    wire signed[15:0] map_in;
     reg[13:0] addr;
     reg[15:0] count;
     reg en;
     wire layer1_finish;
     wire finish;
     input_rom m(.clka(clk),.douta(map_in),.addra(addr));
     LeNet lenet(.clk(clk),.map_in(map_in),.en(en),.index(index),.layer1_finish(layer1_finish),.finish(finish));
    //wire next_image;
    //delay1 d(.clk(clk),.din(layer1_finish),.dout(next_image));
    initial begin
    en<=1;
    addr<=0;
    clk<=0;
    count=0;
    end
    always@(posedge clk)
    begin
        if(layer1_finish)
       begin
        count=count+1;
        addr=count*'d28*'d28;
        $display("----------,%d",addr);
       end
       else
        addr=addr+1;
    end
    always begin
      #10 clk=1;
      #10 clk=0;
    end
endmodule

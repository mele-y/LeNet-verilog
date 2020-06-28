`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/18 17:14:05
// Design Name: 
// Module Name: layer2_buffer
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


module layer2_buffer(
          input clk,
          input [286:0] din,
          input save,
          output reg signed[17:0] dout,
          output reg[7:0] addr,
          
          output reg layer3_en
 );
     reg signed[17:0] buffer[0:511];
     reg [8:0] offset;
    // reg [8:0] addr;
     reg flag;
     reg [8:0] addra;
     reg [5:0] count;
     reg save_com;
    // reg read_com;
     reg read_start;
    // reg layer3_en;
     initial begin
       offset<=0;
       flag<=0;
       count<=0;
       save_com<=0;
      // read_com<=0;
       read_start<=0;
       layer3_en<=0;
       addr<=0;
       addra<=0;
     end
     always@(posedge clk)
     begin
         if(save)
         begin
             if(flag)
              offset='d256;
             else
              offset='d0;
             // $display("%d",din);
            buffer[offset+count*16+0]=din[286:270];
            buffer[offset+count*16+1]=din[269:252];
            buffer[offset+count*16+2]=din[251:234];
            buffer[offset+count*16+3]=din[233:216];
            buffer[offset+count*16+4]=din[215:198];
            buffer[offset+count*16+5]=din[197:180];
            buffer[offset+count*16+6]=din[179:162];
            buffer[offset+count*16+7]=din[161:144];
            buffer[offset+count*16+8]=din[143:126];
            buffer[offset+count*16+9]=din[125:108];
            buffer[offset+count*16+10]=din[107:90];
            buffer[offset+count*16+11]=din[89:72];
            buffer[offset+count*16+12]=din[71:54];
            buffer[offset+count*16+13]=din[53:36];
            buffer[offset+count*16+14]=din[35:18];
            buffer[offset+count*16+15]=din[17:0];
            count=count+1;
            if(count==16)
            begin
             count=0;
             flag=~flag;
             save_com=1;
            end
         end
           else
             save_com=0;
     end
     always@(posedge clk)
     begin
        if(save_com)
          read_start=1;
        if(read_start)
        begin
          if(flag)
            dout=buffer[addra];
          else
            dout=buffer[addra+256];
         
          addra=addra+1;
          addr=addra-1;
          layer3_en=1;
          if(addra=='d256)
          begin
           // read_com=1;
            addra=0;
            read_start=0;
          end  
        end
        else
          layer3_en=0;
     end
endmodule

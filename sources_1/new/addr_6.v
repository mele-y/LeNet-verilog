`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/13 18:39:25
// Design Name: 
// Module Name: addr_6
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


module addr_6(
        input clk,
        input reset,
        input signed[15:0] datain1,
        input signed[15:0] datain2,
        input signed[15:0] datain3,
        input signed[15:0] datain4,
        input signed[15:0] datain5,
        input signed[15:0] datain6,
        input en1,en2,en3,en4,en5,en6,
        input signed[15:0] bias,
        output reg signed[17:0] dout,
        output reg add_out
        //output reg finish
    );
        wire full[0:5];
        wire empty[0:5];
        wire[3:0] dcount[0:5];
        wire signed[15:0] fdout[0:5];
        reg ren[0:5];
        reg add_out_temp;
        reg[8:0] count;
        wire renable;
        initial begin
          count=0;
          add_out=0;
        end
        //delay1 d(.clk(clk),.din(add_out_temp),.dout(add_out));
        delay1 d2(.clk(clk),.din(ren[0]),.dout(renable),.reset(reset));
        //genvar k;
            fifo_16 f1(.clk(clk),.srst(reset),.din(datain1),.wr_en(en1),.full(full[0]),.dout(fdout[0]),.empty(empty[0]),.rd_en(ren[0]),.data_count(dcount[0]));
            fifo_16 f2(.clk(clk),.srst(reset),.din(datain2),.wr_en(en2),.full(full[1]),.dout(fdout[1]),.empty(empty[1]),.rd_en(ren[1]),.data_count(dcount[1]));
            fifo_16 f3(.clk(clk),.srst(reset),.din(datain3),.wr_en(en3),.full(full[2]),.dout(fdout[2]),.empty(empty[2]),.rd_en(ren[2]),.data_count(dcount[2]));
            fifo_16 f4(.clk(clk),.srst(reset),.din(datain4),.wr_en(en4),.full(full[3]),.dout(fdout[3]),.empty(empty[3]),.rd_en(ren[3]),.data_count(dcount[3]));
            fifo_16 f5(.clk(clk),.srst(reset),.din(datain5),.wr_en(en5),.full(full[4]),.dout(fdout[4]),.empty(empty[4]),.rd_en(ren[4]),.data_count(dcount[4]));
            fifo_16 f6(.clk(clk),.srst(reset),.din(datain6),.wr_en(en6),.full(full[5]),.dout(fdout[5]),.empty(empty[5]),.rd_en(ren[5]),.data_count(dcount[5]));
        /*
       always@(posedge clk)
       begin
       $display("------");
       end*/
      always@(posedge clk or posedge reset)
            begin
              if(reset)
              begin
                count<=0;
                dout<=0;
                add_out<=0;
              end
             else
               if(ren[0])
               begin
                  count=count+1;
                  dout=fdout[0]+fdout[1]+fdout[2]+fdout[3]+fdout[4]+fdout[5]+bias;
                  if(dout<0)
                   dout=0;
                  if(count%9!=1)
                   add_out=1;
                  else
                   add_out=0;
                 // $display("count:%d,add_out:%d,dout:%d",count,add_out,dout);
               end
               else
                 add_out=0;
            end
       
        always@(posedge clk)
        begin
          if((dcount[0]>0)&&(dcount[1]>0)&&(dcount[2]>0)&&(dcount[3]>0)&&(dcount[4]>0)&&(dcount[5]>0))
          begin
               ren[0]<=1;
               ren[1]<=1;
               ren[2]<=1;
               ren[3]<=1;
               ren[4]<=1;
               ren[5]<=1;
              // $display("datain1:%d,working11111111,%d",datain1,dcount[0]);
          end
          else
          begin
              ren[0]<=0;
              ren[1]<=0;
              ren[2]<=0;
              ren[3]<=0;
              ren[4]<=0;
              ren[5]<=0;
            //  $display("working2222222");
          end
        end
/*
        always@(posedge add_out)
        begin
          if(add_out)
          $display("%d",dout);
        end*/
 endmodule

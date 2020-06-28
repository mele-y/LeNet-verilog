`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 17:28:59
// Design Name: 
// Module Name: layer1_maxpool
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


module layer1_maxpool
     #(    parameter INPUT_SIZE=24,
            POOL_SIZE=2,
            STRIDE=2
  
)(
 input clk,
 input reset,
 input enable,
 input signed[15:0] datain,
 output reg signed[15:0] dataout,
 output reg pool_out,
 output reg pool_finish
); 
   parameter pre_fill_delay='d50;
   parameter col_move_delay='d22;
   parameter  row_move_delay=(STRIDE-1)*INPUT_SIZE+POOL_SIZE;
   parameter pre_fill=4'b000;//预填态
   parameter col_move=4'b001;//列移动态
   parameter row_move=4'b010;//行移动态
   
   wire signed[15:0] reg1_out;
   wire signed[15:0] reg2_out;
   shift_ram_24 shift_reg1(.CLK(clk),.SCLR(reset),.D(datain),.CE(enable),.Q(reg1_out));
   shift_ram_24 shift_reg2(.CLK(clk),.SCLR(reset),.D(reg1_out),.Q(reg2_out),.CE(enable));
   reg signed[15:0] slide_win[0:3];
           
   reg start;
   reg[10:0] count;//状态转换计数
   reg[10:0] count2;//计算结果计数
   reg[10:0] count3;//移入数据计数
   reg[10:0] delay;
   //reg[7:0] col_move_count;
   //reg[7:0] row_move_count;
   reg[3:0] current_state,next_state;
   
   
  initial begin
  current_state<=pre_fill;
  slide_win[0]<=0;
  slide_win[1]<=0;
  slide_win[2]<=0;
  slide_win[3]<=0;
  count<=0;
  count2<=0;
  //count3<=0;
  end    
 //状态转换
always@(posedge clk or posedge reset)
  begin
   if(reset)
    begin
     current_state<=pre_fill;
    end
    else
      if(enable)
       current_state<=next_state;
   end


always@(posedge clk or posedge reset)
   begin
      if(reset)
       begin
           slide_win[0]<=0;
           slide_win[1]<=0;
           slide_win[2]<=0;
           slide_win[3]<=0;
           count<=0;
           //count3<=0;
       end
      else
           if(enable)
               begin
                   slide_win[0]<=slide_win[1];
                   slide_win[1]<=reg1_out;
                   slide_win[2]<=slide_win[3];
                   slide_win[3]<=reg2_out;
                   //count<=count+1;
                   //count3<=count3+1;
                   if(count==delay)
                     count<=1;
                   else
                     count<=count+1;
                  //$display("count3:%d,,datain:%d",count3,datain);
                end
   end
  
   
       always@(current_state or count)
         begin
             case(current_state)            
                     pre_fill:begin
                                delay=pre_fill_delay;
                                if(count==delay) 
                                 begin
                                 //$display("working2");
                                  start=1;
                                  next_state=col_move;
                                 end
                                else
                                begin
                                  next_state=pre_fill;
                                  start=0;
                                end  
                              end
                      col_move:begin 
                               delay=col_move_delay;
                               if(count%2==0) 
                               begin   
                                  //$display("working");                      
                                   start=1;
                               end
                               else
                                start=0;
                              if(count==delay)
                                      next_state=row_move;
                              else
                                    next_state=col_move;
                                end
                        row_move:begin
                                 delay=row_move_delay;
                                 if(count==row_move_delay)
                                    begin
                                     start=1;
                                     next_state=col_move;
                                    end
                                    else
                                    begin
                                     start=0;
                                      next_state=row_move;
                                   end
                                end
                      endcase
         end
         
         
 always@(posedge clk or posedge reset)
 begin
   if(reset)
   begin
   count2=0;
   pool_out=0;
   pool_finish=0;
   dataout=0;
   end
   else
  if(start==1&&enable==1)
  begin
     count2=count2+1;         
     if(slide_win[0]>slide_win[1])
       dataout=slide_win[0];
     else
      dataout=slide_win[1];
     if(dataout<slide_win[2])
       dataout=slide_win[2];
     if(dataout<slide_win[3])
       dataout=slide_win[3];
      pool_out=1;  
     if(count2>=144)
      begin
       // $display("working");
        pool_finish=1;
        end
        else
        pool_finish=0;
   end
  else
      pool_out=0; 
 end

endmodule

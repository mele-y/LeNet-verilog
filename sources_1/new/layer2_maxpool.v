`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 21:13:20
// Design Name: 
// Module Name: layer2_maxpool
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


module layer2_maxpool#(
       parameter STRIDE=2,
       INPUT_SIZE=8,
       POOL_SIZE=2
       
        )(
           input clk,
           input reset,
           input signed[17:0] datain,
           input enable,
           output reg signed[17:0] dataout,
           output reg pool_out,
           output reg pool_finish
    );
   parameter pre_fill_delay='d18;
    parameter col_move_delay='d6;
    parameter  row_move_delay=(STRIDE-1)*INPUT_SIZE+POOL_SIZE;
    parameter pre_fill=4'b000;//Ô¤ÌîÌ¬
    parameter col_move=4'b001;//ÁÐÒÆ¶¯Ì¬
    parameter row_move=4'b010;//ÐÐÒÆ¶¯Ì¬
      wire signed[17:0] reg1_out,reg2_out;
      shift_ram_8 shift_reg1(.CLK(clk),.SCLR(reset),.D(datain),.Q(reg1_out),.CE(enable));
      shift_ram_8 shift_reg2(.CLK(clk),.SCLR(reset),.D(reg1_out),.Q(reg2_out),.CE(enable));
      reg[3:0] current_state,next_state;
      reg signed[17:0] slide_win[0:3]; 
      reg[9:0] count,count2;
      //count3;
      reg[9:0] delay;
      reg start;
      initial begin
      slide_win[0]<=0;
      slide_win[1]<=0;
      slide_win[2]<=0;
      slide_win[3]<=0;
      count<=0;
      //count3<=0;
      count2<=0;
      current_state<=pre_fill;
      pool_out<=0;
      pool_finish<=0;
      end
      always@(posedge clk or posedge reset)
      begin
        if(reset)
        current_state<=pre_fill;
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
         // count3<=0;
          end
          else
          if(enable)
          begin
           slide_win[0]<=slide_win[1];
           slide_win[1]<=reg1_out;
           slide_win[2]<=slide_win[3];
           slide_win[3]<=reg2_out;
           //count3<=count3+1;
          if(count==delay)
             count<=1;
           else
             count<=count+1;
            // $display("%d,%d",count3,datain);
            // $display("reg1_out:%d,reg2_out:%d",reg1_out,reg2_out);
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
                 if(enable==1)
                 if(start==1)
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
                 if(count2==16)
                 begin
                      pool_finish=1;
                     
                 end
                 else
                      pool_finish=0;

                    //$display("%d,%d,%d,%d",slide_win[0],slide_win[1],slide_win[2],slide_win[3]);
                 end
                 else
                     pool_out=0; 
                end
      
endmodule

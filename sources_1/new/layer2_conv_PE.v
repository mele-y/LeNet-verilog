`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/01 13:09:27
// Design Name: 
// Module Name: layer2_conv_PE
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


module layer2_conv_PE(
        input clk,
        input reset,
        input signed[15:0] datain,
        input enable,
        input  signed[15:0] weight,
        input  weight_enable,
        output reg conv_out,
        output reg conv_finish,
        output reg signed[15:0] dataout
    );  
        parameter pre_fill=4'b000;//预填态
        parameter col_move=4'b001;//列移动态
        parameter row_move=4'b010;//行移动态
        parameter pre_fill_delay=8'd65;
        parameter col_move_delay=8'd7;
        parameter row_move_delay=8'd5;
        parameter stride='d1;
        reg signed [15:0] slide_win[0:24];
        reg signed [15:0] weights[0:24];
        wire signed[15:0] mult_result[0:24];
        reg[10:0] count;
        reg[10:0] count2;
       // reg[10:0] count3;
        wire signed[15:0] reg1_out;
        wire signed[15:0] reg2_out;
        wire signed[15:0] reg3_out;
        wire signed[15:0] reg4_out;
        wire signed[15:0] reg5_out;
        shift_ram_12 shift_reg1(.CLK(clk),.SCLR(reset),.D(datain),.Q(reg1_out),.CE(enable));
        shift_ram_12 shift_reg2(.CLK(clk),.SCLR(reset),.D(reg1_out),.Q(reg2_out),.CE(enable));
        shift_ram_12 shift_reg3(.CLK(clk),.SCLR(reset),.D(reg2_out),.Q(reg3_out),.CE(enable));
        shift_ram_12 shift_reg4(.CLK(clk),.SCLR(reset),.D(reg3_out),.Q(reg4_out),.CE(enable));
        shift_ram_12 shift_reg5(.CLK(clk),.SCLR(reset),.D(reg4_out),.Q(reg5_out),.CE(enable));
        reg signed[15:0] row_add[0:5];
        reg[8:0] weight_count; 
        reg[8:0] delay;
        reg[4:0] current_state,next_state;
        reg start;
        initial begin
        slide_win[0]<=0;
        slide_win[1]<=0;
        slide_win[2]<=0;
        slide_win[3]<=0;
        slide_win[4]<=0;
        slide_win[5]<=0;
        slide_win[6]<=0;
        slide_win[7]<=0;
        slide_win[8]<=0;
        slide_win[9]<=0;
        slide_win[10]<=0;
        slide_win[11]<=0;
        slide_win[12]<=0;
        slide_win[13]<=0;
        slide_win[14]<=0;
        slide_win[15]<=0;
        slide_win[16]<=0;
        slide_win[17]<=0;
        slide_win[18]<=0;
        slide_win[19]<=0;
        slide_win[20]<=0;
        slide_win[21]<=0;
        slide_win[22]<=0;
        slide_win[23]<=0;
        slide_win[24]<=0;
        weight_count<=0;
        count<=0;
        count2<=0;
        //count3<=0;
        delay<=0;
        current_state<=pre_fill;
        end
        
     always@(posedge clk )
        begin
            if(weight_enable)
            begin
                if(weight_count<'d25)
                begin
                    weights[weight_count]<=weight;
                    weight_count<=weight_count+1;
                end
            end
        end
        
          //输入数据并移位
        always@(posedge clk or posedge reset)
        begin
          if(reset)
          begin
           slide_win[0]<=0;slide_win[1]<=0;slide_win[2]<=0;slide_win[3]<=0;slide_win[4]<=0; slide_win[5]<=0;slide_win[6]<=0;slide_win[7]<=0; slide_win[8]<=0;
           slide_win[9]<=0;slide_win[10]<=0;slide_win[11]<=0;slide_win[12]<=0;slide_win[13]<=0;slide_win[14]<=0;slide_win[15]<=0;slide_win[16]<=0; slide_win[17]<=0;
           slide_win[18]<=0;slide_win[19]<=0;slide_win[20]<=0;slide_win[21]<=0; slide_win[22]<=0;slide_win[23]<=0;slide_win[24]<=0;
           count<=0;//count3<=0;
          end
         else
          if(enable)
          begin
          slide_win[0]<=slide_win[1]; slide_win[1]<=slide_win[2];slide_win[2]<=slide_win[3];slide_win[3]<=slide_win[4];slide_win[4]<=reg5_out;
          slide_win[5]<=slide_win[6]; slide_win[6]<=slide_win[7];slide_win[7]<=slide_win[8];slide_win[8]<=slide_win[9];slide_win[9]<=reg4_out;
          slide_win[10]<=slide_win[11]; slide_win[11]<=slide_win[12];slide_win[12]<=slide_win[13];slide_win[13]<=slide_win[14];slide_win[14]<=reg3_out;
          slide_win[15]<=slide_win[16]; slide_win[16]<=slide_win[17];slide_win[17]<=slide_win[18];slide_win[18]<=slide_win[19];slide_win[19]<=reg2_out;
          slide_win[20]<=slide_win[21]; slide_win[21]<=slide_win[22];slide_win[22]<=slide_win[23];slide_win[23]<=slide_win[24];slide_win[24]<=reg1_out;    
          //count3<=count3+1;
          if(count==delay)
            count<=1;
          else
            count<=count+1;
          //$display("count3:%d,datain:%d",count3,datain);
         /* $display("%d,%d,%d,%d,%d",slide_win[0],slide_win[1],slide_win[2],slide_win[3],slide_win[4]);
           $display("%d,%d,%d,%d,%d",slide_win[5],slide_win[6],slide_win[7],slide_win[8],slide_win[9]);
           $display("%d,%d,%d,%d,%d",slide_win[10],slide_win[11],slide_win[12],slide_win[13],slide_win[14]);
          $display("%d,%d,%d,%d,%d",slide_win[15],slide_win[16],slide_win[17],slide_win[18],slide_win[19]);
            $display("%d,%d,%d,%d,%d",slide_win[20],slide_win[21],slide_win[22],slide_win[23],slide_win[24]);*/
          end
        end 
  
        always@(posedge clk or posedge reset)
        begin
         if(reset)
             current_state<=pre_fill;
         else
         if(enable)
            current_state<=next_state;
        end
      
          always@(current_state or count)
             begin
                 case(current_state)            
                         pre_fill:begin
                                    delay=pre_fill_delay;
                                    if(count==delay) 
                                     begin
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
                                   if(count%stride==0) 
                                   begin                                    
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
        
   
    genvar k;
    generate
      for(k=0;k<8'd25;k=k+1)
          begin:label
            mult_16_2 cal_unit(.a(weights[k]),.b(slide_win[k]),.q(mult_result[k]));
        end
   endgenerate
   
       always@(posedge clk or posedge reset)
        begin
           if(reset)
           begin
           count2=0;
           conv_out=0;
           conv_finish=0;
           dataout=0;
           end
           else
           begin
           if(start==1)
           begin
             //$display("%d",slide_win[6]);
             row_add[0]=mult_result[0]+mult_result[1]+mult_result[2]+mult_result[3]+mult_result[4];
             row_add[1]=mult_result[5]+mult_result[6]+mult_result[7]+mult_result[8]+mult_result[9];
             row_add[2]=mult_result[10]+mult_result[11]+mult_result[12]+mult_result[13]+mult_result[14];
             row_add[3]=mult_result[15]+mult_result[16]+mult_result[17]+mult_result[18]+mult_result[19];
             row_add[4]=mult_result[20]+mult_result[21]+mult_result[22]+mult_result[23]+mult_result[24];
             dataout=row_add[0]+row_add[1]+row_add[2]+row_add[3]+row_add[4];
             conv_out=1;
             count2=count2+1;
           /*
            $display("%d,%d,%d,%d,%d",weights[0],weights[1],weights[2],weights[3],weights[4]);  
            $display("%d,%d,%d,%d,%d",weights[5],weights[6],weights[7],weights[8],weights[9]);     
            $display("%d,%d,%d,%d,%d",weights[10],weights[11],weights[12],weights[13],weights[14]);     
            $display("%d,%d,%d,%d,%d",weights[15],weights[16],weights[17],weights[18],weights[19]);     
            $display("%d,%d,%d,%d,%d",weights[20],weights[21],weights[22],weights[23],weights[24]);*/
             /*
             $display("%d,%d,%d,%d,%d",slide_win[0],slide_win[1],slide_win[2],slide_win[3],slide_win[4]);
             $display("%d,%d,%d,%d,%d",slide_win[5],slide_win[6],slide_win[7],slide_win[8],slide_win[9]);
              $display("%d,%d,%d,%d,%d",slide_win[10],slide_win[11],slide_win[12],slide_win[13],slide_win[14]);
              $display("%d,%d,%d,%d,%d",slide_win[15],slide_win[16],slide_win[17],slide_win[18],slide_win[19]);
             $display("%d,%d,%d,%d,%d",slide_win[20],slide_win[21],slide_win[22],slide_win[23],slide_win[24]);*/
             //$display("dataout:%d,count2:%d",dataout,count2);
          end
          else
            conv_out=0;
         if(count2>='d64)
              conv_finish=1;
         else
              conv_finish=0;
          end
        end
endmodule

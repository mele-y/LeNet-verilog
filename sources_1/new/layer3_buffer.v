`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/26 09:48:56
// Design Name: 
// Module Name: layer3_buffer
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


module layer3_buffer(
           input clk,
           input [0:1919] din,
           input save,
           output reg signed[0:15] dout,
           output reg layer4_en,
           output reg[6:0] addr
    );
    reg flag;
    reg signed[15:0] buffer[0:239];
    reg[8:0] offset;
    reg[6:0] addra;
    reg save_com;
    reg read_start;
    reg read_com;
    initial begin
        flag<=0;
        offset<=0;
        save_com<=0;
        addra<=0;
        dout<=0;
        layer4_en<=0;
        addr<=0;
        read_start<=0;
        read_com<=0;
    end
    always@(posedge clk )
    begin
       if(save)
       begin
       if(flag)
           offset=120;
       else
           offset=0;
          buffer[0+offset]=din[0:15];
           buffer[1+offset]=din[16:31];
           buffer[2+offset]=din[32:47];
           buffer[3+offset]=din[48:63];
           buffer[4+offset]=din[64:79];
           buffer[5+offset]=din[80:95];
           buffer[6+offset]=din[96:111];
           buffer[7+offset]=din[112:127];
           buffer[8+offset]=din[128:143];
           buffer[9+offset]=din[144:159];
           buffer[10+offset]=din[160:175];
           buffer[11+offset]=din[176:191];
           buffer[12+offset]=din[192:207];
           buffer[13+offset]=din[208:223];
           buffer[14+offset]=din[224:239];
           buffer[15+offset]=din[240:255];
           buffer[16+offset]=din[256:271];
           buffer[17+offset]=din[272:287];
           buffer[18+offset]=din[288:303];
           buffer[19+offset]=din[304:319];
           buffer[20+offset]=din[320:335];
           buffer[21+offset]=din[336:351];
           buffer[22+offset]=din[352:367];
           buffer[23+offset]=din[368:383];
           buffer[24+offset]=din[384:399];
           buffer[25+offset]=din[400:415];
           buffer[26+offset]=din[416:431];
           buffer[27+offset]=din[432:447];
           buffer[28+offset]=din[448:463];
           buffer[29+offset]=din[464:479];
           buffer[30+offset]=din[480:495];
           buffer[31+offset]=din[496:511];
           buffer[32+offset]=din[512:527];
           buffer[33+offset]=din[528:543];
           buffer[34+offset]=din[544:559];
           buffer[35+offset]=din[560:575];
           buffer[36+offset]=din[576:591];
           buffer[37+offset]=din[592:607];
           buffer[38+offset]=din[608:623];
           buffer[39+offset]=din[624:639];
           buffer[40+offset]=din[640:655];
           buffer[41+offset]=din[656:671];
           buffer[42+offset]=din[672:687];
           buffer[43+offset]=din[688:703];
           buffer[44+offset]=din[704:719];
           buffer[45+offset]=din[720:735];
           buffer[46+offset]=din[736:751];
           buffer[47+offset]=din[752:767];
           buffer[48+offset]=din[768:783];
           buffer[49+offset]=din[784:799];
           buffer[50+offset]=din[800:815];
           buffer[51+offset]=din[816:831];
           buffer[52+offset]=din[832:847];
           buffer[53+offset]=din[848:863];
           buffer[54+offset]=din[864:879];
           buffer[55+offset]=din[880:895];
           buffer[56+offset]=din[896:911];
           buffer[57+offset]=din[912:927];
           buffer[58+offset]=din[928:943];
           buffer[59+offset]=din[944:959];
           buffer[60+offset]=din[960:975];
           buffer[61+offset]=din[976:991];
           buffer[62+offset]=din[992:1007];
           buffer[63+offset]=din[1008:1023];
           buffer[64+offset]=din[1024:1039];
           buffer[65+offset]=din[1040:1055];
           buffer[66+offset]=din[1056:1071];
           buffer[67+offset]=din[1072:1087];
           buffer[68+offset]=din[1088:1103];
           buffer[69+offset]=din[1104:1119];
           buffer[70+offset]=din[1120:1135];
           buffer[71+offset]=din[1136:1151];
           buffer[72+offset]=din[1152:1167];
           buffer[73+offset]=din[1168:1183];
           buffer[74+offset]=din[1184:1199];
           buffer[75+offset]=din[1200:1215];
           buffer[76+offset]=din[1216:1231];
           buffer[77+offset]=din[1232:1247];
           buffer[78+offset]=din[1248:1263];
           buffer[79+offset]=din[1264:1279];
           buffer[80+offset]=din[1280:1295];
           buffer[81+offset]=din[1296:1311];
           buffer[82+offset]=din[1312:1327];
           buffer[83+offset]=din[1328:1343];
           buffer[84+offset]=din[1344:1359];
           buffer[85+offset]=din[1360:1375];
           buffer[86+offset]=din[1376:1391];
           buffer[87+offset]=din[1392:1407];
           buffer[88+offset]=din[1408:1423];
           buffer[89+offset]=din[1424:1439];
           buffer[90+offset]=din[1440:1455];
           buffer[91+offset]=din[1456:1471];
           buffer[92+offset]=din[1472:1487];
           buffer[93+offset]=din[1488:1503];
           buffer[94+offset]=din[1504:1519];
           buffer[95+offset]=din[1520:1535];
           buffer[96+offset]=din[1536:1551];
           buffer[97+offset]=din[1552:1567];
           buffer[98+offset]=din[1568:1583];
           buffer[99+offset]=din[1584:1599];
           buffer[100+offset]=din[1600:1615];
           buffer[101+offset]=din[1616:1631];
           buffer[102+offset]=din[1632:1647];
           buffer[103+offset]=din[1648:1663];
           buffer[104+offset]=din[1664:1679];
           buffer[105+offset]=din[1680:1695];
           buffer[106+offset]=din[1696:1711];
           buffer[107+offset]=din[1712:1727];
           buffer[108+offset]=din[1728:1743];
           buffer[109+offset]=din[1744:1759];
           buffer[110+offset]=din[1760:1775];
           buffer[111+offset]=din[1776:1791];
           buffer[112+offset]=din[1792:1807];
           buffer[113+offset]=din[1808:1823];
           buffer[114+offset]=din[1824:1839];
           buffer[115+offset]=din[1840:1855];
           buffer[116+offset]=din[1856:1871];
           buffer[117+offset]=din[1872:1887];
           buffer[118+offset]=din[1888:1903];
           buffer[119+offset]=din[1904:1919];
          // $display("buffer0:%d",buffer[0+offset],);
        flag=~flag;
        save_com=1;
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
                 dout=buffer[addra+120];
                 //$display("%d,%d",dout,addra);
            addra=addra+1;
            addr=addra-1;
            layer4_en=1;
            if(addra=='d120)
            begin
             //read_com=1;
             addra=0;
             read_start=0;
            end  
           end
           else
              layer4_en=0;
    end
endmodule

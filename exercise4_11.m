clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path='C:\Users\Administrator\Desktop\课程资料\大三上期\光电图像处理\实验报告\实验四\image200s\image200s\';
filecount=200;
for i=1:filecount
    name=num2str(i);
    if i<=9
        filename=strcat('0000000',name,'.bmp');
    elseif i<=99
        filename=strcat('000000',name,'.bmp');
    elseif i<=199
        filename=strcat('00000',name,'.bmp');
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    g1=imread([path filename]);
    g2=g1(:,1:end-10);
    g2_d=double(g2);
    g3=uint8(mat2gray(g2_d)*255);
    f_u=g3;
    f=double(f_u);
    [height,width]=size(f_u);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    level=graythresh(f);
    BW=im2bw(f_u,level);
    BW_not=not(BW);
    stats=regionprops(BW_not,'centroid');
    a=stats(1,1);
    x=a.Centroid(1);
    y=a.Centroid(2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imshow(g1),rectangle('Position',[x-23,y-10,63,20],'Curvature',...
    [0,0],'EdgeColor','r','LineWidth',1);
    title(['Frame NO.' num2str(i)]);
    pause(0.01);
end


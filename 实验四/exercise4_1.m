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
    s=length(find(BW==0));
    BW_not_d=double(BW_not).*255;
    g_0=zeros(height,width);
    g_1=ones(height,width);
    g_0(BW==0)=g_1(BW==0);
    y=zeros(height,width);
    x=zeros(height,width);
    for m=1:height
        for n=1:width
           y(m,n)=m;
          x(m,n)=n;
        end
    end
    x_c=uint8((1/s).*(sum(sum(x.*g_0))));
    y_c=uint8((1/s).*(sum(sum(y.*g_0))));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imshow(g1),rectangle('Position',[x_c-23,y_c-10,63,20],'Curvature',...
    [0,0],'EdgeColor','r','LineWidth',1);
    title(['Frame NO.' num2str(i)]);
    pause(0.01);
end
















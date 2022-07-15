clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g1=imread('C:\Users\Administrator\Desktop\课程资料\大三上期\光电图像处理\实验报告\实验四\image200s\image200s\00000050.bmp');
g2=g1(:,1:end-10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a=unique(g2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g2_d=double(g2);
g3=uint8(mat2gray(g2_d)*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(11),imshow(g3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=g3;
%b=unique(g3);
f=double(f0);
[height,width]=size(f0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
level=graythresh(f);
BW=im2bw(f0,level+0.1);
%figure(12),imshow(BW);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW_not=not(BW);%取反运算
%figure(13),imshow(BW_not);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=length(find(BW==0));
BW_not_d=double(BW_not).*255;
g_0=zeros(height,width);
g_1=ones(height,width);
g_0(BW==0)=g_1(BW==0);

%figure(10),imshow(g_0);

y=zeros(height,width);
x=zeros(height,width);
for i=1:height
    for j=1:width
        y(i,j)=i;
        x(i,j)=j;
    end
end
x_c=uint8((1/s).*(sum(sum(x.*g_0))));
y_c=uint8((1/s).*(sum(sum(y.*g_0))));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stats=regionprops(BW_not,'centroid');
x=stats.Centroid(1);
y=stats.Centroid(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(f0),title('Original image.');
subplot(2,2,2),imshow(BW),title('Binary image.');
subplot(2,2,3),imshow(f0),...
    rectangle('Position',[x,y,10,10],'Curvature',[1,1],...
    'EdgeColor','r','LineWidth',1),...
    title('Binary image.');
subplot(2,2,4),imshow(g1),...
    rectangle('Position',[x_c-23,y_c-10,63,20],'Curvature',[0,0],...
    'EdgeColor','r','LineWidth',1),...
    title('Binary image.');










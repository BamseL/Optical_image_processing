clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%
%绘制两种定义下的直方图
f=imread('train2.tif');
[height,width]=size(f);
g=0:255;%灰度值
grayscale=zeros(1,256);%灰度级共256级,灰度的频数
for i=1:height
    for j=1:width
        grayscale(f(i,j)+1)=grayscale(f(i,j)+1)+1;
    end
end
grayfre=grayscale./(height*width);%灰度的频率
figure,subplot(1,3,1),imshow(f),title('原始图像')%原始图像
subplot(1,3,2),bar(g,grayscale),title('频数直方图')%频数直方图
subplot(1,3,3),bar(g,grayfre),title('频率直方图')%频率直方图
%%%%%%%%%%%%%%%%%%
%直方图均衡化
figure,subplot(2,2,1),imshow(f),title('原始图像')%原始图像
subplot(2,2,2),bar(g,grayfre),title('原始图像频率直方图')%原始图像频率直方图
%%%%%%%%%%%%%%%%%%%%%%%%%%%
r=mat2gray(f);%归一化处理
s=zeros(1:256);%累积直方分布图
for i=1:256
    if i==1
        s(i)=grayfre(i);
    else
        s(i)=s(i-1)+grayfre(i);
    end
end















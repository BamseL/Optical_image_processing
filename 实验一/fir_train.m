clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%
f0=imread('train1.jpg');%读取图像
f=rgb2gray(f0);%灰度处理
[m,n]=size(f);
a=min(min(f));
b=max(max(f));%灰度范围
c=a-20;
d=b+50;%处理后的灰度范围
g=zeros(m,n);%产生一个等大图像
g=((d-c)/(b-a))*(f-a)+c;
figure,subplot(2,2,1),imshow(f),title('原始图像')
subplot(2,2,2),imshow(g),title('线性变换图像')
subplot(2,2,3),imhist(f),title('原始直方图')
subplot(2,2,4),imhist(g),title('线性变换直方图')%画出四个图像
imwrite(g,'C:\Users\Administrator\Pictures\train1_plus.jpg')%保存修改的图像
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%幂率变换
f0=double(f);
g0=f0.^0.76;
g1=uint8(g0);
figure,subplot(2,2,1),imshow(f),title('原始图像')
subplot(2,2,2),imshow(g1),title('幂率变换图像')
subplot(2,2,3),imhist(f),title('原始直方图')
subplot(2,2,4),imhist(g1),title('幂率变换直方图')%画出四个图像







clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%输入图像
f=imread('sky.jpg');
f_gray=rgb2gray(f);%灰度转换
[M1,N1]=size(f_gray);
g=imread('airplane.jpg');
g_gray=rgb2gray(g);
[M2,N2]=size(g_gray);
figure,imshow(f),title('原始图像');
figure,imshow(g),title('素材图像');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%处理第一幅图像
x1=f(1:M1,1:N1,1);
x2=f(1:M1,1:N1,2);
x3=f(1:M1,1:N1,3);
f1=cat(3,x1,x2,x3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%处理第二幅图像
y1=g(1:M2,1:N2,1);
y2=g(1:M2,1:N2,2);
y3=g(1:M2,1:N2,3);
g1=cat(3,y1,y2,y3);
%寻找图像一的中心位置
height_min=floor((M1-M2)/2+1);
height_max=floor((M1+M2)/2+1);
width_min=floor((N1-N2)/2+1);
width_max=floor((N1+N2)/2+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%叠加灰度图像
t_gray=f_gray(height_min:height_max-1,width_min:width_max-1)...
    +g_gray;%将两幅等大图像合成
f_gray_last=f_gray;
f_gray_last(height_min:height_max-1,width_min:width_max-1)=t_gray;
figure,imshow(f_gray_last),title('叠加灰度图像');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%叠加彩色图像
t=f(height_min:height_max-1,width_min:width_max-1,1:3)...
    +g;%将两幅等大图像合成
f_last=f;
f_last(height_min:height_max-1,width_min:width_max-1,1:3)=t;%最终图像
figure,imshow(f_last),title('叠加彩色图像');







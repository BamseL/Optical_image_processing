clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=imread('cameraman.tif');
[height,width]=size(f);
figure,subplot(2,2,1),imshow(f),title('原始图像')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gx=[-1 0 1;%x方向梯度算子
    -1 0 1;
    -1 0 1];
gy=[-1 -1 -1;%y方向梯度算子
    0 0 0;
    1 1 1];
f0=imfilter(f,gx);
f1=imfilter(f,gy);
g=sqrt(gx.^2+gy.^2);
f2=imfilter(f,g);
subplot(2,2,2),imshow(f0),title('x方向梯度图')
subplot(2,2,3),imshow(f1),title('y方向梯度图')
subplot(2,2,4),imshow(f2),title('合成梯度图')










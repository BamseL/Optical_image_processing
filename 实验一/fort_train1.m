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
h_x=fspecial('prewitt')
h_y=h_x'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fx=filter2(h_x,f);
fy=filter2(h_y,f);
g=sqrt(h_x.^2+h_y.^2);
g_sy=uint8(g)
f_sy=filter2(g_sy,f);
subplot(2,2,2),imshow(fx),title('x方向梯度图')
subplot(2,2,3),imshow(fy),title('y方向梯度图')
subplot(2,2,4),imshow(f_sy),title('合成梯度图')










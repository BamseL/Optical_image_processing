clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=imread('cameraman.tif');
[height,width]=size(f);
figure,subplot(2,2,1),imshow(f),title('ԭʼͼ��')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gx=[-1 0 1;%x�����ݶ�����
    -1 0 1;
    -1 0 1];
gy=[-1 -1 -1;%y�����ݶ�����
    0 0 0;
    1 1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fx=imfilter(f,gx);
fy=imfilter(f,gy);
fx=double(fx);
fy=double(fy);
g=sqrt(fx.^2+fy.^2);
g_sy=uint8(g)
fx=uint8(fx);
fy=uint8(fy);
fx=mat2gray(fx);
fy=mat2gray(fy);
fx=uint8(255*fx);
fy=uint8(255*fy);
subplot(2,2,2),imshow(fx),title('x�����ݶ�ͼ')
subplot(2,2,3),imshow(fy),title('y�����ݶ�ͼ')
subplot(2,2,4),imshow(g_sy),title('�ϳ��ݶ�ͼ')


clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=imread('lena256.jpg');
f=rgb2gray(f0);
[height,width]=size(f);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sx=[-1 0 1;
    -2 0 2;
    -1 0 1];
Sy=[-1 -2 -1;
     0  0  0;
     1  2  1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dx=imfilter(f,Sx,'corr','same');
Dy=imfilter(f,Sy,'corr','same');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dx_d=double(Dx);
Dy_d=double(Dy);
D=sqrt(Dx_d.^2+Dy_d.^2);
D_u=uint8(mat2gray(D).*255);
level=graythresh(D);
BW=im2bw(D,level);%Binary image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
level_2=graythresh(D_u);
BW_2=im2bw(D_u,level);%Binary image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_d=double(f);
D_edge=edge(f_d,'sobel','both');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,3,1),imshow(f),title('Original image.');
subplot(2,3,2),imshow(Dx),title('Dx.');
subplot(2,3,3),imshow(Dy),title('Dy.');
subplot(2,3,4),imshow(D),title('D.');
subplot(2,3,5),imshow(BW),title('Binary image.');
subplot(2,3,6),imshow(D_edge),title('Sobel.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,3,1),imshow(f),title('Original image.');
subplot(2,3,2),imshow(Dx),title('Dx.');
subplot(2,3,3),imshow(Dy),title('Dy.');
subplot(2,3,4),imshow(D_u),title('D_u.');
subplot(2,3,5),imshow(BW_2),title('Binary image.');
subplot(2,3,6),imshow(D_edge),title('Sobel.');
















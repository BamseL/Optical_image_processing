clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_u=imread('cameraman.tif');
[height,width]=size(f_u);
f_d=double(f_u);
figure,subplot(2,2,2),imshow(f_u),title('Original image.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=fspecial('motion',100,-45);
h_d=mat2gray(h).*255;
h_u=uint8(mat2gray(h_d)*255);
f_motion=imfilter(f_d,h,'replicate','same');
subplot(2,2,[1,3]),imshow(h_u),title('h');
subplot(2,2,4),imshow(uint8(mat2gray(f_motion)*255)),...
    title('Filtering result.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=50*sqrt(2);%50*sqrt(2)
b=50*sqrt(2);
T=1;
[U,V]=dftuv(height,width,height,width);
H=T.*sin(pi*(U*a+V*b))./...
            (pi.*(U*a+V*b)).*exp(complex(0,-1).*pi.*(U*a+V*b));
H_shift=fftshift(H);
H_u=uint8(mat2gray(abs(H_shift))*255);
[m,n]=find(isnan(H_shift)==1);
H_shift(isnan(H_shift)==1)=zeros(size(m));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%H_text=fft2(h,256,256);
%H_shift=fftshift(H_text);
%H_text_u=uint8(mat2gray(abs(H_text))*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F=fft2(f_d,height,width);
F_shift=fftshift(F);
G=F_shift.*H_shift;
G_ifftshift=ifftshift(G);
g_d=real(ifft2(G_ifftshift));
g_u=uint8(mat2gray(g_d)*255);
figure,subplot(2,2,2),imshow(f_u),title('Original image.');
subplot(2,2,[1,3]),imshow(H_u),title('H_u');
subplot(2,2,4),imshow(g_u),title('Filtering result.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







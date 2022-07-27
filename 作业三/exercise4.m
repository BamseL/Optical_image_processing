clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_u=imread('cameraman.tif');
[height,width]=size(f_u);
f_d=double(f_u);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Produce degraded image.
T=1;
a=50*sqrt(2);%50*sqrt(2)
b=50*sqrt(2);
[U,V]=dftuv(height,width,height,width);
H=T.*sin(pi*(U*a+V*b))./...
            (pi.*(U*a+V*b)).*exp(complex(0,-1).*pi.*(U*a+V*b));
H_shift=fftshift(H);
H_u=uint8(mat2gray(abs(H_shift))*255);
[m,n]=find(isnan(H_shift)==1);
H_shift(isnan(H_shift)==1)=ones(size(m));
H_shift_u=uint8(mat2gray(abs(H_shift))*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F=fft2(f_d);
F_shift=fftshift(F);
G=F_shift.*H_shift;
G_ifftshift=ifftshift(G);
g_d=real(ifft2(G_ifftshift));
g_u=uint8(mat2gray(g_d)*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Produce noise&superposition.
r=normrnd(0.01,0.02,height,width).*255;%Produce gaussian white noise.
g_d_noise=g_d+r;
g_u_noise=uint8(mat2gray(g_d_noise)*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(f_u),title('Original image.');
subplot(2,2,2),imshow(H_shift_u),title('Filter,H.');
subplot(2,2,3),imshow(g_u),title('Degrade image.');
subplot(2,2,4),imshow(g_u_noise),title('Degraded image with noise.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The recover of degraded image with noise.
G2=fft2(g_d_noise);
G2_fftshift=fftshift(G2);
F2_shift=G2_fftshift./H_shift;
F2_ifftshift=ifftshift(F2_shift);
f2_d=real(ifft2(F2_ifftshift));
f2_u=uint8(mat2gray(f2_d)*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(f_u),title('Original image.');
subplot(2,2,2),imshow(H_shift_u),title('Filter,H.');
subplot(2,2,3),imshow(g_u_noise),title('Degrade image with noise.');
subplot(2,2,4),imshow(f2_u),title({'The recover of degraded image',...
    'with noise.'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Produce frequency limited inverse filter.
H_shift_inverse_limited=zeros(height,width);
R=height/4;
centre=(height+1)/2;
H_shift_min=sqrt(min(min(abs(H_shift))));
for u=1:height
    for v=1:width
        if (u-centre)^2+(v-centre)^2<=R^2
            H_shift_inverse_limited(u,v)=H_shift(u,v);
        else
            H_shift_inverse_limited(u,v)=H_shift_min;
        end
    end
end
H_shift_inverse_limited_u=...
    uint8(mat2gray(abs(H_shift_inverse_limited))*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The recover of degraded image with noise.
G3=fft2(g_d_noise);
G3_fftshift=fftshift(G3);
F3_shift=G3_fftshift./H_shift_inverse_limited;
F3_ifftshift=ifftshift(F3_shift);
f3_d=real(ifft2(F3_ifftshift));
f3_u=uint8(mat2gray(f3_d)*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(f_u),title('Original image.');
subplot(2,2,2),imshow(H_shift_inverse_limited_u),title('Filter,H.');
subplot(2,2,3),imshow(g_u_noise),title('Degrade image with noise.');
subplot(2,2,4),imshow(f3_u),title({'The recover of degraded image',...
    'with noise.'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G4=fft2(g_d_noise);
G4_fftshift=fftshift(G4);
H_shift_conj=conj(H_shift);
H_shift_abs=abs(H_shift);
K1=0.01;
F4_shift=(H_shift_conj./(H_shift_abs.^2+K1)).*G4_fftshift;
F4_ifftshift=ifftshift(F4_shift);
f4_d=real(ifft2(F4_ifftshift));
f4_u=uint8(mat2gray(f4_d)*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G5=fft2(g_d_noise);
G5_fftshift=fftshift(G5);
K2=0.02;
F5_shift=(H_shift_conj./(H_shift_abs.^2+K2)).*G5_fftshift;
F5_ifftshift=ifftshift(F5_shift);
f5_d=real(ifft2(F5_ifftshift));
f5_u=uint8(mat2gray(f5_d)*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(f_u),title('Original image.');
subplot(2,2,2),imshow(g_u_noise),title('Degrade image with noise.');
subplot(2,2,3),imshow(f4_u),title({'The recover of degraded image',...
    'with noise.','K=0.01'});
subplot(2,2,4),imshow(f5_u),title({'The recover of degraded image',...
    'with noise.','K=0.02'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%










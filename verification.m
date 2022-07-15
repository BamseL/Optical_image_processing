clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0_u=imread('cameraman.tif');
[height,width]=size(f0_u);
r=normrnd(0,sqrt(0.02),height,width).*255;%Produce gaussian white noise.
f0_d=double(f0_u);
f_d=f0_d+r;%Image corrupted with gaussian white noise.
f_u=uint8(f_d);%8 bit image data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%h=fspecial('gaussian',[9,9],2); %Gaussian lowpass filter of size 9*9.
hp=zeros(9,9);%Unnormalized frequency domain filter.
for i=-4:4
    for j=-4:4
        hp(i+5,j+5)=exp((-(i^2+j^2))/(2*2^2));
    end
end
h_sum=sum(sum(hp));
h=hp./h_sum;%Normalization frequency domain filter.
%%%h=fspecial('gaussian',[9,9],2);%Gaussian lowpass filter of size 9*9.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Repetition.
f_d_r1=[f_d(:,1:4),f_d,f_d(:,width-3:width)];
f_d_r=[f_d_r1(1:4,:);f_d_r1;f_d_r1(height-3:height,:)];
%figure(100),imshow(uint8(f_d_r));
%%%Spatial filtering.
N=9;
f_L=f_d_r;
chip=zeros(3,3);
for i=1:height%Convolution.
    for j=1:width
        for m=1:N
            for n=1:N
                chip(m,n)=f_d_r(i+m-1,j+n-1).*h(N+1-m,N+1-n);
            end
        end
        s=sum(sum(chip));
        f_L(i+(N-1)/2,j+(N-1)/2)=s;
    end
end
f_Last=f_L(5:height+4,5:width+4);
f_L_u=uint8(f_Last);%8 bit image data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Spectrum centralization.
M=2*height;
N=2*width;
f_centralization=zeros(M,N);
f_centralization(1:height,1:width)=f_d;
for i=1:M
    for j=1:N
        f_centralization(i,j)=f_centralization(i,j).*(-1)^(i+j);
    end
end
%%%Frequency domain filter.
%%%Pad with zeros.&Spectrum centralization.
h_centralization=zeros(M,N);
h_centralization(1:9,1:9)=h;
for i=1:M
    for j=1:N
        h_centralization(i,j)=h_centralization(i,j).*(-1)^(i+j);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Two-dimension fourier transform.of h&f
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H=fft2(h_centralization);
F=fft2(f_centralization);
G=F.*H;
g=real(ifft2(G));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Inverse frequency centralization.
for i=1:M
    for j=1:N
        g(i,j)=g(i,j).*(-1)^(i+j);
    end
end
g_L=g(5:height+4,5:width+4);
g_L_u=uint8(g_L);%Image filtered in frequency domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1),subplot(2,2,1),imshow(f0_u),title('Original image.');
subplot(2,2,2),imshow(f_u),...
    title('Image corrupted with gaussian white noise.');
subplot(2,2,3),imshow(f_L_u),title('Spatial domain filtering results');
subplot(2,2,4),imshow(g_L_u),title('Frequency domain filtering results');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%The centralized frequency spectrum of original image.
f0_centralization=zeros(M,N);
f0_centralization(1:height,1:width)=f0_d;
for i=1:M
    for j=1:N
        f0_centralization(i,j)=f0_centralization(i,j).*(-1)^(i+j);
    end
end
F0=fft2(f0_centralization);
F0_u=uint8(mat2gray(log(1+abs(F0)))*255);%The centralized frequency spectrum of original image.
F_u=uint8(mat2gray(log(1+abs(F)))*255);%The centralized frequency spectrum of image...
                   ...corrupted with gaussian white noise..
h_u=uint8(mat2gray(h)*255);%The plane graph of spatial filter h.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%The centralized frequency spectrum of spatial domain filtering results.
f_Last_centralization=zeros(M,N);
f_Last_centralization(1:height,1:width)=f_Last;
for i=1:M
    for j=1:N
        f_Last_centralization(i,j)=f_Last_centralization(i,j).*(-1)^(i+j);
    end
end
F_Last=fft2(f_Last_centralization);
F_Last_u=uint8(mat2gray(log(1+abs(F_Last)))*255);%The centralized frequency ...
                  ...spectrum of spatial domain filtering results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%The centralized frequency spectrum image of frequency domain filtering
%%%results.
G_u=uint8(mat2gray(log(1+abs(G)))*255);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2),subplot(2,2,1),imshow(F0_u),...
    title('Original image.');
subplot(2,2,2),imshow(F_u),...
title('Image corrupted with gaussian white noise.');
subplot(2,2,3),imshow(F_Last_u),title({'The centralized frequency spectrum'
'of spatial domain filtering results.'});
subplot(2,2,4),imshow(G_u),title({'The centralized frequency spectrum'
'of frequency domain filtering results.'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3),subplot(2,2,[1,2]),imshow(h_u),...
    title('The plane image of spatial filter h.');
subplot(2,2,3),imshow(f_L_u),title('Spatial domain filtering results');
subplot(2,2,4),imshow(F_Last_u),title({'The centralized frequency spectrum'
'of spatial domain filtering results.'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%The plane image and 3D image of centralized frequency H.
H_u=uint8(mat2gray(abs(H))*255);
dx=1:M;
dy=1:N;
[X,Y]=meshgrid(dx,dy);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4),mesh(X,Y,H_u),title...
    ('3D image of centralized frequency domain H.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5),subplot(2,2,[1,2]),imshow(H_u),title('The plane image of H');
subplot(2,2,3),imshow(g_L_u),title('Frequency domain filtering results');
subplot(2,2,4),imshow(G_u),title({'The centralized frequency spectrum'
'of frequency domain filtering results.'});























clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%h=fspecial('gaussian',[9,9],2);%Gaussian lowpass filter of size 9*9.
hp=zeros(9,9);%Unnormalized frequency domain filter.
for i=-4:4
    for j=-4:4
        hp(i+5,j+5)=exp((-(i^2+j^2))/(2*2^2));
    end
end
h_sum=sum(sum(hp));
h=hp./h_sum;%Normalization.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M=512;
N=512;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h_centralization=zeros(M,N);
h_centralization(1:9,1:9)=h;
for i=1:M
    for j=1:N
        h_centralization(i,j)=h_centralization(i,j).*(-1)^(i+j);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%H_u_v=fft2(h_centralization);
H_x_v=zeros(M,N);
s_H_x_v=0;
s_H_u_v=0;
for i=1:M
    for k=1:N %The fourier transform of horizontal.
        for j=1:N
            s_H_x_v=s_H_x_v+h_centralization(i,j).*...
            exp(complex(0,-2*pi/N))^((j-1)*(k-1));
        end
        H_x_v(i,k)=s_H_x_v;
    end
end
H_u_v=H_x_v;
for i=1:N
    for k=1:M %The fourier transform of vertical.
        for j=1:M
            s_H_u_v=s_H_u_v+h_centralization(j,i).*...
            exp(complex(0,-2*pi/M))^((j-1)*(k-1));
        end
        H_u_v(k,i)=s_H_u_v;
    end
end
%%%H_u_v=fft2(h_centralization);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H_x_v2=fft(h,N,2);
%H_u_v=fft(H_x_v,M,1);
%H=fft2(h,M,N);







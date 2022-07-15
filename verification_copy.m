clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0_u=imread('cameraman.tif');
[height,width]=size(f0_u);
r=normrnd(0,sqrt(0.02),height,width).*255;%Produce gaussian white noise.
f0_d=double(f0_u);
f_d=f0_d+r;%Signal corrupted with gaussian white noise.
f_u=uint8(f_d);%8 bit image data.
%%%h=fspecial('gaussian',[9,9],2);%Gaussian lowpass filter of size 9*9.
hp=zeros(9,9);%Unnormalized frequency domain filter.
for i=-4:4
    for j=-4:4
        hp(i+5,j+5)=exp((-(i^2+j^2))/(2*2^2));
    end
end
h_sum=sum(sum(hp));
h=hp./h_sum;%Normalization.
%%%h=fspecial('gaussian',[9,9],2);%Gaussian lowpass filter of size 9*9.
%%%Repetition.
f_d_r1=[f_d(:,1),f_d(:,1),f_d(:,1),f_d(:,1),f_d,f_d(:,width),...
    f_d(:,width),f_d(:,width),f_d(:,width)];
f_d_r=[f_d_r1(1,:);f_d_r1(1,:);f_d_r1(1,:);f_d_r1(1,:);f_d_r1;...
    f_d_r1(height,:);f_d_r1(height,:);f_d_r1(height,:);f_d_r1(height,:)];
%%%Spatial filtering.
N=9;
f_L=f_d_r;
for i=1:height%Correlation.
    for j=1:width
        chip=f_d_r(i:i+N-1,j:j+N-1).*h;
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
%%%Inverse frequency centralization.
for i=1:M
    for j=1:N
        H_u_v(i,j)=H_u_v(i,j).*(-1)^(i+j);
    end
end
g_L=H_u_v(1:height,1:width);
g_L_u=uint8(g_L);%Image filtered in frequency domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(f0_u),title('Original image.');
subplot(2,2,2),imshow(f_u),...
    title('Image corrupted with gaussian white noise.');
subplot(2,2,3),imshow(f_L_u),title('Spatial domain filtering results');
subplot(2,2,4),imshow(g_L_u),title('Frequency domain filtering results');





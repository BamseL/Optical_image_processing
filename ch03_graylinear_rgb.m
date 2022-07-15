%==========================================================================
%                彩色图像（Color image）线性灰度变换的示例代码
%                Name: graylinear_rgb.m
%                School of Opto-Electronic Information, University of
%                Electronic Science and Technology of China
%==========================================================================
I=imread('sky.jpg');
[m,n,k]=size(I);
J = zeros(m,n,3);
subplot(1,2,1)
imshow(I);title('原图像');
I=double(I);
fa = 30; fb = 140;
ga = 60; gb = 250;
k1 = ga/fa;
k2 = (gb-ga)/(fb-fa);
k3 = (255-gb)/(255-fb);
for i=1:m
    for j=1:n
        for k=1:3
            if I(i,j,k)<=fa
                J(i,j,k)= k1*I(i,j,k);
            elseif fa<I(i,j,k)<=fb
                J(i,j,k)= k2*( I(i,j,k)-fa)+ ga;
            else
                J(i,j,k)= k3*( I(i,j,k)-fb)+ gb;
            end
        end
    end
end
J=uint8(J);
%J=255-uint8(I);
subplot(1,2,2)
imshow(J);title('灰度变换图');
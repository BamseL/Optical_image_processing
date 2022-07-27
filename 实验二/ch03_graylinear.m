%==========================================================================
%                ͼ�����ԻҶȱ任��ʾ������
%                Name: graylinear.m               
%                Also see: imadjust()
%                School of Opto-Electronic Information, University of
%                Electronic Science and Technology of China

%==========================================================================
clc;clear all;

f = imread('pout.tif'); 
imshow(f);title('ԭͼ��');

[M,N] = size(f);
f = double(f);
g = zeros(M,N,'double'); % Returns an m-by-n matrix of zeros
kmin = min(min(f));
kmax = max(max(f));
a = kmin; b = kmax; 
c = 0; d = 255;
p = (d-c)/(b-a);
for i = 1:M
    for j = 1:N
        if f(i,j) <= a
            g(i,j) = c;       
        elseif a < f(i,j) < b
            g(i,j) = p*(f(i,j)-a)+c;
        else
            g(i,j) = d;
        end
    end
end
% תΪ�޷���8λͼ
g = uint8(g);
%subplot(121);
%imshow(f);title('ԭͼ��');
%subplot(122);
figure,imshow(g);title('�Ҷȱ任ͼ');
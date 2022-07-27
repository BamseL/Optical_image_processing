% =========================================================================
%           ͼ���˲���ģ�����㣩ʾ������
%           Name: myimfilterwithmask.m
%           Boundary: zero padding
%           School of Opto-Electronic Information, University of
%           Electronic Science and Technology of China
% See Also: conv2,xcorr2(full),filter2,imfilter,...
% =========================================================================
clc,clf,clear all,close all;
% =========================================================================
I = imread('dog_gray.bmp'); % cameraman.tif, pout.tif
subplot(1,2,1), 
imshow(I);title('Original image');
[ma,na]  = size(I);
% =========================================================================
% �����˲���h
% =========================================================================
h = [1 1 1; 1 1 1; 1 1 1]/9.0;   % ��������˲���ģ��
% h = fspecial('average',[3,3]); % ����matlab���������˲���
%h = fspecial('gaussian',5,0.2); % ����matlab���������˲���
[mb,nb] = size(h);
mb_hf = floor(mb/2); % �˲������-1
nb_hf = floor(nb/2); % �˲������-1

% =========================================================================
% Boundary: Zero padding
% =========================================================================
zfilt = zeros(ma+mb-1,na+nb-1); % �����˲����ĳߴ����0,���ڱ����˲����
Ip = zfilt;                     % ���ڱ������0ֵ���ԭʼͼ������
r1 = mb_hf+1;        % ��ʼ��
r2 = ma+mb-1-mb_hf;  % ������          
c1 = nb_hf+1;        % ��ʼ��
c2 = na+nb-1-nb_hf;  % ������
Ip(r1:r2,c1:c2) = double(I);   % ȡ��ԭʼͼ������
% =========================================================================
% �˲���h��ͼ��Ip��ģ������ĺ��Ĳ��ִ���
% =========================================================================
for r = r1:r2
   for c = c1:c2
      sumz = 0; % ��ͱ�����ʼ��Ϊ0
      for i = -mb_hf:mb_hf
         for j = -nb_hf:nb_hf
             sumz = sumz + h(i+mb_hf+1,j+nb_hf+1).*Ip(r+i, c+j);  % corr2
             %sumz = sumz + h(i+mb_hf+1,j+nb_hf+1).*Ip(r-i, c-j); % conv2
         end
      end
      zfilt(r,c) = sumz;
   end
end
zcrop = zfilt(r1:r2,c1:c2);% �ص���������,����ԭͼ��ߴ�
% =========================================================================
subplot(1,2,2),  imshow(mat2gray(zcrop));
title('Filtered image');
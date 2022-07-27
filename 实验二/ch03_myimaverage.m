%==========================================================================
%                ͼ���ֵ�˲�ʾ������
%                Name: myimaverage.m
%                School of Opto-Electronic Information, University of
%                Electronic Science and Technology of China
% =========================================================================

clc,clear all,close all;
% =========================================================================
I = imread('dog_gray.bmp');
subplot(1,2,1), 
imshow(I);title('Original image');

[ma,na]  = size(I);
mb = 9; nb = 9;                   % ƽ�����ڳߴ�[ma mb];
mb_hf = floor(mb/2);
nb_hf = floor(nb/2);
r1 = mb_hf+1;                     % ��ʼ��
r2 = ma+mb-1-mb_hf;               % ������ 
c1 = nb_hf+1;                     % ��ʼ��
c2 = na+nb-1-nb_hf;               % ������
zmean = zeros(ma+mb-1, na+nb-1);
% Ip = zmean;                   
% Ip(r1:r2,c1:c2) = double(I);   % ȡ��ԭʼͼ������,��Ч��0���
Ip = padarray(double(I),[mb_hf, nb_hf],'replicate');% symmetric,circular
for r = r1:r2
   for c = c1:c2
      sumz = 0;
      for i =-mb_hf:mb_hf
         for j =-nb_hf:nb_hf
             sumz = sumz + Ip(r+i, c+j);
         end
      end
      sumz = sumz/(mb*nb);
      zmean(r,c) = sumz;
   end
end
% =========================================================================
Imean = zmean(r1:r2,c1:c2);
subplot(1,2,2),  imshow(mat2gray(Imean),[]);
title('Smoothed image');

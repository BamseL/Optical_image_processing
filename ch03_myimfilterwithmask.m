% =========================================================================
%           图像滤波（模板运算）示例代码
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
% 产生滤波器h
% =========================================================================
h = [1 1 1; 1 1 1; 1 1 1]/9.0;   % 自行设计滤波器模板
% h = fspecial('average',[3,3]); % 调用matlab产生特殊滤波器
%h = fspecial('gaussian',5,0.2); % 调用matlab产生特殊滤波器
[mb,nb] = size(h);
mb_hf = floor(mb/2); % 滤波器半高-1
nb_hf = floor(nb/2); % 滤波器半宽-1

% =========================================================================
% Boundary: Zero padding
% =========================================================================
zfilt = zeros(ma+mb-1,na+nb-1); % 根据滤波器的尺寸填充0,用于保存滤波结果
Ip = zfilt;                     % 用于保存填充0值后的原始图像数据
r1 = mb_hf+1;        % 初始行
r2 = ma+mb-1-mb_hf;  % 结束行          
c1 = nb_hf+1;        % 初始列
c2 = na+nb-1-nb_hf;  % 结束列
Ip(r1:r2,c1:c2) = double(I);   % 取得原始图像数据
% =========================================================================
% 滤波器h与图像Ip做模板运算的核心部分代码
% =========================================================================
for r = r1:r2
   for c = c1:c2
      sumz = 0; % 求和变量初始化为0
      for i = -mb_hf:mb_hf
         for j = -nb_hf:nb_hf
             sumz = sumz + h(i+mb_hf+1,j+nb_hf+1).*Ip(r+i, c+j);  % corr2
             %sumz = sumz + h(i+mb_hf+1,j+nb_hf+1).*Ip(r-i, c-j); % conv2
         end
      end
      zfilt(r,c) = sumz;
   end
end
zcrop = zfilt(r1:r2,c1:c2);% 截掉多余数据,保持原图像尺寸
% =========================================================================
subplot(1,2,2),  imshow(mat2gray(zcrop));
title('Filtered image');
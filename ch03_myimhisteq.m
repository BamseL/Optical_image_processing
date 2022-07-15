%==========================================================================
%                图像直方图均衡化示例代码
%                Name: myimhisteq.m
%                School of Opto-Electronic Information, University of
%                Electronic Science and Technology of China
%                Date: 2017.03.07
%                Author：zhenming peng
%==========================================================================
clc,clf,clear all,close all;

I = imread('pout.tif');    
[height,width] = size(I);    
subplot(221)    
imshow(I),title('原始图像');%显示原始图像    
subplot(222)    
imhist(I),title('原始直方图');%显示原始图像直方图    
    
p = zeros(1,256);% 256个灰度级

% 一，灰度(直方图)统计;
gr = 0:255;
for k = 1:256
    for i = 1:height
        for j = 1: width
            if I(i,j) == gr(k)
                p(k) = p(k)+1;
            end
        end
    end
end

% 二，累积直方图分布
sk = zeros(1,256);
for i = 1:256 
    for j=1:i
        sk(i) = sk(i)+p(j);  % 计算sk 
    end
end
% sk = cumsum(s);

% 三，累积直方图概率密度分布（PDF）
sk = sk /(height * width * 1.0);

% PDF映射到[0~255]，四舍五入归并灰度级,
c = round(255.*sk + 0.5);

% 四，对图像进行均衡化
for i = 1:height
    for j = 1:width
        I(i,j) = c(I(i,j)+1);
    end    
end

subplot(223)
imshow(I),title('均衡化后的图像');    % 显示均衡后的图像

subplot(224)
imhist(I,256),title('均衡后的直方图');% 显示均衡后图像的直方图 

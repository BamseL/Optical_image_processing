%==========================================================================
%                ͼ��ֱ��ͼ���⻯ʾ������
%                Name: myimhisteq.m
%                School of Opto-Electronic Information, University of
%                Electronic Science and Technology of China
%                Date: 2017.03.07
%                Author��zhenming peng
%==========================================================================
clc,clf,clear all,close all;

I = imread('pout.tif');    
[height,width] = size(I);    
subplot(221)    
imshow(I),title('ԭʼͼ��');%��ʾԭʼͼ��    
subplot(222)    
imhist(I),title('ԭʼֱ��ͼ');%��ʾԭʼͼ��ֱ��ͼ    
    
p = zeros(1,256);% 256���Ҷȼ�

% һ���Ҷ�(ֱ��ͼ)ͳ��;
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

% �����ۻ�ֱ��ͼ�ֲ�
sk = zeros(1,256);
for i = 1:256 
    for j=1:i
        sk(i) = sk(i)+p(j);  % ����sk 
    end
end
% sk = cumsum(s);

% �����ۻ�ֱ��ͼ�����ܶȷֲ���PDF��
sk = sk /(height * width * 1.0);

% PDFӳ�䵽[0~255]����������鲢�Ҷȼ�,
c = round(255.*sk + 0.5);

% �ģ���ͼ����о��⻯
for i = 1:height
    for j = 1:width
        I(i,j) = c(I(i,j)+1);
    end    
end

subplot(223)
imshow(I),title('���⻯���ͼ��');    % ��ʾ������ͼ��

subplot(224)
imhist(I,256),title('������ֱ��ͼ');% ��ʾ�����ͼ���ֱ��ͼ 

clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%
%�������ֶ����µ�ֱ��ͼ
f=imread('train2.tif');
[height,width]=size(f);
g=0:255;%�Ҷ�ֵ
grayscale=zeros(1,256);%�Ҷȼ���256��,�Ҷȵ�Ƶ��
for i=1:height
    for j=1:width
        grayscale(f(i,j)+1)=grayscale(f(i,j)+1)+1;
    end
end
grayfre=grayscale./(height*width);%�Ҷȵ�Ƶ��
figure,subplot(1,3,1),imshow(f),title('ԭʼͼ��')%ԭʼͼ��
subplot(1,3,2),bar(g,grayscale),title('Ƶ��ֱ��ͼ')%Ƶ��ֱ��ͼ
subplot(1,3,3),bar(g,grayfre),title('Ƶ��ֱ��ͼ')%Ƶ��ֱ��ͼ
%%%%%%%%%%%%%%%%%%
%ֱ��ͼ���⻯
figure,subplot(2,2,1),imshow(f),title('ԭʼͼ��')%ԭʼͼ��
subplot(2,2,2),bar(g,grayfre),title('ԭʼͼ��Ƶ��ֱ��ͼ')%ԭʼͼ��Ƶ��ֱ��ͼ
%%%%%%%%%%%%%%%%%%%%%%%%%%%
r=mat2gray(f);%��һ������
s=zeros(1:256);%�ۻ�ֱ���ֲ�ͼ
for i=1:256
    if i==1
        s(i)=grayfre(i);
    else
        s(i)=s(i-1)+grayfre(i);
    end
end















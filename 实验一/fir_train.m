clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%
f0=imread('train1.jpg');%��ȡͼ��
f=rgb2gray(f0);%�Ҷȴ���
[m,n]=size(f);
a=min(min(f));
b=max(max(f));%�Ҷȷ�Χ
c=a-20;
d=b+50;%�����ĻҶȷ�Χ
g=zeros(m,n);%����һ���ȴ�ͼ��
g=((d-c)/(b-a))*(f-a)+c;
figure,subplot(2,2,1),imshow(f),title('ԭʼͼ��')
subplot(2,2,2),imshow(g),title('���Ա任ͼ��')
subplot(2,2,3),imhist(f),title('ԭʼֱ��ͼ')
subplot(2,2,4),imhist(g),title('���Ա任ֱ��ͼ')%�����ĸ�ͼ��
imwrite(g,'C:\Users\Administrator\Pictures\train1_plus.jpg')%�����޸ĵ�ͼ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ʱ任
f0=double(f);
g0=f0.^0.76;
g1=uint8(g0);
figure,subplot(2,2,1),imshow(f),title('ԭʼͼ��')
subplot(2,2,2),imshow(g1),title('���ʱ任ͼ��')
subplot(2,2,3),imhist(f),title('ԭʼֱ��ͼ')
subplot(2,2,4),imhist(g1),title('���ʱ任ֱ��ͼ')%�����ĸ�ͼ��







clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ͼ��
f=imread('sky.jpg');
f_gray=rgb2gray(f);%�Ҷ�ת��
[M1,N1]=size(f_gray);
g=imread('airplane.jpg');
g_gray=rgb2gray(g);
[M2,N2]=size(g_gray);
figure,imshow(f),title('ԭʼͼ��');
figure,imshow(g),title('�ز�ͼ��');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����һ��ͼ��
x1=f(1:M1,1:N1,1);
x2=f(1:M1,1:N1,2);
x3=f(1:M1,1:N1,3);
f1=cat(3,x1,x2,x3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ڶ���ͼ��
y1=g(1:M2,1:N2,1);
y2=g(1:M2,1:N2,2);
y3=g(1:M2,1:N2,3);
g1=cat(3,y1,y2,y3);
%Ѱ��ͼ��һ������λ��
height_min=floor((M1-M2)/2+1);
height_max=floor((M1+M2)/2+1);
width_min=floor((N1-N2)/2+1);
width_max=floor((N1+N2)/2+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ӻҶ�ͼ��
t_gray=f_gray(height_min:height_max-1,width_min:width_max-1)...
    +g_gray;%�������ȴ�ͼ��ϳ�
f_gray_last=f_gray;
f_gray_last(height_min:height_max-1,width_min:width_max-1)=t_gray;
figure,imshow(f_gray_last),title('���ӻҶ�ͼ��');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���Ӳ�ɫͼ��
t=f(height_min:height_max-1,width_min:width_max-1,1:3)...
    +g;%�������ȴ�ͼ��ϳ�
f_last=f;
f_last(height_min:height_max-1,width_min:width_max-1,1:3)=t;%����ͼ��
figure,imshow(f_last),title('���Ӳ�ɫͼ��');







clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%
%�������ֶ����µ�ֱ��ͼ
f=imread('train2.tif');
[height,width]=size(f);
a=min(min(f));%ͼ�����С�Ҷ�ֵ
b=max(max(f));%ͼ������Ҷ�ֵ
x=unique(f);%xΪ���в�ͬ�Ҷ�ֵ�ļ���
y=zeros(size(x));%yΪ�洢��Ӧ�ڲ�ͬ�Ҷ�ֵƵ��������
for i=1:length(x)%��Ӧ�Ҷ�ֵ��Ƶ��
    y(i)=length(find(f==x(i)));
end
frequ=y./(height*width);%��Ӧ�Ҷ�ֵ��Ƶ��
figure,subplot(1,3,1),imshow(f),title('ԭʼͼ��')%ԭʼͼ��
subplot(1,3,2),bar(x,y),title('Ƶ��ֱ��ͼ')%Ƶ��ֱ��ͼ
subplot(1,3,3),bar(x,frequ),title('Ƶ��ֱ��ͼ')%Ƶ��ֱ��ͼ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ֱ��ͼ���⻯
r=mat2gray(x);%��һ����ԭʼ�Ҷ�
s=zeros(length(r),1);%ֱ��ͼ������ĻҶ�
for i=1:length(r)%ֱ��ͼ�ۼ�
    if i==1
        s(i)=frequ(i);
    else
        s(i)=s(i-1)+frequ(i);
    end
end
ss=uint8(255.*s);%�ۻ��ֲ�ȡ��
g=zeros(height,width);%Ԥ�ȷ����ڴ�
for i=1:height%�Ҷ�ֵӳ��
    for j=1:width
        g(i,j)=ss(x==f(i,j));
    end
end
g=uint8(g);%��������ת��
sk=unique(ss);
sk_num=zeros(length(sk),1);
for i=1:length(sk)
    sk_num(i)=sum(y(ss==sk(i)));%��������ĻҶ���Ѱ�����
                                      ...�ĻҶȲ�����ȻҶ�����Ӧ��
                                      ...ԭʼ�Ҷȵ�Ƶ����ӣ���Ϊ
                                      ...���лҶȵ�Ƶ����
end
frequ_sk=sk_num./(height*width);%���⻯��ĻҶ�ֵƵ��
figure,subplot(2,2,1),imshow(f),title('ԭʼͼ��')%ԭʼͼ��
subplot(2,2,2),imhist(f),title('ԭʼͼ��ֱ��ͼ')%ԭʼͼ��ֱ��ͼ
subplot(2,2,3),imshow(g),title('������ͼ��')%ֱ��ͼ���⻯���ͼ��
subplot(2,2,4),imhist(g),title('������ֱ��ͼ')%�����ֱ��ͼƵ��









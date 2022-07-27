clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%
%绘制两种定义下的直方图
f=imread('train2.tif');
[height,width]=size(f);
a=min(min(f));%图像的最小灰度值
b=max(max(f));%图像的最大灰度值
x=unique(f);%x为所有不同灰度值的集合
y=zeros(size(x));%y为存储相应于不同灰度值频数的数组
for i=1:length(x)%相应灰度值的频数
    y(i)=length(find(f==x(i)));
end
frequ=y./(height*width);%相应灰度值的频率
figure,subplot(1,3,1),imshow(f),title('原始图像')%原始图像
subplot(1,3,2),bar(x,y),title('频数直方图')%频数直方图
subplot(1,3,3),bar(x,frequ),title('频率直方图')%频率直方图
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%直方图均衡化
r=mat2gray(x);%归一化的原始灰度
s=zeros(length(r),1);%直方图修正后的灰度
for i=1:length(r)%直方图累加
    if i==1
        s(i)=frequ(i);
    else
        s(i)=s(i-1)+frequ(i);
    end
end
ss=uint8(255.*s);%累积分布取整
g=zeros(height,width);%预先分配内存
for i=1:height%灰度值映射
    for j=1:width
        g(i,j)=ss(x==f(i,j));
    end
end
g=uint8(g);%数据类型转换
sk=unique(ss);
sk_num=zeros(length(sk),1);
for i=1:length(sk)
    sk_num(i)=sum(y(ss==sk(i)));%从修正后的灰度中寻找相等
                                      ...的灰度并把相等灰度所对应的
                                      ...原始灰度的频数相加，成为
                                      ...现有灰度的频数。
end
frequ_sk=sk_num./(height*width);%均衡化后的灰度值频率
figure,subplot(2,2,1),imshow(f),title('原始图像')%原始图像
subplot(2,2,2),imhist(f),title('原始图像直方图')%原始图像直方图
subplot(2,2,3),imshow(g),title('均衡后的图像')%直方图均衡化后的图像
subplot(2,2,4),imhist(g),title('均衡后的直方图')%均衡后直方图频率









clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=imread('cameraman.tif');
[height,width]=size(f);
figure,subplot(2,2,1),imshow(f),title('原始图像')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gx=[-1 0 1;%x方向梯度算子
    -1 0 1;
    -1 0 1];
gy=[-1 -1 -1;%y方向梯度算子
    0 0 0;
    1 1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N1=3;
f1=double(f);
g1=zeros(height,width);%x、y、合成方向梯度算子处理后的图像元素
g2=zeros(height,width);
g3=zeros(height,width);
for i=1:height-N1+1%去掉边界
    for j=1:(width-N1+1)
        chip1=f1(i:i+N1-1,j:j+N1-1).*gx;%进行相关的第一步运算，得
                                   ...到同位置元素相乘后的九宫格
        chip2=f1(i:i+N1-1,j:j+N1-1).*gy;
        s1=sum(sum(chip1));%九宫格的值相加
        s2=sum(sum(chip2));
        s_sy=sqrt(s1^2+s2^2);
        g1(i+(N1-1)/2,j+(N1-1)/2)=s1;
        g2(i+(N1-1)/2,j+(N1-1)/2)=s2;
        g3(i+(N1-1)/2,j+(N1-1)/2)=s_sy;
    end
end
y1=uint8(g1);%转换格式
y2=uint8(g2);
y3=uint8(g3);
subplot(2,2,2),imshow(y1),title('x方向梯度图')
subplot(2,2,3),imshow(y2),title('y方向梯度图')
subplot(2,2,4),imshow(y3),title('合成梯度图')
        



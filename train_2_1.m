clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=[2 7 6 1 3 6 9 5;
   4 2 3 4 2 7 6 8;
   8 9 6 5 3 7 3 2;
   6 4 5 3 2 9 4 3;
   5 4 6 9 4 3 7 4;
   3 2 4 7 5 6 3 1;
   4 5 6 4 3 5 7 7;
   1 3 5 2 4 6 8 9];
[height,width]=size(f0);
H1=(1/9).*[1 1 1;
    1 1 1;
    1 1 1];
M=1/16.*[
    1 2 1;
    2 4 2;
    1 2 1];
N1=3;%H1为N1*N1矩阵
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%补0操作
%补0操作
t1=zeros(height,1);
t2=zeros(1,width+2);
f_1=[t2;t1 f0 t1;t2];
f_2=mat2gray(f_1);
f=uint8(255*f_2);
f_3=f(2:1+height,2:1+width);%显示原图像（扩展了对比度）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%重复
%重复
g0=f0;
x1=[f(1,:);f;f(height,:)];
x2=[x1(:,1),x1,x1(:,1)];
g_1=mat2gray(x2);
g=uint8(255*g_1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f1=double(f);
f_t=f1;
for i=1:(height-N1+1)%去掉边界
    for j=1:(width-N1+1)
        chip1=f1(i:i+N1-1,j:j+N1-1).*H1;
        s1=sum(sum(chip1));
        f_t(i+(N1-1)/2,j+(N1-1)/2)=s1;
    end
end
f4=uint8(f_t);
f_last=f4(2:1+height,2:1+width);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g1=double(g);
g_t=g1;
for i=1:(height-N1+1)%去掉边界
    for j=1:(width-N1+1)
        chip2=f1(i:i+N1-1,j:j+N1-1).*M;
        s2=sum(sum(chip2));
        g_t(i+(N1-1)/2,j+(N1-1)/2)=s2;
    end
end
g4=uint8(g_t);
g_last=g4(2:1+height,2:1+width);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(1,2,1),imshow(f_3),title('原图像')
subplot(1,2,2),imshow(f_last),title('均值滤波图像')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(1,2,1),imshow(f_3),title('原图像')
subplot(1,2,2),imshow(g_last),title('加权滤波图像')




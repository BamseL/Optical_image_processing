clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=imread('cameraman.tif');
[height,width]=size(f);
figure,subplot(2,2,1),imshow(f),title('ԭʼͼ��')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gx=[-1 0 1;%x�����ݶ�����
    -1 0 1;
    -1 0 1];
gy=[-1 -1 -1;%y�����ݶ�����
    0 0 0;
    1 1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N1=3;
f1=double(f);
g1=zeros(height,width);%x��y���ϳɷ����ݶ����Ӵ�����ͼ��Ԫ��
g2=zeros(height,width);
g3=zeros(height,width);
for i=1:height-N1+1%ȥ���߽�
    for j=1:(width-N1+1)
        chip1=f1(i:i+N1-1,j:j+N1-1).*gx;%������صĵ�һ�����㣬��
                                   ...��ͬλ��Ԫ����˺�ľŹ���
        chip2=f1(i:i+N1-1,j:j+N1-1).*gy;
        s1=sum(sum(chip1));%�Ź����ֵ���
        s2=sum(sum(chip2));
        s_sy=sqrt(s1^2+s2^2);
        g1(i+(N1-1)/2,j+(N1-1)/2)=s1;
        g2(i+(N1-1)/2,j+(N1-1)/2)=s2;
        g3(i+(N1-1)/2,j+(N1-1)/2)=s_sy;
    end
end
y1=uint8(g1);%ת����ʽ
y2=uint8(g2);
y3=uint8(g3);
subplot(2,2,2),imshow(y1),title('x�����ݶ�ͼ')
subplot(2,2,3),imshow(y2),title('y�����ݶ�ͼ')
subplot(2,2,4),imshow(y3),title('�ϳ��ݶ�ͼ')
        



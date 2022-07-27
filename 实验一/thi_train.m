clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=imread('cameraman.tif');
[height,width]=size(f0);
noise=wgn(height,width,30);%������˹������
f=f0+uint8(noise);%���Ӹ�˹������
figure,subplot(2,2,1),imshow(f0),title('ԭʼͼ��')
subplot(2,2,2),imshow(f),title('����˹����ͼ��')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H1=(1/10).*[1 1 1;
    1 2 1;
    1 1 1];%��ֵ�˲���
H2=(1/273).*[1 4 7 4 1;
    4 16 26 16 4;
    7 26 47 26 7;
    4 16 26 16 4;
    1 4 7 4 1];%��˹�˲���
N1=3;
N2=5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ֵ�˲�
f1=double(f);
f2=f1;
for i=1:(height-N1+1)%ȥ���߽�
    for j=1:(width-N1+1)
        chip1=f1(i:i+N1-1,j:j+N1-1).*H1;
        s1=sum(sum(chip1));
        f2(i+(N1-1)/2,j+(N1-1)/2)=s1;
    end
end
f_last=uint8(f2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��˹�˲�
g1=double(f);
g2=g1;
for i=1:(height-N2+1)%ȥ���߽�
    for j=1:(width-N2+1)
        chip2=g1(i:i+N2-1,j:j+N2-1).*H2;
        s2=sum(sum(chip2));
        g2(i+(N2-1)/2,j+(N2-1)/2)=s2;
    end
end
g_last=uint8(g2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,3),imshow(f_last),title('��ֵ�˲�ͼ��')
subplot(2,2,4),imshow(g_last),title('��˹�˲�ͼ��')







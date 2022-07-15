clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=imread('lena512.jpg');
[height,width]=size(f);
a=min(min(f));%The minimum gray value of image.
b=max(max(f));%The maximum gray value of image.
x=unique(f);
y=zeros(size(x));
for i=1:length(x)%The frequency of the corresponding gray value.
    y(i)=length(find(f==x(i)));
end
frequ=y./(height*width);
%sum(frequ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(1,2,1),imshow(f),title('原始图像')%Original image.
subplot(1,2,2),bar(x,frequ),title('频率直方图')%Frequency histogram.
Hs=-(sum(frequ.*log2(frequ)));%Entropy.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fre_sort=sort(frequ,'descend');
[m,n]=size(x);
x_sort=zeros(m,n);
len_t=1;
for i=1:m
    if len_t==1
        len_t=length(find(frequ==fre_sort(i)));
        x_sort(i:i+len_t-1)=x(frequ==fre_sort(i));
    else
        len_t=len_t-1;
        continue;
    end
end
B=zeros(m,m);%Encoder matrix.
for i=1:m
    B(:,i)=fre_sort;%Initialize the first column of encoder matrix.
end
temp_fre_sort=fre_sort;
for i=2:m%Encoder matrix
    if i==2
        temp_s=B(end-1,i-1)+B(end,i-1);
        B(end-1,i)=temp_s;
        B(end,i:end)=0;
        temp_fre_sort=sort(B(:,i),'descend');
        B(:,i)=temp_fre_sort;
        B(:,i+1)=temp_fre_sort;
        temp_addr=find(temp_fre_sort==temp_s,m);
        B(end,i)=temp_addr(end);
    else
        temp_s=B(end-i+1,i-1)+B(end-i+2,i-1);
        B(end-i+1,i)=temp_s;
        B(end-i+2,i:end)=0;
        temp_fre_sort=sort([B(1:end-1,i);0],'descend');
        if i==m
            B(:,i)=temp_fre_sort;
        else
            B(:,i)=temp_fre_sort;
            B(:,i+1)=temp_fre_sort;
        end
        temp_addr=find(temp_fre_sort==temp_s,m);
        B(end,i)=temp_addr(end);
    end
end
H_code=char(zeros(m,m));%The initial coding.
for i=m:-1:2%Produce Hoffman coding.
    if i==m
        H_code(1,1)='0';
        H_code(2,1)='1';
    else
        temp_H_code=H_code;
        K=B(end,i);
        for j=1:m-i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if j>1&&B(j,i-1)==B(j-1,i-1)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                continue;
            else
                B(K,i)=-1;
                temp_fre=B(:,i);
                temp_addr=find(temp_fre==B(j,i-1));
                if length(temp_addr)==1
                    H_code(j,:)=temp_H_code(temp_addr,:);
                else
                    temp_L=length(temp_addr);
                    H_code(j:j+temp_L-1,:)=temp_H_code(temp_addr,:);
                end
            end
        end
        code_length=length(find(temp_H_code(K,:)=='1'))+...
            length(find(temp_H_code(K,:)=='0'));
        H_code(m-i+1,1:code_length+1)...
            =[temp_H_code(K,1:code_length),'0'];
        H_code(m-i+2,1:code_length+1)...
            =[temp_H_code(K,1:code_length),'1'];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
len_average=0;
for i=1:m
    len_subcode=length(find(H_code(i,:)=='1'))+...
        length(find(H_code(i,:)=='0'));
    len_average=len_average+len_subcode*fre_sort(i);
end
[num2str(x_sort),char(ones(m,n).*32),char(ones(m,n).*32),H_code]
Hs
len_average
y=Hs/len_average
C=8/len_average
R=1-y





















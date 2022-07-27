clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=imread('starshape.jpg');
f=double(f0);
[height,width]=size(f0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[P_x,P_y]=gradient(f);
M=sqrt(P_x.^2+P_y.^2);
G=M.*f;
G_u=uint8(mat2gray(G).*255);
x=unique(G_u);
x_1=x(2:size(x));
x_1_d=double(x_1);
y=zeros(size(x_1_d));
for i=1:length(x_1_d)
    y(i)=length(find(f==x(i)));
end
s=height*width-length(find(G_u==0));
frequ=y./s;
T0=1;
temp=0;
for T=1:254
    if find(x==T)
        addr=find(x==T);
        wa=sum(frequ(1:addr));
        wb=1-wa;
        if wa==0||wb==0
            continue;
        else
            ua=(1/wa)*sum(x_1_d(1:addr).*frequ(1:addr));
            ub=(1/wb)*sum(x_1_d(addr+1:end).*frequ(addr+1:end));
            u=wa.*ua+wb.*ub;
            o2=wa.*(ua-u).^2+wb.*(ub-u).^2;
            if o2>temp
                temp=o2;
                T0=T;
            end
        end
    else
        continue;
    end
end
level=T0/255;
BW=im2bw(G_u,level);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(f0),title('Original image.');
subplot(2,2,2),imshow(G_u),title('The new image.');
subplot(2,2,[3,4]),imshow(BW),title('Binary image.');

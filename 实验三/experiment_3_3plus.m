clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=imread('starshape.jpg');
f=double(f0);
[height,width]=size(f0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
level=graythresh(f);
BW=im2bw(f0,0.5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=length(find(BW==0))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW_d=double(BW).*255;
g_0=zeros(height,width);
g_1=ones(height,width);
g_0(BW==0)=g_1(BW==0);
y=zeros(height,width);
x=zeros(height,width);
for i=1:height
    for j=1:width
        y(i,j)=i;
        x(i,j)=j;
    end
end
x_c=uint8((1/s).*(sum(sum(x.*g_0))));
y_c=uint8((1/s).*(sum(sum(y.*g_0))));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(f0),title('Original image.');
subplot(2,2,2),imshow(BW),title('Binary image.');
subplot(2,2,[3,4]),imshow(f0),...
    rectangle('Position',[x_c,y_c,10,10],'Curvature',[1,1],...
    'EdgeColor','r','LineWidth',2),...
    title('Binary image.');







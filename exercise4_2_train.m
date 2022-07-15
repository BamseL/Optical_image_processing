clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g1=imread('C:\Users\Administrator\Desktop\课程资料\大三上期\光电图像处理\实验报告\实验四\f16takeoff_396s\f16takeoff_396s\f16takeoff_396s\001.jpg');
g2=rgb2gray(g1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_0=170;
y_0=110;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure,subplot(2,2,1),imshow(g1),title('Original image.');
subplot(2,2,2),imshow(g1),...
    rectangle('Position',[x_0-40,y_0-20,81,41],'Curvature',[0,0],...
    'EdgeColor','r','LineWidth',1),...
    title('Binary image.');








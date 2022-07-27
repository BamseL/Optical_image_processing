clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=[1 1 1 0 0;
   1 1 1 0 0;
   1 1 1 0 0;
   1 1 1 0 0;
   1 1 1 0 0];
A=[-1 0 1;
   -2 0 2;
   -1 0 1];
I_F=zeros(7,7);
I_F(2:6,2:6)=I;
I_F_A=zeros(5,5);
for i=1:5
    for j=1:5
        temp_A=I_F(i:i+2,j:j+2).*A;
        s_A=sum(sum(temp_A));
        I_F_A(i,j)=s_A;
    end
end
I_A=uint8(mat2gray(I_F_A).*255);
figure,subplot(3,1,1),imshow(I),title('Original image.');
subplot(3,1,2),imshow(I_A),title('The filtering result of A');
level=graythresh(I_A);
BW=im2bw(I_A,level);
subplot(3,1,3),imshow(BW),title('Threshold segmentation results.');






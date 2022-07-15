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
B=[-1 -2 -1;
   0 0 0;
   1 2 1];
I_F=zeros(7,7);
I_F(2:6,2:6)=I;
I_F_A=zeros(5,5);
I_F_B=zeros(5,5);
for i=1:5
    for j=1:5
        temp_A=I_F(i:i+2,j:j+2).*A;
        temp_B=I_F(i:i+2,j:j+2).*B;
        s_A=sum(sum(temp_A));
        s_B=sum(sum(temp_B));
        I_F_A(i,j)=s_A;
        I_F_B(i,j)=s_B;
    end
end
I_A=uint8(mat2gray(I_F_A).*255)
I_B=uint8(mat2gray(I_F_B).*255)
figure,subplot(3,1,1),imshow(I),title('Original image.');
subplot(3,1,2),imshow(I_A),title('The filtering result of A');
subplot(3,1,3),imshow(I_B),title('The filtering result of B');
imfilter(I,A,'same')


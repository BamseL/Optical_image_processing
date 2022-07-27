clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f0=zeros(256,256);%Produce original image.
[height,width]=size(f0);
f0(25:234,[25:31,49:55,73:79,97:103,...
    121:127,145:151,169:175,193:199,217:223])=255*ones(210,63);
f=double(uint8(f0));
figure,subplot(2,2,1),imshow(uint8(f)),title('Original image.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_d_r33=[f(:,1:4),f,f(:,width-3:width)];
f_d_r3=[f_d_r33(1:4,:);f_d_r33;f_d_r33(height-3:height,:)];
N3=3;
f_L3=f_d_r3;
for i=1:height
    for j=1:width
        s3=max(max(f_d_r3(i:i+2,j:j+2)));
        s33=min(min(f_d_r3(i:i+2,j:j+2)));
        f_L3(i+(N3-1)/2,j+(N3-1)/2)=1/2*(s3+s33);
    end
end
f_Last3=f_L3(2:height+1,2:width+1);
f_L_u3=uint8(f_Last3);%8 bit image data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_d_r55=[f(:,1:4),f,f(:,width-3:width)];
f_d_r5=[f_d_r55(1:4,:);f_d_r55;f_d_r55(height-3:height,:)];
N5=5;
f_L5=f_d_r5;
for i=1:height
    for j=1:width
        s5=max(max(f_d_r5(i:i+4,j:j+4)));
        s55=min(min(f_d_r5(i:i+4,j:j+4)));
        f_L5(i+(N5-1)/2,j+(N5-1)/2)=1/2*(s5+s55);
    end
end
f_Last5=f_L5(3:height+2,3:width+2);
f_L_u5=uint8(f_Last5);%8 bit image data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_d_r99=[f(:,1:4),f,f(:,width-3:width)];
f_d_r9=[f_d_r99(1:4,:);f_d_r99;f_d_r99(height-3:height,:)];
N9=9;
f_L9=f_d_r9;
for i=1:height
    for j=1:width
        s9=sum(sum(f_d_r9(i:i+8,j:j+8)));
        s99=sum(sum(f_d_r9(i:i+8,j:j+8)));
        f_L9(i+(N9-1)/2,j+(N9-1)/2)=1/2*(s9+s99);
    end
end
f_Last9=f_L9(5:height+4,5:width+4);
f_L_u9=uint8(f_Last9);%8 bit image data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2),imshow(f_L_u3),title('3*3');
subplot(2,2,3),imshow(f_L_u5),title('5*5');
subplot(2,2,4),imshow(f_L_u9),title('9*9');
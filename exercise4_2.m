clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path='C:\Users\Administrator\Desktop\课程资料\大三上期\光电图像处理\实验报告\实验四\f16takeoff_396s\f16takeoff_396s\f16takeoff_396s\';
filecount=396;
x_0=180;
y_0=110;
p=81;
q=51;
r=(p-1)/2;
s=(q-1)/2;
a=51;
b=(a-1)/2;
MSE=zeros(a,a);
for i=1:filecount
    name=num2str(i);
    name_1=num2str(i+1);
    if i<9
        filename=strcat('00',name,'.jpg');
        filename_1=strcat('00',name_1,'.jpg');
    elseif i==9
        filename=strcat('00',name,'.jpg');
        filename_1=strcat('0',name_1,'.jpg');
    elseif 9<i<99
        filename=strcat('0',name,'.jpg');
        filename_1=strcat('0',name_1,'.jpg');
    elseif i==99
        filename=strcat('0',name,'.jpg');
        filename_1=strcat(name_1,'.jpg');
    elseif 99<i<=396
        filename=strcat(name,'.jpg');
        filename_1=strcat(name_1,'.jpg');
    end
    if i==38
        break;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    g=imread([path filename]);%Original image.
    g_next=imread([path filename_1]);%Next image.
    g_g=rgb2gray(g);
    g_next_g=rgb2gray(g_next);
    if i==1
        x_g=x_0;
        y_g=y_0;
    else
        x_g=x_f;%将上一帧图像的中心位置赋值保留
        y_g=y_f;
    end
    M_k=g_g(y_g-s:y_g+s,x_g-r:x_g+r);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for m=-b:b
        for n=-b:b
            M_k_next=g_next_g(y_g-s+m:y_g+s+m,x_g-r+n:x_g+r+n);
            MSE(m+(b+1),n+(b+1))=1/(a^2).*sum(sum((M_k-M_k_next).^2));
        end
    end
    if i==1
        MSE_1=MSE;
    elseif i==2
        MSE_2=MSE;
    end
    [ddx,ddy]=find(MSE==min(min(MSE)));
    dx=ddx-(b+1);
    dy=ddy-(b+1);
    x_f=x_g+dx;
    y_f=y_g+dy;
    imshow(g_next),rectangle('Position',[x_f-r,y_f-s,p,q],'Curvature',...
    [0,0],'EdgeColor','r','LineWidth',1);
    title(['Frame NO.' num2str(i)]);
    pause(0.01);
end
%MSE(m+(b+1),n+(b+1))=1/(a^2).*sum(sum(abs(M_k-M_k_next)));
[X,Y]=meshgrid(-b:b,-b:b);
figure,subplot(1,2,1),mesh(X,Y,MSE_1),title('MSE_1');
xlabel('dx');
ylabel('dy');
zlabel('MSE');
subplot(1,2,2),mesh(X,Y,MSE_2),title('MSE_2');
xlabel('dx');
ylabel('dy');
zlabel('MSE');







clc,clf,clear all,close all;
f = imread('rice.png');
[M,N] = size(f);             % 原始图像尺寸
figure,subplot(2,2,1),imshow(f),title('原始图像');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = 2*M; Q = 2*N;            
fp = zeros(P,Q); 
fp(1:M,1:N) = f; 
for i = 1:P
    for j = 1:Q
        fp(i,j) = fp(i,j).*(-1)^(i+j);
    end
end
Fp = fft2(fp);
D0 = 20;        
Hp = zeros(P,Q); 
for u = 1:P
    for v = 1:Q
        D = sqrt((u-P/2).^2+(v-Q/2).^2); 
        Hp(u,v) =1./(1+(D/D0).^2);%n=1   
    end
end
Gp = Hp .* Fp;
gp = real(ifft2(Gp)); 
for i=1:P
    for j=1:Q
        gp(i,j) = gp(i,j).*(-1)^(i+j);
    end
end
gpi = gp(1:M, 1:N);
subplot(2,2,2),imshow(uint8(gpi)),title('D0=20');
%%%%%%%%%%%%%%%%%%%%%%%%
D0 = 40;        
Hp = zeros(P,Q); 
for u = 1:P
    for v = 1:Q
        D = sqrt((u-P/2).^2+(v-Q/2).^2); 
        if D <= D0
            Hp(u,v) =1./(1+(D/D0).^2);%n=1
        end        
    end
end
Gp = Hp .* Fp;
gp = real(ifft2(Gp)); 
for i=1:P
    for j=1:Q
        gp(i,j) = gp(i,j).*(-1)^(i+j);
    end
end
gpi = gp(1:M, 1:N);
subplot(2,2,3),imshow(uint8(gpi)),title('D0=40');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D0 = 60;        
Hp = zeros(P,Q); 
for u = 1:P
    for v = 1:Q
        D = sqrt((u-P/2).^2+(v-Q/2).^2); 
        if D <= D0
            Hp(u,v) =1./(1+(D/D0).^2);%n=1
        end        
    end
end
Gp = Hp .* Fp;
gp = real(ifft2(Gp)); 
for i=1:P
    for j=1:Q
        gp(i,j) = gp(i,j).*(-1)^(i+j);
    end
end
gpi = gp(1:M, 1:N);
subplot(2,2,4),imshow(uint8(gpi)),title('D0=60');
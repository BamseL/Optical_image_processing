clc,clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y=importdata('seismic_nsamp251_tr301_2ms.txt');
y_column=y(:,1);%The first column signal data.
[height,width]=size(y_column);
L=height;%Signal length.
T=0.002;%Sampling period.
Fs=1/(T*L);%Sampling frequency.
f=1:height;
f_1=((1:height)-ceil((height)/2)).*Fs;%The two-sided frequency domain.
f_2=(0:ceil((height-1)/2)).*Fs;%The single-sided frequency domain.
t=1800:2:2300;%The time domain.
figure,subplot(3,1,1),plot(t,y_column),title('The first column signal');
                                              %The first column signal.
xlabel('t/(ms)');
ylabel('f(t)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_column_z=y_column;
for i=1:height%Spectrum centralization.
    y_column_z(i,1)=y_column(i,1)*(-1)^(1+i);
end
Yf=fft(y_column_z,L);
Y_fft=abs(Yf);%Fourier transform.
Y_fft_2=Y_fft(ceil(height/2):height);%The single-sided amplitude spectrum.
subplot(3,1,2),plot(f_1,Y_fft),title('The two-sided ampliude spectrum.');
xlabel('u/(Hz)');
ylabel('F(u)');
subplot(3,1,3),plot(f_2,Y_fft_2),...
                 title('The single-sided ampliude spectrum.');
xlabel('u/(Hz)');
ylabel('F(u)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N1=1;
N2=2;
N4=4;
L=height;%Signal data length.
u=f;%
D0=100;
D=u-L/2;
H1=1./(1+(D/D0).^(2*N1));%n=1
H2=1./(1+(D/D0).^(2*N2));%n=2
H4=1./(1+(D/D0).^(2*N4));%n=4
figure,subplot(3,1,1),plot(u,H1),...
    title('n=1,BLPF frequency-response curve.');
xlabel('u/(Hz)');
ylabel('|H1|');
subplot(3,1,2),plot(u,H2),title('n=2,BLPF frequency-response curve.');
xlabel('u/(Hz)');
ylabel('|H2|');
subplot(3,1,3),plot(u,H4),title('n=4,BLPF frequency-response curve.');
xlabel('u/(Hz)');
ylabel('|H4|');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D0_5=5;
D0_20=20;
D0_50=50;
H2_5=(1./(1+(D/D0_5).^(2*N2)))';%n=2
H2_20=(1./(1+(D/D0_20).^(2*N2)))';%n=2
H2_50=(1./(1+(D/D0_50).^(2*N2)))';%n=2
G_5=Yf.*H2_5;
G_20=Yf.*H2_20;
G_50=Yf.*H2_50;
g_5=real(ifft(G_5));%Inverse fft.
g_20=real(ifft(G_20));
g_50=real(ifft(G_50));
for i=1:height
    g_5(i,1)=g_5(i,1)*(-1)^(1+i);
end
for i=1:height
    g_20(i,1)=g_20(i,1)*(-1)^(1+i);
end
for i=1:height
    g_50(i,1)=g_50(i,1)*(-1)^(1+i);
end
figure,subplot(4,1,1),plot(t,y_column),...
    title('The first column signal data.');
xlabel('t/(ms)');
ylabel('f(t)');
subplot(4,1,2),plot(t,g_5),title('D0=5,n=2');
xlabel('t/(ms)');
ylabel('g5');
subplot(4,1,3),plot(t,g_20),title('D0=20,n=2');
xlabel('t/(ms)');
ylabel('g20');
subplot(4,1,4),plot(t,g_50),title('D0=50,n=2');
xlabel('t/(ms)');
ylabel('g50');




clear;
N=200;
fs=20000;
fx=1000;
FS=1;
x=sin(2*pi*fx/fs*[0:N-1]);
%f = (0:N-1)*(fs/N);
% f=[0:N-1]/fs;
s1=abs(fft(x));
s2=s1(1:end/2);
s3=20*log10(2*s2/N/FS);
f = [0:N/2-1]/N;
figure;
subplot(2,2,1);
plot(f,s3);
subplot(2,2,2);
plot(x);
subplot(2,2,3);
plot(s1)
% xlabel('time');
% ylabel('amplituide');

figure(1);
plot(f, s3);                      % 以对数刻度绘制频谱图
title('ADC Output Spectrum');
xlabel('Normalized Frequency (fx/fs)');
ylabel('Power (dB)');
axis([0, 0.5, -120, 0]);          % 设置频谱图的范围
grid;



clear;
ts=-pi:0.01:pi;
fx=cos(ts);
plot(ts,fx);
grid on
clear;
x=[0 pi/2 pi];
y=sin(x);
plot(x,y);
grid on


clear;
fs=1000;
fx=100;
x=cos(2*pi*fx/fs*[0:9]);
%s=abs(fft(x));
%plot(s,'linewidth',5);
plot(x)


clear;
fs = 10000; % 采样率 1000 Hz
fx = 100;  % 信号频率 100 Hz
%t = 0:1/fs:1-1/fs; % 生成时间向量，持续1秒，以确保至少包含一个完整的周期
x = cos(2*pi*fx/fs*[0:99]); % 生成余弦信号
plot(x); % 绘制时间向量和余弦信号
%xlabel('Time (s)'); % x轴标签
%ylabel('Amplitude'); % y轴标签
%title('Cosine Signal'); % 图像标题





clear;
N=200;%采样的点数
fs=2000;%采样的频率，N/fs=0.1s为采样的总时间
fx=100;%1/fs=0.01s为信号的周期，
% 说明信号只采样10个周期，每个周期采样20个点
FS=1;%设置满量程为1，full scale，这通常用于计算分贝值
x=cos(2*pi*fx/fs*[0:N-1]);%余弦信号，频率为100，采样频率为2000，
%长度为200个样本
s1 =abs(fft(x));%对x进行快速傅里叶变换，取模值。
s2 = s1(1:end/2);%只去前半部分的幅度谱（由于是对称的）
s3 = 20*log10(2*s2/N/FS);
%将幅度谱转化为dB单位，其中2*s/N/FS是归一化的幅度
% 2是因为失去了一般的幅度谱，要保证能量不变，
% 然后除以信号长度N和满量程值FS，这一步是将幅度谱归一化到满量程值。
f = [0:N/2-1]/N;%频率向量从0到N/2-1，除N为归一化频率
figure;
subplot(2,2,1);
plot(f,s3,'LineWidth',2);
xlabel('Frequency [f/fs]');
ylabel('DFT Magnitude [dBFS]');
subplot(2,2,2);
plot(x);
subplot(2,2,3);
plot(s1);
















clear;
N = 500;
fs = 5000;
fx = 100;
FS = 1;
x = cos(2*pi*fx/fs*[0:N-1]);
s = abs(fft(x));
plot(s)
s1 = s(1:end/2);
s2 = 20*log10(2*s1/N/FS);
f = [0:N/2-1]/N;
figure;
subplot(2,1,1);
plot(f,s2);
subplot(2,1,2);
plot(s);





clear;
N = 1024;
fs = 20*1024;
fx = 100;
FS = 1;
x = cos(2*pi*fx/fs*[0:N-1]);
s = abs(fft(x));
plot(s)
s1 = s(1:end/2);
s2 = 20*log10(2*s1/N/FS);
f = [0:N/2-1]/N;
figure;
subplot(2,1,1);
plot(f,s2);
subplot(2,1,2);
plot(s);


clear;
N = 1024;
M = 7;
fx = 1e6;
fs = N*fx/M;
Ts = 1/fs;
t = 0:Ts:(N-1)*Ts;
vin = sin(2*pi*fx*t)
figure(1);
plot(t,vin);
s = abs(fft(vin));
s = 20*log10(s);
s = s - max(s);%使最大值为0
s = s(1:N/2);
figure(2);
subplot(2,1,1);
plot(0:N/2-1,s);
subplot(2,1,2);
f = [0:N/2-1]*fs/N;
plot(f,s);




clear;
N=1024;
fin=1e6;
M=37;
fs=N*fin/M;
Ts=1/fs;
t=0:Ts:(N-1)*Ts;
vin=sin(2*pi*fin*t);
LSB=2/2^10;
vin=round(vin/LSB)*LSB;
% figure(1);
% subplot(2,1,1);
% plot(t,vin1);
% subplot(2,1,2);
% plot(t,vin)
figure(1);
plot(t,vin);
s=fft(vin);
s=abs(s)+1e-6;
s_dB=20*log10(s);
s_dB=s_dB- max(s_dB);
s_dB=s_dB(1:N/2);
figure(2);
f=(0:N/2-1)*fs/N;
plot(1:N/2,s_dB);
% plot(f,s_dB);
sig_bin=M+1;
s=s(1:N/2);
s=s.^2;
power_sig=s(sig_bin);
power_noise=sum(s)-power_sig;
snr=10*log10(power_sig/power_noise);












 







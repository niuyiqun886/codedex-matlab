%%  2.7.3MATLAB在电力信号分析处理中的应用
clear
fs = 500;t = 0:1/fs:0.2;
f1 = 50;f2= 200;
x = 2*sin(2*pi*f1*t) + cos(2*pi*f2*t);
subplot(4,1,1);
plot(x)
title('f1 (50Hz) \f2 (200Hz) 的正弦信号，初相0')
xlabel('序列 (n)')
grid on
number = 512;
y = fft(x,number);    %对x进行快速傅里叶变换，一共512个点，y是512个复数
n = 0:length(y)-1;    %生成[0:511]序列
f = fs*n/length(y);   %把序号转成真实的频率，频率=采样率×序号/总点数
subplot(4,1,2);
plot(f,abs(y))
title('f1\f2 的正弦信号的fft (512点)')
xlabel('频率 Hz')
grid on
x = x+randn(1,length(x));
subplot(4,1,3);
plot(x)
title('f1\f2 的正弦信号 (含随机噪声）')
xlabel('序列(n)')
grid on
y = fft(x,number);
n = 0:length(y)-1;
f = fs*n/length(y);
subplot(4,1,4);
plot(f,abs(y))
title('f1\f2 的正弦信号(含随机噪声)的FFT(512点)')
xlabel('频率Hz')
grid on



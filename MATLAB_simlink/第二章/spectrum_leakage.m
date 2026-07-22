% fs = 500;
% f = 50;
% t = 0:1/fs:0.2;
% x = sin(2*pi*f*t);
% subplot(2,1,1)
% plot(x)
% 
% %给出采样点数
% number = 512;
% y = fft(x,number);
% n = 0:length(y)-1;
% f = fs*n/length(y);
% subplot(2,1,2)
% plot(f,abs(y))


fs = 500;
f = 50;
t = 0:1/fs:0.2;
t1 = 0:1/fs:0.4;
x = sin(2*pi*f*t);
x1 = sin(2*pi*f*t1);

%给出采样点数
number = length(x);
% number = 512;
y = fft(x,number);
y1 = fft(x1,number);
n = 0:length(y)-1;
f = fs*n/length(y);

hold on
plot(f,20*log(abs(y)),'r')
plot(f,20*log(abs(y1)),'b')
hold off

%意思是看频谱泄露的话改成db会更容易看出来
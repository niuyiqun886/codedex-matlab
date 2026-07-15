%%例10-13已知二阶系统的传递函数为：G(s) = 2/s^2 + 2s + 3
%%计算系统的谐振频率和谐振幅值
num = 2;
den = [1 2 3];
sys = tf(num,den);
bode(sys)
[mag, pha, w] = bode(sys);    %获得Bode图的幅值、相角、角频率点向量
%%这里的[mag, pha, w]是标准的写法，提取幅值相位和频率。
[A, i] = max(mag(1,:));       %获得峰值
Mr = 20*log10(A)              %计算谐振幅值
Wr = w(i)                     %计算谐振频率
grid on
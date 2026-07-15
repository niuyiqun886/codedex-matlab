%%例10-14已知单位负反馈系统的开环传递函数为G(s) = 50*(s + 4)/(s + 2)(s - 1)(s + 3)
%%绘制系统的Nyquist曲线，判断系统的稳定性
clear all
num = 0.5*[1 4];
den = conv([1 2],conv([1 -1],[1 3]));
sys = tf(num,den);

figure(1)
nyquist(sys)
axis equal
grid on

figure(2)
bode(sys)
grid on

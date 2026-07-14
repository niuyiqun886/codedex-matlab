%%10.2.3频域分析方法
%%典型的一阶传递函数，G(s) = 1/(s + 1)绘制Nyquist曲线
clear all
num = 1;
den = [1 1];
sys = tf(num, den);
nyquist(sys)
grid on

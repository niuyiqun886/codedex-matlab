%%10.2.3频域分析方法
%%例已知一个典型的二阶系统的传递函数为：G(s) = 1/s^2 + s +1
%%绘制系统的Bode图
clear all
num = 1;
den = [1 1 1];
sys = tf(num, den);
bode(sys)
margin(sys)     %可以读出系统的裕度
grid on
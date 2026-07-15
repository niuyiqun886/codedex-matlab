%%例10-15已知一高阶系统的开环传递函数为：
%%G(s) = 2*(0.141s + 1)/s(0.12s + 1)(0.29s + 1)(0.33s + 1)
%%使用margin 函数计算系统的增益裕度和相角裕度
num = 2*[0.141 1];
den = conv(conv([1 0],[0.12 1]),conv([0.29 1],[0.33 1]));
sys = tf(num, den);
% [gm, pm, wcg, wcp] = margin(sys)
% %%含义：gm：增益裕度；pm：相位裕度；wcg：相角交界频率；wcp：截止频率
% margin(sys)                 %%利用了bode图展示系统的稳定裕度

sys1 = zpk(sys)
%%如何通过传递函数建立系统的状态空间模型：
[A, B, C, D] = tf2ss(num, den)
[z, p, k] = tf2zp(num, den)
[A, B, C, D] = zp2ss(z, p, k)


%%例10-16已知系统的传递函数为：G(s) = (s + 1)(s + 2)/(s + 3)(s + 4)
%%求系统的状态空间模型：
num = conv([1 1],[1 2]);
den = conv([1 3],[1 4]);
sys = tf(num,den);
[A1, B1, C1, D1] = tf2ss(num ,den)
sys1 = ss(sys)
[z, p, k] = tf2zp(num, den);
sys2 = zpk(z, p, k);
[A2, B2, C2, D2] = zp2ss(z, p, k)
sys3 = ss(sys2)
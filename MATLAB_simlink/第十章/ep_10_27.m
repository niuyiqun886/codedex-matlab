%%例10-27 传递函数为$G(s) = \frac{25*(s^2 + s + 7)}{(s +25)(s^2 + 3s + 7)}$
%绘制bode图和nyquist图
num = 25*[1 1 7];
den = conv([1 25],[1 3 7]);
sys = tf(num,den);
subplot(2,1,1)
bode(sys)
grid on
subplot(2,1,2)
nyquist(sys)
axis equal
grid on
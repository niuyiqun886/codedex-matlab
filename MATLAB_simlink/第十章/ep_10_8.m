%%10.2.2根轨迹分析方法
%%例10-8 已知单位负反馈系统开环传递函数G(s) = K(s + 2)/s(s + 1)(s + 3)
%%绘制根轨迹图：使用rlocus函数
num = [1 2];
den = conv([1 0],conv([1 1],[1 3]));
sys = tf(num, den);
figure
rlocus(sys)
[p , z] = pzmap(sys)
% grid on
title('零极点图')
xlabel('Real Axis')
ylabel('Imaginary Axis')
axis equal



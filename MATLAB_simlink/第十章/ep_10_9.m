%%10.2.2根轨迹分析方法
%%例10-9已知系统单位负反馈的开环传递函数为：
%%G(s) = K*(s + 4)/s(s + 2.3)(s + 5.6)
%%绘制根轨迹图，在根轨迹图上选择一点，计算该点对应的增益K，及其他闭环极点的位置
num = [1 4];
den = conv([1 0],conv([1 2.3],[1 5.6]));
sys = tf(num, den);
rlocus(sys)
title('根轨迹图')
xlabel('Real Axis')
ylabel('Imaginary Axis')
axis equal

[k, poles] = rlocfind(sys)      %计算指定点处对应的增益以及其他闭环极点
%%10.2.2根轨迹分析方法
%%例10-7已知系统的闭环传递函数为 G(s) = 2(s + 1)/((s^2 + 2s + 3)·(s + 3))
%%绘制零极点图：使用pzmap函数
clear all
num = 2*[1 1];
den = conv([1 2 3],[1 3]);
sys = tf(num, den);
figure
pzmap(sys)             %这个是画图的
[p, z] = pzmap(sys)    %这个是返回参数的，  这俩缺一不可(少一个只会执行一个)
grid on
title('零极点图')
xlabel('Real Axis')
ylabel('Imaginary Axis')
axis equal
figure
step(sys)
%% 10.1.2控制系统的数学模型
%%1.输入输出模型
%%例10-1 y''' + 3.2y'' + 2.4y' = 2x'' + 3x' + 1

%%利用函数命令tf(num,den)编写
num = [2 3 1];
den = [1 3.2 2.4 0];   % y'''+3.2y''+2.4y' 没有 y 项，末尾补 0
sys_1 = tf(num, den);     % 不加分号，才会在命令行显示结果

% %%利用传递函数零极点增益形式，zpk(z, p, k)
% z = [-0.5, -1];
% p = [0, -1.2, -2];
% k = 2;
% sys_2 = zpk(z, p, k);
% 
% %利用conv(卷积)函数解决多项式展开问题
% num = conv([1 2 3], [1 0.1 0.2]);
% den = conv([1 1.1 2.3], [1 4 1]);
% sys_3 = tf(num, den);

% %%使用bode可以直接打印
% figure
% bode(sys_1)
% figure
% bode(sys_2)
% figure
% bode(sys_3)

w = logspace(-1, 1, 500);   % 0.1 ~ 10 rad/s，对数分布，其中500是在这个范围内的点数(精度)
h = freqs(num, den, w);     %freqs应该是直接表示的这个的幅值和相位，H(jw) = |H(jw)|*exp(jφ(w))

mag = abs(h);               % 幅频
phase = angle(h)*180/pi;    % 相频(转成度),这个angle是直接可以提取出来w(角频率)的。

subplot(2,1,1)
% loglog(w, mag)              %应该是横轴纵轴都是log形式
semilogx(w, mag)              %这里表示的是x轴是log形式
grid on
xlabel('\omega (rad/s)')
ylabel('|H(j\omega)|')   %这里的表示和打公式一样

subplot(2,1,2)
semilogx(w, phase)
grid on
xlabel('\omega (rad/s)')
ylabel('相位 (°)')






















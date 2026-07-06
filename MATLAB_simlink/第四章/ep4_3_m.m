% 
% b = [0.04, 0.08, 0.4];   % 右边输入项系数
% a = [1, -0.6, 0.7];      % 左边输出项系数
% 
% n = 0:30;
% 
% % 单位脉冲响应 h(n)
% h = impz(b, a, length(n));
% subplot(2,1,1); 
% stem(n, h); 
% grid on;
% title('单位脉冲响应 h(n)'); xlabel('n');
% 
% % 单位阶跃响应
% s = stepz(b, a, length(n));
% subplot(2,1,2); 
% stem(n, s); 
% grid on;
% title('单位阶跃响应'); 
% xlabel('n');
% 
% % 任意输入 u(n) 下求 y(n)(下面以阶跃输入举例)
% u = ones(size(n));
% y = filter(b, a, u);
% 
% %figure;
% %freqz(b, a, 512, 1);  % 512点，采样率为1（归一化频率）
% 
% figure;
% freqz(b, a, 512, 200);




figure;
c = 1;
d = [1e-9 1e-3 1];

% 幅频相频响应（模拟系统用freqs）
subplot(2,1,1);
freqs(c, d);

% 冲击响应和阶跃响应（模拟系统用tf+impulse/step）
sys = tf(c, d);

figure;
subplot(2,1,1);
impulse(sys);
title('冲击响应');
grid on;

subplot(2,1,2);
step(sys);
title('阶跃响应');
grid on;

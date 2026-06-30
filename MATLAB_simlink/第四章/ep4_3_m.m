
b = [0.04, 0.08, 0.4];   % 右边输入项系数
a = [1, -0.6, 0.7];      % 左边输出项系数

n = 0:30;

% 单位脉冲响应 h(n)
h = impz(b, a, length(n));
subplot(2,1,1); 
stem(n, h); 
grid on;
title('单位脉冲响应 h(n)'); xlabel('n');

% 单位阶跃响应
s = stepz(b, a, length(n));
subplot(2,1,2); 
stem(n, s); 
grid on;
title('单位阶跃响应'); 
xlabel('n');

% 任意输入 u(n) 下求 y(n)(下面以阶跃输入举例)
u = ones(size(n));
y = filter(b, a, u);
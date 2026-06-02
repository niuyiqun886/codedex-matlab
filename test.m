% 正弦信号生成与绘图
clc; clear; close all;

%% 参数设置
fs = 1000;          % 采样频率 (Hz)
T = 1;              % 信号时长 (s)
f = 5;              % 正弦频率 (Hz)
A = 1;              % 幅值
phi = 0;            % 初相位 (rad)

%% 生成时间轴与信号
t = 0 : 1/fs : T - 1/fs;
x = A * sin(2 * pi * f * t + phi);

%% 绘图
figure('Name', '正弦信号', 'NumberTitle', 'off');
plot(t, x, 'b-', 'LineWidth', 1.5);
xlabel('时间 (s)');
ylabel('幅值');
title(sprintf('正弦信号  f = %d Hz,  A = %.1f', f, A));
grid on;
xlim([0, T]);
ylim([-1.2*A, 1.2*A]);
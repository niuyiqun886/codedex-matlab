clear all;

%*****************************参数定义*****************************
Vref = 1;
Vcm = Vref / 2;
N = 10;                                       % ADC 分辨率
M = 10;                                       % 比较次数
Wda = [512, 256, 128, 64, 32, 16, 8, 4, 2, 1];% 权值

% **************************容性失配参数****************************
Cu = 1e-15;
del_Cu = 0.01 / sqrt(2) * Cu;
alfa = 0.1;
beta = 0.01;

%***************************比较器失配参数***************************
del_Compos = 2e-3;                   %比较器静态失调电压
del_Compvn = 200e-6;                 % 比较器输入噪声电压
del_ktc = 100e-6;                    % kT/C 噪声
Comp_os = del_Compos * randn(1, 1);  % 比较器失调电压

%**************************电容失配生成******************************
for i = 1:M
    Cm_p(i) = Wda(i) * Cu + sqrt(Wda(i)) * del_Cu * randn(1, 1);
    Cm_n(i) = Wda(i) * Cu + sqrt(Wda(i)) * del_Cu * randn(1, 1);
end

%************************输入电容及寄生电容**************************
Cd1_p = Cu + del_Cu * randn(1, 1);
Cd1_n = Cu + del_Cu * randn(1, 1);
Cp1_p = beta * (sum(Cm_p) + Cd1_p);
Cp1_n = beta * (sum(Cm_n) + Cd1_n);

%****************************SAR ADC 仿真*****************************
d_len = 2^15;                         % 输入信号点数
dout = zeros(1,d_len);                % 初始化输出向量
delta_ph = 311 / d_len * 2 * pi;      % 信号频率(原来的相位的增加量为311/1024，
                                      % 现在的相位的增加量变为原来的1/10）说明采样更精细了）

%*********************差分输入信号 normal signal***********************
 for i = 1:d_len

    Vip = 0.49 * Vref * sin(i * delta_ph) + Vcm;
    Vin = -0.49 * Vref * sin(i * delta_ph) + Vcm;

%************************INL&DNL test signal**************************  
  % Vip = 0.51 * Vref * sin(i * delta_ph) + Vcm;
  % Vin = -0.51 * Vref * sin(i * delta_ph) + Vcm;

%************************ DC test signal******************************
  % Vip = 470 * Vref/1024+Vcm;
  % Vin = -470 * Vref/1024+Vcm;


%***********************调用 SAR ADC 函数******************************
    dout(i) = floor((adc_sar_diff(Vip, Vin, Vcm, M, Cm_p,Cm_n, Cd1_p, ...
        Cd1_n, Cp1_p, Cp1_n, Comp_os, del_Compvn, del_ktc, Wda, Vref)));

end
grid;

%**************************移除直流分量******************************
dout = dout - mean(dout);

% ************************计算动态性能指标***************************
[pow, SNR, SNDR, ENOB, SFDR, THD, HD ] = calculate_dynamic_spec(dout);


%***************************test****************************


%********************将ADC 输出码值映射到输入信号范围*****************
dout_voltage = (dout / (2^N - 1)) * Vref; % 将数字输出映射到 [0, Vref]

% ****************************绘制阶梯波形***********************
figure(1);
stairs(dout_voltage, '-'); % 使用 stairs 显示阶梯形状
title('SAR ADC Output (Stepped Sine Wave)');
xlabel('Sample Index');
ylabel('Output Voltage (V)');
grid on;

% ********************可选：抽取数据以简化显示*********************
step = 10;                                   % 设置抽取间隔
dout_downsampled = dout_voltage(1:step:end); % 抽取数据
figure(2);
stairs(dout_downsampled, '--');
title('Downsampled SAR ADC Output (Stepped Sine Wave)');
xlabel('Sample Index');
ylabel('Output Voltage (V)');
grid on;


% **************************统计并绘制直方图*************************
% dout1 = round(dout);                 % 确保数据为整数
% counts = histcounts(dout1, 0:1:2^N);   % 统计每个代码的出现次数
% figure(3);
% bar(0:1:2^N-1, counts);               % 绘制直方图
% xlabel('Code'); ylabel('Count');
% title('Code Distribution');
% grid on;
% drawnow;                              % 强制刷新图像窗口


%************************* dnl & inl *************************
code = dout;
% band_code = 5;
minbin = min(code);                   % 找出code的最小值
maxbin = max(code);                   % 找出code的最大值
h = hist(code, minbin:maxbin);        % 绘制直方图
figure(3);
bar(h);
ch = cumsum(h);                       %累积分布
T = -cos(pi * ch / sum(h));           %归一化累积分布，匀分布映射
hlin = T(2:end) - T(1:end-1);
trunc = 8;
mincode = minbin + trunc;
maxcode = maxbin - trunc;
hlin_trunc = hlin(1+trunc:end-trunc);
lsb = sum(hlin_trunc) / length(hlin_trunc);
DNL = [0, hlin_trunc / lsb - 1];
INL = cumsum(DNL);
% *********** poly fit of INL ***********
[p, S] = polyfit([mincode:maxcode], INL, 1);
INL = INL - p(1) * [mincode:maxcode] - p(2);
%*********************** dnl & inl***************************

%************************绘制功率谱***************************
d_len = length(pow);
xstep = 1 / (2 * d_len);          % 频率步长
xz = 0 : xstep : (0.5 - xstep);   % 频率轴
A = 10 * log10(pow);
A = A-max(A);

%**************************绘制频谱***************************
figure(4);
subplot(3, 1, 1);
plot(xz, A);                      % 以对数刻度绘制频谱图
title('ADC Output Spectrum');
xlabel('Normalized Frequency (fi/fs)');
ylabel('Power (dB)');
axis([0, 0.5, -120, 0]);          % 设置频谱图的范围
grid;


%*************************绘制 DNL 和 INL***********************
subplot(3, 1, 2);
bar(DNL);
title('Differential Nonlinearity (DNL)');
xlabel('Code');
ylabel('DNL (LSB)');
grid;

subplot(3, 1, 3);
plot(INL, '-o');
title('Integral Nonlinearity (INL)');
xlabel('Code');
ylabel('INL (LSB)');
grid;


%*************************输出动态性能指标**********************
disp('Dynamic Performance Metrics:');
fprintf('SNR: %.2f dB\n', SNR);
fprintf('SNDR: %.2f dB\n', SNDR);
fprintf('ENOB: %.2f bits\n', ENOB);
fprintf('SFDR: %.2f dB\n', SFDR);
fprintf('THD: %.2f dB\n', THD);
disp('Harmonic Distortions (HD):');
disp(HD);





















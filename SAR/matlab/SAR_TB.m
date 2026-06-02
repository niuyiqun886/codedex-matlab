clear all;

% 参数定义
Vref = 1;
Vcm = Vref / 2;
N = 10;   % ADC 分辨率
M = 9;    % 比较次数

% 权值
Wda = [256, 128, 64, 32, 16, 8, 4, 2, 1];

% 容性失配参数
Cu = 1e-15;
del_Cu = 0.01 / sqrt(2) * Cu;
alfa = 0.1;
beta = 0.01;

% 比较器失配参数
del_Compos = 0 * 2e-3; % 可以调整为非零值测试比较器失调
del_Compvn = 200e-6;
del_ktc = 100e-6;

% 电容失配生成
for i = 1:M
    Cm_p(i) = Wda(i) * Cu + sqrt(Wda(i)) * del_Cu * randn(1, 1);
    Cm_n(i) = Wda(i) * Cu + sqrt(Wda(i)) * del_Cu * randn(1, 1);
end

% 输入电容及寄生电容
Cd1_p = Cu + del_Cu * randn(1, 1);
Cd1_n = Cu + del_Cu * randn(1, 1);
Cp1_p = beta * (sum(Cm_p) + Cd1_p);
Cp1_n = beta * (sum(Cm_n) + Cd1_n);

% 比较器失调电压
Comp_os = del_Compos * randn(1, 1);

% SAR ADC 仿真
d_len = 2^10;            % 输入信号点数
dout = zeros(1, d_len);  % 初始化输出向量
delta_ph = 311 / d_len * 2 * pi;  % 信号频率

for i = 1:d_len
    % 差分输入信号
    Vip = 0.49 * Vref * sin(i * delta_ph) + Vcm;
    Vin = -0.49 * Vref * sin(i * delta_ph) + Vcm;

    % 调用 SAR ADC 函数
    dout(i) = floor(adc_sar_diff(Vip, Vin, Vcm, M, Cm_p, ...
        Cm_n, Cd1_p, Cd1_n, Cp1_p, Cp1_n, Comp_os, del_Compvn, del_ktc, Wda, Vref));
end

% 移除直流分量
dout = dout - mean(dout);

% 计算功率谱
N = length(dout);                  % 数据长度
fft_result = fft(dout);            % 快速傅里叶变换
pow = abs(fft_result / N).^2;      % 归一化功率谱
pow(2:end-1) = 2 * pow(2:end-1);   % 修正正频率能量
pow = pow(1:N/2);                  % 取前半部分（正频率分量）

% 计算动态性能指标
[~, signal_bin] = max(pow(2:end)); % 找到基波频点
signal_bin = signal_bin + 1;       % 调整索引
signal_power = pow(signal_bin);    % 基波信号功率

% 剔除谐波成分后的噪声功率
harmonic_bins = [signal_bin, 2*signal_bin, 3*signal_bin]; % 假设前 3 次谐波
harmonic_bins(harmonic_bins > N/2) = [];                  % 剔除超出范围的频点
total_power = sum(pow);
noise_power = total_power - sum(pow(harmonic_bins));      % 剔除信号和谐波的总噪声

% 动态性能计算
SNR = 10 * log10(signal_power / noise_power);             % 信噪比
SNDR = 10 * log10(signal_power / (total_power - signal_power)); % 信噪失真比
ENOB = (SNDR - 1.76) / 6.02;                             % 有效位数

% 绘制功率谱
figure;
xz = linspace(0, 0.5, N/2); % 频率轴
plot(xz, 10 * log10(pow));
title('ADC Output Spectrum');
xlabel('Normalized Frequency (fi/fs)');
ylabel('Power (dB)');
axis([0, 0.5, -120, 0]);
grid on;

% 标注基波频点和动态性能
hold on;
stem(xz(signal_bin), 10 * log10(pow(signal_bin)), 'r', 'LineWidth', 1.5);
text(xz(signal_bin), 10 * log10(pow(signal_bin)) + 5, ...
    sprintf('SNR: %.2f dB\\nENOB: %.2f', SNR, ENOB));
hold off;



clear all;

% 参数定义
Vref = 1;
Vcm = Vref / 2;
N = 10;
M = 9;

% 权值
Wda = [256, 128, 64, 32, 16, 8, 4, 2, 1];

% 容性失配参数
Cu = 1e-15;
del_Cu = 0.01 / sqrt(2) * Cu;
alfa = 0.1;
beta = 0.01;

% 比较器失配参数
del_Compos = 0*2e-3;
del_Compvn = 200e-6;
del_ktc = 100e-6;

 % 固定随机种子
% rng(42);

% 初始化电容值数组
% Cm_p = zeros(1, M);
% Cm_n = zeros(1, M);

% 电容失配生成
for i = 1:M
    Cm_p(i) = Wda(i) * Cu + sqrt(Wda(i)) * del_Cu * randn(1, 1);
    Cm_n(i) = Wda(i) * Cu + sqrt(Wda(i)) * del_Cu * randn(1, 1);
end

% 输入电容及寄生电容
Cd1_p = Cu + del_Cu * randn(1, 1);
Cd1_n = Cu + del_Cu * randn(1, 1);
Cp1_p = beta * (sum(Cm_p) + Cd1_p);
Cp1_n = beta * (sum(Cm_n) + Cd1_n);

% 比较器失调电压
Comp_os = del_Compos * randn(1, 1);

% SAR ADC 仿真
d_len = 2^10;            % 输入信号点数
dout(d_len) = 0;
% dout = zeros(1, d_len);  % 初始化输出向量
delta_ph = 311 / d_len * 2 * pi;  % 信号频率

for i = 1:d_len
    % 差分输入信号
    Vip = 0.49 * Vref * sin(i * delta_ph) + Vcm;
    Vin = -0.49 * Vref * sin(i * delta_ph) + Vcm;

    % 调用 SAR ADC 函数
    dout(i) = adc_sar_diff(Vip, Vin, Vcm, M, Cm_p, ...
        Cm_n, Cd1_p, Cd1_n, Cp1_p, Cp1_n, Comp_os, del_Compvn, del_ktc, Wda, Vref);
end

% 移除直流分量
dout = dout - mean(dout);

% 计算功率谱
N = length(dout);                  % 数据长度
fft_result = fft(dout);            % 快速傅里叶变换
pow = abs(fft_result / N).^2;      % 归一化功率谱
pow(2:end-1) = 2 * pow(2:end-1);  % 乘以 2 修正正频率能量
pow = pow(1:N/2);                  % 取前半部分（正频率分量）

% 计算动态性能指标
signal_bin = 311;                  % 基波所在频点（需调整为实际值）
signal_power = pow(signal_bin);    % 信号功率
noise_power = sum(pow) - signal_power; % 噪声功率
SNR = 10 * log10(signal_power / noise_power); % 信噪比
SNDR = SNR;                        % 示例中暂假设 SNDR = SNR（实际应包含失真）
ENOB = (SNDR - 1.76) / 6.02;       % 有效位数

% 绘制功率谱
d_len = length(pow);
xstep = 1 / (2 * d_len);
xz = 0 : xstep : (0.5 - xstep);
plot(xz, 10 * log10(pow));
title('ADC Output Spectrum');
xlabel('fi/fs');
ylabel('Power (dB)');
axis([0, 0.5, -120, 0]);
grid on;


dout = dout - mean(dout); % 去除直流分量
[pow, SNR, SNDR, ENOB, SFDR, THD, HD] = calculate_dynamic_spec(dout);

% 绘制功率谱
d_len = length(pow);
xstep = 1 / (2 * d_len);
xz = 0 : xstep : (0.5 - xstep);
plot(xz, 10*log10(pow));
title('ADC Output Spectrum');
xlabel('fi/fs');
ylabel('Power (dB)');
axis([0, 0.5, -120, 0]);
grid;




% clear all;
% %Defining the structure and parameters of SAR ADC
% %non-idealities included:capacitor mismatch,offset,noise,and parasitics
% Vref = 1;Vcm = Vref/2;
% N = 10;
% M = 9;
% Wda = [256,128,64,32,16,8,4,2,1]; %CDAC 不带有冗余
% %Wda = [224,128,72,40,20,12,6,4,2,2,1];%CDAC 带有冗余
% Cu = 1e-15;
% del_Cu = 0.01/sqrt(2)*Cu;%单位电容和他的失配；
% alfa = 0.1;
% beta = 0.01;%电容的底板和顶板的寄生因子；
% del_Compos = 2e-4;
% del_Compvn = 200e-6;%比较器的噪声和失真的均方根的值；
% del_ktc = 100e-6;%定义采样噪声的均方根；
% Cm_p = zeros(1, M);
% Cm_n = zeros(1, M);
% 
% for i = 1:M %Defining the cap value of CDAC ,including random variation
%     Cm_p(i) = Wda(i)*Cu+sqrt(Wda(i))*del_Cu*randn(1,1);
%     Cm_n(i) = Wda(i)*Cu+sqrt(Wda(i))*del_Cu*randn(1,1);
% end
% Cd1_p = Cu+del_Cu*randn(1,1);Cd1_n = Cu+del_Cu*randn(1,1);
% Cp1_p = beta*(sum(Cm_p)+Cd1_p);Cp1_n = beta*(sum(Cm_n)+Cd1_n);%寄生
% Comp_os = del_Compos*randn(1,1);%比较器的失调；
% %Cm_n(3) = Cm_n(3)*0.99;%setting caps' value manually
% 
% 
% d_len = 2^10;dout(d_len)=0;%defining a data array to save ADC output
% delta_ph = 311/d_len*2*pi;%input's delta phase for a Tclk
% for i = 1:d_len
%     Vip = 0.49*Vref*sin(i*delta_ph)+Vcm;%defining input signal
%     Vin = -0.49*Vref*sin(i*delta_ph)+Vcm;
%     dout(i) = adc_sar_diff(Vip,Vin,Vcm,M,Cm_p, ...
%     Cm_n,Cd1_p,Cd1_n,Cp1_p,Cp1_n,Comp_os,del_Compvn,del_ktc,Wda,Vref);
% %A/D Conversion
% end
% plot(dout);
% %grid;
% 


























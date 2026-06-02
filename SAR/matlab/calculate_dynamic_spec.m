function [pow, SNR, SNDR, ENOB, SFDR, THD, HD] = calculate_dynamic_spec(dout)
    % 计算动态性能指标函数
    % 输入:
    % dout - SAR ADC 的输出信号
    % 输出:
    % pow  - 功率谱
    % SNR  - 信噪比 (dB)
    % SNDR - 信噪失真比 (dB)
    % ENOB - 有效位数 (bits)
    % SFDR - 谐波自由动态范围 (dB)
    % THD  - 总谐波失真 (dB)
    % HD   - 每个谐波的功率 (dB)

    % 设置
    N = length(dout);           % 信号长度
    dout = dout - mean(dout);   % 移除直流分量


    %****************************计算 FFT****************************
    fft_out = fft(dout);                       % 快速傅里叶变换
    fft_out = fft_out(1:N/2);                  % 取正频部分
    pow = abs(fft_out).^2 / N;                 % 功率谱密度
    window = hann(N);
    dout = dout .* window';

    %**************************找到信号主频点*************************
    [~, signal_bin] = max(pow);                % 主频点
    signal_power = pow(signal_bin);            % 主频点功率

    %***************************计算噪声功率*************************
    guard_band = 3;                            % 主频点左右排除的bin数量
    noise_bins = [1:signal_bin-guard_band, signal_bin+guard_band:N/2];
    noise_power = sum(pow(noise_bins));

    % noise_bins = [1:signal_bin-1, signal_bin+1:N/2];
    % noise_power = sum(pow(noise_bins));

    % 信噪比
    SNR = 10 * log10(signal_power / noise_power);

    %*************************查找谐波并计算功率*********************
    harmonics = zeros(1, 9);                   % 保存前 9 个谐波功率   
    for k = 2:10
        harmonic_bin = mod(k * signal_bin - 1, N/2) + 1;
        harmonics(k-1) = pow(harmonic_bin);
    end

    %************************总谐波失真 (THD)************************
    THD = 10 * log10(sum(harmonics) / signal_power);

    %*************************信噪失真比*****************************
    distortion_power = sum(harmonics);
    SNDR = 10 * log10(signal_power / (noise_power + distortion_power));

    %**************************有效位数******************************
    ENOB = (SNDR - 1.76) / 6.02;

    %**********************谐波自由动态范围***************************
    SFDR = 10 * log10(signal_power / max(harmonics));

    %*********************谐波功率（以 dB 表示）**********************
    HD = 10 * log10(harmonics / signal_power);

end



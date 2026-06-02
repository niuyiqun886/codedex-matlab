function [DNL, INL] = calculate_inl_dnl(code_hist, Vref, N)
% 输入参数:
% code_hist: 码宽的直方图 (每个码出现的次数)
% Vref: ADC 的参考电压
% N: ADC 的分辨率 (位数)

% 输出参数:
% DNL: 微分非线性 (LSB)
% INL: 积分非线性 (LSB)

% 1. 理想码宽
ideal_lsb = Vref / (2^N);            % 理想的 LSB 宽度
ideal_count = sum(code_hist) / (2^N); % 理想情况下，每个码的次数 (归一化为均匀分布)

% 2. 计算实际码宽 (归一化为理想值)
actual_count = code_hist;            % 每个码的实际宽度 (直方图次数)
normalized_width = actual_count / ideal_count;

% 3. DNL 计算
DNL = normalized_width - 1;          % 微分非线性 (偏差)

% 4. INL 计算
INL = cumsum(DNL);                   % 累积 DNL 得到 INL


end

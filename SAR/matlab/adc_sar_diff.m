function [adout] = adc_sar_diff(Vip,Vin,Vcm,M,Cm_p,Cm_n,Cd1_p, ...
    Cd1_n,Cp1_p,Cp1_n,Comp_os,del_Compvn,del_ktc,Wda,Vref)

    %******************************总电容计算**************************
    Ctm_p = sum(Cm_p) + Cd1_p + Cp1_p;
    Ctm_n = sum(Cm_n) + Cd1_n + Cp1_n;

    %*******************************初始电荷***************************
    Qi_p = -(sum(Cm_p) + Cd1_p) * (Vip - Vcm + del_ktc * randn(1,1));
    Qi_n = -(sum(Cm_n) + Cd1_n) * (Vin - Vcm + del_ktc * randn(1,1));

    %*****************************初始化底板电压************************
    Vdam_p(1:M) = Vcm;
    Vdam_n(1:M) = Vcm;

    %******************************初始化输出**************************
    adout = 0;

    %*****************************SAR 转换循环************************
    for i = 1:M
      
        xi(i)=i;                        %通过xi记录下运行到第几次了
        % 计算正负端电压
        Vres_p = Vcm + (Qi_p + (Vdam_p - Vcm) * rot90(Cm_p,3)) / Ctm_p; 
        Vres_n = Vcm + (Qi_n + (Vdam_n - Vcm) * rot90(Cm_n,3)) / Ctm_n;
        Vres_n_note(i) = Vres_n;        %记录每次比较时候的Vres_n的值
        Vres_p_note(i) = Vres_p;

    %******************************比较器判断*************************
        if Vres_p - Vres_n > Comp_os + del_Compvn * randn(1,1)
            Vdam_p(i) = 0;
            Vdam_n(i) = Vref;
            % cmp(i) = 0;
        else
            Vdam_p(i) = Vref;
            Vdam_n(i) = 0;
            % cmp(i) = 1;
            adout = adout + Wda(i);       % 累加当前位权重
            % adout = adout + Wda(i)*2;   % 累加当前位权重
            code(i) = adout;
        end
    end
end





%     % 最后一位判断
%     Vres_p = Vcm + (Qi_p + (Vdam_p - Vcm) * rot90(Cm_p,3)) / Ctm_p;
%     Vres_n = Vcm + (Qi_n + (Vdam_n - Vcm) * rot90(Cm_n,3)) / Ctm_n;
%     xi(M+1)=10;
% % Vres_n_note(M+1) = Vres_n;
% % Vres_p_note(M+1) = Vres_p;
%     if Vres_p - Vres_n < Comp_os + del_Compvn * randn(1,1)
%          adout = adout + Wda(M);  % 最后一位权重
%          % adout = adout + 1;  % 最后一位权重
%          % cmp(M+1) = 1
%     % else
%          % cmp(M+1) = 0
%     end
% end











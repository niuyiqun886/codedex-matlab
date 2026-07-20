% syms R C s          % 声明符号变量
% H = 1/(R*C*s + 1)   % 传递函数，结果保留 R C s
% 
% % 可以继续做符号运算
% H2 = simplify(H * (R*C*s + 1))   % 化简，结果为 1
% 
% % 求解方程
% solve(R*C*s + 1 == 0, s)         % 得到 s = -1/(R*C)
% 
% % 微分、积分也可以
% syms t
% f = exp(-t/(R*C));
% diff(f, t)          % 对 t 求导，结果含 R C
% int(f, t, 0, inf)   % 积分，结果为 R*C（假设 R*C>0）


syms s w R C real positive
H = 1/(R*C*s + 1);              % 一阶RC低通，含未知数

Hjw = subs(H, s, 1i*w);         % s -> jω
mag_dB = 20*log10(abs(Hjw));    % 符号幅频表达式
ph_deg = angle(Hjw)*180/pi;

% 固定C，扫R
figure; hold on
for Rval = [1e3 1e4 1e5]
    fplot(subs(mag_dB, [R C], [Rval 1e-6]), [1 1e6])
end
set(gca,'XScale','log'); grid on
xlabel('\omega (rad/s)'); ylabel('|H| (dB)')



% magFun = matlabFunction(mag_dB, 'Vars', [w R C]);
% wv = logspace(0, 6, 500);
% semilogx(wv, magFun(wv, 1e4, 1e-6))



% for Rval = [1e3 1e4 1e5]
%     H = tf(1, [Rval*1e-6, 1]);
%     bode(H); hold on
% end
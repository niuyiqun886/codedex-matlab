syms R C s          % 声明符号变量
H = 1/(R*C*s + 1)   % 传递函数，结果保留 R C s

% 可以继续做符号运算
H2 = simplify(H * (R*C*s + 1))   % 化简，结果为 1

% 求解方程
solve(R*C*s + 1 == 0, s)         % 得到 s = -1/(R*C)

% 微分、积分也可以
syms t
f = exp(-t/(R*C));
diff(f, t)          % 对 t 求导，结果含 R C
int(f, t, 0, inf)   % 积分，结果为 R*C（假设 R*C>0）
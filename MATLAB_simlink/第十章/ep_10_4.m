%% 10.2控制系统分析方法
%%10.2.1时域分析方法
%%例10-4求例10-3中系统的单位脉冲响应
A = [0 1 0; 0 0 1; -1 -2 -3];
B = [0;0;1];
C = [1 0 0];
D = 0;
sys = ss(A,B,C,D);
impulse(sys)


syms s 
r = dirac(t);
R = laplace(r, s)

R_1 = laplace(1, s)

R_2 = laplace(t, s)

R_3 = laplace(1/2*t^2, s)

R_4 = laplace(sin(t), s)
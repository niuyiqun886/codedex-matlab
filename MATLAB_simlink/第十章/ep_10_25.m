%%10.4.2分析命令
%函数sigma计算动态系统频率响应的奇异值：用法sigma(sys)
%sigma也可以计算修正形式的奇异值，使用语法为sigma(sys,[],type),由type指定计算类型
%当type = 1时计算$G^{-1}$的奇异值，当type = 2时计算1+G的奇异值，当type =3时，计算$1+G^{-1}$奇异值
%例10-25 已知一控制系统的传递函数矩阵为：

% $$G(s) = \begin{pmatrix}0 & \frac{3s}{s^2 + s + 10} \\\frac{s + 1}{s + 5} & \frac{2}{s + 6}\end{pmatrix}$$
%%试求G和1+G的奇异值(多输入多输出MIMO系统的'增益')
G = [0 tf([3 0],[1 1 10]);tf([1 1],[1 5]) tf(2,[1 6])];
subplot(2,1,1)
sigma(G)            %计算G的奇异值
grid on
subplot(2,1,2)
sigma(G,[],2)       %计算1+G的奇异值
grid on
%%6.5.3非线性系统的线性化处理
%%连续语法：argout = linmod('sys',x,u)
%%离散语法：argout = dlinmod('sys',Ts,x,u)
k = 18.45;
h = 80;
m = 70;
g = 9.8;
a1 = 1.3;
a2 = 1.1;
x0 = 30;
[A, B, C, D] = linmod('bungee')            %返回线性化后系统的状态空间描述
sys_struct = linmod('bungee')              %返回线性化后系统的结构体描述

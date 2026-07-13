%%例10-5 求例10-3中系统的响应曲线
%%利用lsim函数编写如下代码
A = [0 1 0; 0 0 1; -1 -2 -3];
B = [0; 0; 1];
C = [1 0 0];
D = 0;
sys = ss(A, B, C, D);
% [u, t] = gensig('square',4,10,0.1); 此版本为老版本，书上的输出直接就是双极性的方波
[u,t] = gensig('square',4,10,0.1);  %周期4s，总时长10s，采样间隔为0.1的方波，gensig的意思应该是generate signal的意思
%gensig这个东西返回两个值一个是前面的square方波，一个是t：总长时10s，采样间隔是0.1s
u = 2*u - 1;    % 转成老版本的 ±1 双极性方波
figure
plot(u)
figure
lsim(sys,u,t)    %sys是系统空间状态模型，u是输入方波，t是时间
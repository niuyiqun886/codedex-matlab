%%10.4控制系统仿真命令
%%例10-24利用MATLAB建立单位反馈系统，其中G(s) = 1/s^2 + s +1
%%两种方法：
%1.使用feedback
num = 1;
den = [1 1 1];
G = tf(num,den);
F = feedback(G,1)

%利用连接函数connect
G.u = 'e';                        %完全等价于 G.InputName = 'e'；控制领域习惯用 u 表示输入、y 表示输出
G.y = 'y';                        %完全等价于 G.OutputName = 'y'
%这里G(s)的输入是'e'，G(s)的输出是'y'，所以下面y = G(s)*e
Sum = sumblk('e=x-y');
T = connect(G,Sum,'x','y');       %使用connect可以指定输入输出的名字
sys = tf(T)
issiso(sys)
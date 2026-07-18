%%例6-3仿真时间设置。对例6-1中创建的系统模型ep_6_1进行系统仿真。
% 老版本语法 [t1,x1,y1] = sim('ep_6_1',10) 已被新版 MATLAB 移除
% 新版 sim 只返回一个 SimulationOutput 对象，数据从对象里取

%这只是改当前的仿真，不会改变simulink中的设置的
simOut = sim('ep_6_1','StartTime','1','StopTime','10','SaveState','on','Maxstep','1');
t1 = simOut.tout;   % 时间
x1 = simOut.xout;   % 状态（本模型无连续状态，为空）
y1 = simOut.yout;   % 输出端口 Out1 的信号
plot(t1,y1)
open_system('ep_6_1')
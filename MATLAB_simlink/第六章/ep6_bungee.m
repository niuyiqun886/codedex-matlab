%%6.4使用MATLAB脚本分析动态系统
%%6.4.1蹦极跳的安全性分析
%%addpath('D:\代码\matlab\MATLAB_simlink\第四章')   % 加入搜索路径
load_system('bungee')
% open_system('bungee')
h = 80;
m = 70;
g = 9.8;
a1 = 1.3;
a2 = 1.1;
x0 = 30;
for k = 1.845:0.1:30
    simOut = sim('bungee','StopTime','50');
    y = simOut.yout{1}.Values.Data;   % 新版 yout 是 Dataset 对象，需取出数值
    t = simOut.yout{1}.Values.Time;   
    if min(y)>1
        break;
    end
    %如果仿真结果输出数据的最小值，即蹦极者与地面的距离大于1，则说明此弹性系数符合安全要求，跳出循环
end

disp(['最小安全弹性系数k为：',num2str(k)])
distance = min(y);
disp(['蹦极者与地面的最小距离为：',num2str(distance)])
plot(t,y)




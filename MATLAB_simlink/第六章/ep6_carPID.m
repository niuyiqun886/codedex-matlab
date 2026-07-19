%%6.4.2汽车行驶控制系统中控制器的调节
open_system('carPID')
for Ki = 0.003:0.003:0.012
    simOut = sim('carPID');
    y = simOut.yout{1}.Values.Data;   % yout 是 Dataset 对象，需取出数值
    t = simOut.yout{1}.Values.Time;
    x = round(Ki/0.003);
    subplot(2,2,x)
    plot(t,y)
    title(['Ki=',num2str(Ki)])
end

%%根据输出的保存形式的不同来调整，矩阵的话就不需要后面的，dataset就需要取值
%%在取值第五行和第六行这样子：
%%不确定时先看类型:命令行运行 class(simOut.yout) —— 显示 double 就直接用;
%%显示 Simulink.SimulationData.Dataset 就 {1}.Values.Data。



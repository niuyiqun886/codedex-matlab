%%simplot命令使用
a = 1;
t = 0:0.1:7;
simInput = [t',cos(0:0.1:7)'];
simOut = sim('ep_6_2','StartTime','0','StopTime','7','MaxStep','0.001', ...
    'LoadExternalInput','on','ExternalInput','simInput');  % 打开外部输入并指定变量
y1 = simOut.yout;
t1 = simOut.tout;
% simplot(t1,y1)        %%simplot已经被弃用了
plot(t1,y1)
%%例6-4从matlab工作空间中获取输入信号(和书上的不一样)
% %%%%%%%%%%%%%%生成一个模块%%%%%%%%%%%
% load_system('ep_6_1')
% replace_block('ep_6_1','Sin','Inport')
% % replace_block('ep_6_1','Name','Sine Wave','Inport','noprompt')
% save_system('ep_6_1','ep_6_2.mdl')
% open_system('ep_6_2')
% %%%%%%%%%%%%%%生成一个模块%%%%%%%%%%%

% 方波输入：N×2 矩阵，第1列时间，第2列数值；行之间用分号
% 同一时刻出现两次（如 1 1; 1 -1）表示信号在该时刻跳变
simInput = [0 1; 1 1; 1 -1; 2 -1; 2 1; 3 1; 3 -1; 4 -1; 4 1; 5 1; 5 -1; 6 -1; 6 1; 7 1; 7 -1];
a = 1;   % Gain 模块的表达式是 a+3
simOut = sim('ep_6_2','StartTime','0','StopTime','7','MaxStep','0.1', ...
    'LoadExternalInput','on','ExternalInput','simInput');  % 打开外部输入并指定变量
y1 = simOut.yout;

t = 0:0.1:7;             % 时间向量，须与 cos 的采样点一致
simInput1 = [t',cos(t)'];
simOut1 = sim('ep_6_2','StartTime','0','StopTime','7','MaxStep','0.1', ...
    'LoadExternalInput','on','ExternalInput','simInput1');  % 打开外部输入并指定变量
y2 = simOut1.yout;

subplot(2,1,1)
plot(simOut.tout, y1)   % 时间轴用仿真自己的 tout，长度才能对上
subplot(2,1,2)
plot(simOut1.tout, y2)   % 时间轴用仿真自己的 tout，长度才能对上
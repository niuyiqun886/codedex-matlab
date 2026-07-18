%%例6-2简单仿真。对里6-1中创建的系统建模ep_6_1.mdl进行系统仿真。
load_system("ep_6_1")
% add_block('simulink/Sinks/Out1','ep_6_1/Out')
% add_line('ep_6_1','Gain/1','Out/1')
% save_system('ep_6_1','ep_6_1.mdl')
simOut = sim('ep_6_1','StopTime','15','MaxStep','0.01', ...
    'SaveState','on','StateSaveName','xout','SaveOutput','on', ...
    'OutputSaveName','yout','TimeSaveName','tout');
tout = simOut.get('tout');
yout = simOut.get('yout');
plot(tout,yout)

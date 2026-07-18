%%6.1.7命令行方式建立系统模型实例
%%例6-1使用命令行方式建立系统模型

%%%%%%%%%%%%%%这里是创建文件并且添加器件连线%%%%%%%%%%%%%%
% new_system('ep_6_1')
% open_system('ep_6_1')
% add_block('simulink/Sources/Sine Wave','ep_6_1/Sine Wave')
% add_block('simulink/Math Operations/Gain','ep_6_1/Gain')
% add_block('simulink/Sinks/Scope','ep_6_1/Scope')
% add_line('ep_6_1','Sine Wave/1','Gain/1')
% add_line('ep_6_1','Gain/1','Scope/1')

%%%%%%%%%%%%%设置参数%%%%%%%%%%%%%%%%%
load_system('ep_6_1')
set_param('ep_6_1/Gain','Gain','3')
set_param('ep_6_1/Sine Wave','Frequency','4')
save_system('ep_6_1','ep6_1.mdl')
set_param('ep_6_1','Solver','Ode45','StopTime','30','MaxStep','0.001')

%%%%%%%%%%%%%仿真，看结果%%%%%%%%%%%%%%
out = sim('ep_6_1')           %启动仿真
open_system('ep_6_1/Scope')   %查看结果
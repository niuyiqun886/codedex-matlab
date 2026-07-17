% % new_system('ep6')                    %创建一个ep6的文件
% % open_system('ep6')                   %打开ep6文件
% % save_system('ep6','ep6.mdl')         %保存为ep6为ep6.mdl
% % add_block('simulink/Sources/Sine Wave', 'ep6/Sine Wave')    %添加Sine Wave模块
% add_block('simulink/Sinks/Scope', 'ep6/Scope')                %添加Scope模块
% add_line('ep6', 'Sine Wave/1', 'Scope/1')                     %连线
% get_param('ep6/Sine Wave','Amplitude')    %得到ep6中的正弦信号的幅值
% get_param('ep6/Sine Wave','Frequency')
% block_param = get_param('ep6/Sine Wave','DialogParameters') %获得正弦信号的对话框参数
% set_param('ep6','Solver','Ode45','StopTime','0.003')        %设置仿真的参数
% gcs
% gcb
% gcb('ep6')
% gcbh
bdroot('ep6')

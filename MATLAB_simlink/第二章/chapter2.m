
%%  2.4 MATLAB 的程序流控制  %%
%%  2.4.1 循环控制结构 %%
% % for 循环结构 %%   这里和python的不同是需要有end结尾
% sum = 0;
% for i = 1:1:50  %循环变量等于向量表达式
%     sum = sum + i;
%     % fprintf('i 的值是 %.2f\n', i)
%     % fprintf('求和结果：%.2f\n', sum)
% end
% disp(sum)


%% while 循环结构 %%
% sum = 0;
% i = 1;
% while i<=50  %关系表达式
%     sum = sum + i;
%     i = i +1;
% end
% disp(sum)

%% 2.4.2 条件选择结构 %%
%% 1. if条件选择结构 %%
% grade = input('Please enter a grade:');
% if grade >= 90
%     degree = 'A';
% elseif (grade >= 80) && (grade <= 89)
%     degree = 'B';
% elseif (grade >= 70)&&(grade <= 79)
%     degree = 'C';   
% elseif (grade >= 60)&&(grade <= 69)
%     degree = 'D';
% else
%     degree = 'E';
% end
% disp(['The degree is ',degree])

%% 2. switch条件选择结构 %%
% degree = input('Enter a degree:');
% %degree = input('Enter a degree:','s');  %这样输入就不用是字符串的形式了
% switch degree
%     case 'A'
%         disp('The grade is 90-100.')
%     case 'B'
%         disp('The grade is 80-89.')
%     case 'C'
%         disp('The grade is 70-79.')
%     case 'D'
%         disp('The grade is 60-69.')
%     case 'E'
%         disp('The grade is 0-59.')
%     otherwise
%         disp('There is no this degree.')
% end

%% 2.6MATLAB的图形绘制 %%
%% 2.6.1 二维图形绘制 %%
%在新建的脚本ep2_20.m中

















%%  2.4 MATLAB 的程序流控制  %%
%%  2.4.1 循环控制结构 %%
%% for 循环结构 %%   这里和python的不同是需要有end结尾
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
grade = input('Please enter a grade:');
if grade >= 90
    degree = 'A';
elseif (80 <= grade) && (grade<= 89)
    degree = 'B';
elseif (70 <= grade)&&(grade <= 79)
    degree = 'C';   
elseif (60 <= grade)&&(grade <= 69)
    degree = 'D';
else
    degree = 'E';
end
disp(['The degree is ',degree])























function out = ep2_18(a,b,c)
%降序排序
if nargin == 3  %nargin 是 MATLAB 的内置变量，意思是 number of arguments in，即调用函数时传入的参数个数。
                % 所以 if nargin == 3 的意思是：如果调用者传入了3个参数，才执行排序。
    out = sort([a,b,c],'descend');
end


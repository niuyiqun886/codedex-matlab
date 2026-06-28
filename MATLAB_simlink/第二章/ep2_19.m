function A=ep2_19(n,m)
%该函数用于创建一个特殊矩阵：A(i,j)=1/(i+j-1)
%A=ep2_19(n,m) 创建一个n行m列的矩阵
%A=ep2_19(n) 创建一个你阶方阵
if nargout > 1   %检查输出参数的，例如[A,B] = ep2_19(3),就会线束输出参数过多
    error('Too many output arguments!');
end

if nargin == 1   %检查输入参数参数的，输入参数为1的时候就会变为方阵
    m = n;
elseif (nargin == 0 )||(nargin > 2)   %如过输入超过2个参数或者没有输入参数就会报错
    error('Wrong number of input arguments!');
end

A = zeros(n,m);
for i = 1:n
    for j = 1:m
        A(i,j) = 1/(i+j-1);
    end
end


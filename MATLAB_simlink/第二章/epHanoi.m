%%  汉诺塔问题
function epHanoi
%汉诺塔递归算法
%n是需要移动的盘子的个数
%最后打印出全部的移动步骤
n = input('请输出盘子的个数：');
disp(['移动',num2str(n),'个盘子的步骤为：'])
hanoi(n,'A','B','C')
function hanoi(n,one,two,three)
if n==1
    move(one,three);
else
    hanoi(n-1,one,three,two);
    move(one,three);
    hanoi(n-1,two,one,three);
end

function move(x,y)
disp([x,'->',y])



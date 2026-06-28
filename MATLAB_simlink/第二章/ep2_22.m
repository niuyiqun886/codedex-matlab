%%  例2.22 特殊二维曲线绘制 %%
x = -4:0.5:4;
y = exp(x);
figure(1)
bar(x,y)
title('bar(x,y)')
figure(2)
stem(x,y)
title('stem(x,y)')
figure(3)
stairs(x,y)
title('stairs(x,y)')
figure(4)
polarplot(x,y)
title('polar(x,y)')
figure(5)
loglog(x,y)
title('loglog(x,y)')
figure(6)
area(x,y)
title('area(x,y)')


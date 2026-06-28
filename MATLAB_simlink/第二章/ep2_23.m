%%  例2.23 hold on使用  %%
figure
t1 = 0:pi/20:pi;
t2 = pi/2:pi/20:3*pi/2;
t3 = pi:pi/20:2*pi;
y1 = sin(t1);
y2 = sin(t2-pi/2);
y3 = sin(t3-pi);
hold on   %这样使用hold on 和直接使用一个plot出现三个曲线的结果是一样的
plot(t1,y1,'-.r*')
plot(t2,y2,'--mo')
plot(t3,y3,':bs')
hold off
%图形修饰
axis([0 2*pi -1 1])
xlabel('弧度值')
ylabel('函数值')
title('三个不同相位的正弦曲线')
legend('y1','y2','y3')
grid
gtext('y1=sin(t1)')
gtext('y2=sin(t2-pi/2)')
gtext('y3=sin(t3-pi)')
%%  例2.21 二维图形绘制%%
figure
t = 0:pi/60:2*pi;  %这里应该是从0到2pi，每pi/20一个间隔
y1 = sin(t);
y2 = sin(t-pi/2);
y3 = sin(t-pi);
plot(t,y1,'-.r*',t,y2,'--mo',t,y3,':bs')

%图形修饰
axis([0 2*pi -1 1])
xlabel('弧度值')
ylabel('函数值')
title('三个不同相位的正弦曲线')
legend('y1','y2','y3')
grid
%通过运行之后点击图中的曲线即可添加描述的字符串
gtext('y1=sin(t)')
gtext('y2=sin(t-pi/2)')
gtext('y3=sin(t-pi)')


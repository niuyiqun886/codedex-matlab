%%  例：2.25绘制三维螺旋线
z = 0:pi/20:10*pi;
x=sin(z);
y=cos(z);
plot3(x,y,z)
xlabel('sin(z)')
ylabel('cos(z)')
zlabel('z')
grid on



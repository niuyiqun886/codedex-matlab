%%  例：2.26绘制三维火柴杆型螺旋线
z = 0:pi/20:2*pi;
x=sin(z);
y=cos(z);
stem3(x,y,z)
xlabel('sin(z)')
ylabel('cos(z)')
zlabel('z')
grid on

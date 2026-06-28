%%  例：2.27用mesh和surf分别绘制z=-x^2-y^2,x的范围是[-2,2],y的范围是[-2,2]
x = -2:0.1:2;
y = -2:0.1:2;
[X,Y]=meshgrid(x,y);
Z = -(X.^2+Y.^2);
figure(1)
mesh(X,Y,Z)
xlabel('x')
ylabel('y')
zlabel('z')
figure(2)
surf(X,Y,Z)


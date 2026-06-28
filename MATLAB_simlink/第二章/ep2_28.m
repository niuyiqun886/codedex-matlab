%% matlab 在自动控制中的应用
d1=[0.05 1];           %这里表示的是(0.5s+1)
d2=[0.05 0.1 1];       %这里表示的是(0.5s^2+0.1s+1)
den1 = conv(d1,d2);    %进行卷积运算
den = [den1 0];
num = 1;
sys = tf(num,den);
rlocus(sys)
rlocfind(sys)



%%10.5控制系统仿真实例
%%例10-26(系统的每部分传递函数参看ep_10_26.mdl)
clear all
num = [1 3 1];
den = [2 5 3];
G1 = tf(num,den);
G2 = zpk(-1,[-2 -10],2);
G3 = tf(5,[1 7]);
G4 = tf([1 0.3], [1 1 6]);
H = 1.5;
sys1 = (G1*G2+G3)*G4;
sys2 = feedback(sys1,H);
step(sys2)
grid on
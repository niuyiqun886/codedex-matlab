num = [0.5 1];
den = [2 3 1 0];
sys = tf(num, den);
sys_1 = feedback(sys, sys1);
step(sys_1)
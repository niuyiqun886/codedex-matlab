syms a b x z real
y = a*[cos(x);sin(x)];
y1 = b*[cos(z);sin(z)];
c = dot(y,y1)
d = simplify(c)
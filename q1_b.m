%Part B
f = SimpleFunctions();
n = -2:5;
n_y = -4:10; %because length(y) = length(x)+length(v) - 1

%representing x[n] and v[n] with impulse and unitstep functions
x = 2*f.delta(n) + f.delta(n-1);
v = f.unitstep(n) - f.unitstep(n-4);

y = conv(x,v);

%plotting x[n]
subplot(3,1,1);
stem(n,x,'LineWidth',2);
title('x[n]','FontSize',12);
text(2.5,1.5,'Part B, Kevin Le 400385350','FontSize',9);

%plotting v[n]
subplot(3,1,2);
stem(n,v,'LineWidth',2);
title('v[n]','FontSize',12);

%plotting y[n]
subplot(3,1,3);
stem(n_y,y,'LineWidth',2);
title('y[n]','FontSize',12);
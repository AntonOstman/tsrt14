%%
M = 2; N = 1;
th= [0.4 0.1 0.6 0.1];
x0 = [0.5 0.5]
stoa = exsensor('toa',M,N)
stoa.th=th;
stoa.x0=x0;
stoa.pe=0.005*eye(M);
plot(stoa)
stoa
y = simulate(stoa,1)
y.y
hold on
lh2(stoa,y)
plot(stoa)
hold on
crlb(stoa)

%%
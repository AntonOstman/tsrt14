function [y,x]=ssdlsim(A,B,C,D,u,x0)
N=size(u,2);
nx=size(A,1);
ny=size(C,1);
y=zeros(ny,N);
x=zeros(nx,N);
if nargin<5
    x(:,1)=zeros(nx,1);
else
    x(:,1)=x0;
end
for n=2:N
    x(:,n)=A*x(:,n-1)+B*u(:,n-1);
end
y=C*x+D*u;
y=y';
x=x';

function wimax
% WIMAX RSS data from a wimax network in Brussels
%
% Data collected by Dr Mussa Bhsara

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

load wimax
N=length(y.y);
Phi=[ones(N,1) log10(y.t)];
th=Phi\y.y
Phi1=[1 log10(min(y.t)); 1 log10(max(y.t))];
yhat=Phi1*th;
ind=find(y.y<400);
th=Phi(ind,:)\y.y(ind);
eps=y.y(ind)-Phi(ind,:)*th;
lamhat=eps'*eps/length(ind)
r=sqrt(lamhat)

plot(log10(y.t),y.y,'.',Phi1(:,2),yhat,'-','linewidth',2)
title(['Path loss constant = ',num2str(th(2)/10),' Std(e) = ',num2str(r)])
xlabel('log10(r)')
ylabel('RSS [dB]')

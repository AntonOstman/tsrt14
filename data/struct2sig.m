% Script for converting struct to sig objects

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

m=dir('*.mat');
N=length(m);
for k=1:N
   clear yc
   disp(m(k).name)
   ys=load(m(k).name);
   fn=fieldnames(ys);
   names=[];
%   try
   for n=1:length(fn);
      yc=eval(['ys.',fn{n}]);
      try u=yc.u; catch u=[]; end
      try x=yc.x; catch x=[]; end
      y=sig(yc.y,yc.fs,u,x);
      try, y.yMC=yc.yMC; end
      try, y.xMC=yc.xMC; end
      y.t=yc.t;
      try,y.nn=yc.nn;end
      try y.xlabel=yc.xlabel; end
      try y.ulabel=yc.ulabel; end
      try y.ylabel=yc.ylabel; end
      try y.tlabel=yc.tlabel; end
      try y.markerlabel=yc.markerlabel; end
      try y.marker=yc.marker; end
      y.name=yc.name; y.desc=yc.desc;
      try y.Px=yc.Px; end
      try y.Py=yc.Py; end
      try y.MC=yc.MC; end
      eval([fn{n},'=y;'])
      names=[names,' ',fn{n}];
   end
   name1=m(k).name;
   ind=findstr(name1,'.mat');
   name1=name1(1:ind-1);
   eval(['save -mat ',name1,'.sig ',names])
   ['save -mat ',name1,' ',names]
   ['clear ',names]
   try
   catch
   end
end

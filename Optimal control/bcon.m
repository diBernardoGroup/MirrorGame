% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

function res = bcon(ya,yb,xO,rp)
global theta1 rp xO;
res = [ya(1)-xO(1,1);
       ya(2)-xO(1,2);
       yb(3)-theta1*(yb(1)-rp);
       yb(4)];
end

% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

function dx= state(t,x)
global a b r w vd dt eta theta1 theta2 theta3 Sdt vel_hp;

dx = [x(2);
      -(a*x(1)^2+b*x(2)^2-r)*x(2)-w^2*x(1)-eta^(-1)*x(4);
      x(4)*(2*a*x(1)*x(2)+w^2);
      x(4)*(a*x(1)^2+3*b*x(2)^2-r)-x(3)-theta2*(x(2)-interp1(linspace(0,60,numel(vd)), vd, mod(Sdt,60)))-theta3*(x(2)-vel_hp)];
end
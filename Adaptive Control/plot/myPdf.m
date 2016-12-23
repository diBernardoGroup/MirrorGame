% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function myPdf(x,nfig,colour)

[F,XI] = ksdensity(x);
F = F./max(F);
figure(nfig);
plot(XI,F,colour);

end
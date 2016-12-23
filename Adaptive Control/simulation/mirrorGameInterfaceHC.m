% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

figure(1)
pointblue=animatedline(0,0.4,'color','b','marker','.','MarkerSize',160);

hold on;
pointgreen=animatedline(0,0.6,'color','g','marker','.','MarkerSize',160);
box on
grid on;
set(gca,'position',[0.05 0.1 0.9 0.8],...
    'XtickLabel',{'-0.5','','','','','0','','','','','0.5'},...
    'YtickLabel',[],'Ylim',[0.2 0.8],'Xlim',[-0.52 0.52])
drawnow
pause(0.5)
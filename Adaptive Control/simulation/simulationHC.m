% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function simulationHC

global n ti dt T
global xd xp x X u Xd
global Toc
global aee bee
global choice

%% Useful parameters
coupMax = 5;
uMax = 5;

openFig;
tic;

%% Initial values
xp = zeros(n,1);
xd0 = zeros(n,1);

if choice==1
    xd0(1) = getLeaderPositionMouse;
elseif choice==2
    xd0(1) = getLeaderPositionLeap;
end

x0 = xd0;
xd = xd0;
x = x0;

old_toc = toc;

aee = constrain(aee,coupMax);
bee = constrain(bee,coupMax);
uint0 = uI(x0,xd0);
u = LBA(aee,bee,x0,xd0,uint0);
% u = u + elasticForce(x0);
% u = constrain(u,uMax);

recordHC;
Toc = toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Loop
while Toc<T
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clearpoints(pointblue);
    addpoints(pointblue,xd(1),0.4);
    clearpoints(pointgreen);
    addpoints(pointgreen,x(1),0.6);
    drawnow update,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Toc = toc;
    
    %% VP state
    xp = HKB(x,u);
    dt = Toc-old_toc;
    if dt>.1
        dt=.1;
    end
    x = x + xp*dt;
    
    %% HP state
    if choice==1
        xd(1) = getLeaderPositionMouse;
    elseif choice==2
        xd(1) = getLeaderPositionLeap;
    end
    xd(2) = (xd(1)-Xd(1,ti))/dt;
 
    %% Record
    old_toc = Toc;    
    ti = ti+1;
    recordHC;
    
    %% Control
    uint = uI(X(:,ti),Xd(:,ti));
    aeep = adaptiveLawA(aee,X(:,ti),Xd(:,ti));
    beep = adaptiveLawB(bee,X(:,ti),Xd(:,ti),uint);
    aee = aee + aeep*dt;
    bee = bee + beep*dt;
    aee = constrain(aee,coupMax);
    bee = constrain(bee,coupMax);
    u = LBA(aee,bee,X(:,ti),Xd(:,ti),uint);
%     u = u + elasticForce(X(:,ti));
%     u = constrain(u,uMax);
end
    
end
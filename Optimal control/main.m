% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

function main()

close all;
clear all;
clc;

presentation;

global a b r w eta theta1 theta2 theta3
global vel_hp vd dt rp xO Sdt

dt=0.03; % sampling period
a=1;
b=1;
r=1;
w=1;

pmax_vp=0.5;
pmax_hp=0.5;

vmax_vp=0.1;
vmax_hp=0.1;

vel_hp=0;
vel_vp=0;

% pos_hp=0;
pos_vp=0;
Prepos_vp=0;

lambda2=0;
Sdt=0;

xO=[0 0];

theta1 = 0; theta2 = 0; theta3 = 0;
while (theta1+theta2+theta3~=1 || theta1<0 || theta2<0 || theta3<0)
    theta1 = input('Theta_p: ');   %  theta_p in the model
    theta2 = input('Theta_sigma: ');   %  theta_sigma in the model
    clc;
end

device = input('Enter [1] to use mouse, [2] to use leap motion: ');
clc;

eta=0.0001;

%%%%%%%%%%%%%%%

Nu=4000;
keep_data=zeros(10,Nu);

Tp = 0;
while (Tp<=0 || Tp>=60)
    clc;
    Tp = input('Trial duration [s], between 1 and 60s: '); % running time
    Tp = Tp-0.1;
end

choice = 0;
while (choice<1 || choice>18)
    clc;
    choice = input('Desired signature (natural number between 1 and 18): ');
    if (choice>=1 && choice<=9)
        data = importdata('reference1.mat');
        signature_index = choice;
    else
        data = importdata('reference2.mat');
        signature_index = choice-9;
    end
end
vd = data(signature_index).v;

%%%%%%%%%%

fid = fopen('Time_HP_VP.txt','w');

data=M_data();
Pdata=M_data();
i=0;

setInterface;

%% 
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

while(1)
    

i=i+1;

if device==1
    data.position = getLeaderPositionMouse;
else
    if i==1
        data.position = getLeaderPositionLeap(0);
    else
        data.position = getLeaderPositionLeap(keep_data(1,i-1));
    end
end


pos_hp = data.position;

keep_data(1,i)=pos_hp;                                            % position of HP
keep_data(2,i)=xO(1,1);                                           % position of VP
keep_data(3,i)=interp1(linspace(0,60,numel(vd)),vd,mod(Sdt,60));  % signature of Vel.
keep_data(4,i)=vel_vp;                                            % numerical velocity of VP
keep_data(6,i)=xO(1,2);                                           % velocity of VP from the CA 
keep_data(7,i)=vel_hp;                                            % velocity of HP
keep_data(5,i)=atan2(vel_vp/vmax_vp,pos_vp/pmax_vp)-atan2(vel_hp/vmax_hp,pos_hp/pmax_hp);
keep_data(5,i)=fixPhase(keep_data(5,i));                          % relative phase
keep_data(8,i)=dt;
keep_data(9,i)=Sdt;
keep_data(10,i)=-lambda2/eta;                                     % control signal
col=clock;

fprintf(fid,'%f %f %f \n', Sdt, keep_data(1,i), keep_data(2,i));

data.seconds=col(6);

dt=data.seconds-Pdata.seconds;

if (dt<0)
   dt=dt+60;
end 
if (dt==0)
   pause(0.03);
   dt=0.03;
end

if(i<=2)
   dt=0.03;
end


Sdt=Sdt+dt;

pos_hp=data.position;     

Pdata.seconds=data.seconds;
x3=data.position+(data.position-Pdata.position);                % estimated position of human player

vel_hp=(data.position-Pdata.position)/dt;

if(abs(pos_hp)>pmax_hp)
  pmax_hp=abs(pos_hp);
end

if (abs(vel_hp)>vmax_hp)
   vmax_hp=abs(vel_hp);
end

Pdata.position=data.position;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
solinit=bvpinit(linspace(0,dt,6),[xO(1,1) xO(1,2) 1 0]);
options=bvpset('RelTol',1e-1);
rp=x3;

sol=bvp4c('state','bcon',solinit,options);
xint = linspace(0,dt);
Sxint = deval(sol,xint);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fprintf(1,'VP: %f HP: %f dt: %f num: %f Sdt: %f\n', pos_vp, pos_hp, dt, num, Sdt);

%% 
clearpoints(pointblue);
addpoints(pointblue,pos_hp,0.4);
clearpoints(pointgreen);
addpoints(pointgreen,pos_vp,0.6);
drawnow update,

col=clock;
data.seconds=col(6);

Etime=data.seconds-Pdata.seconds;
if(Etime>0.2)
  Etime=0.2;
elseif(Etime<=0.002)
  Etime=0.002;
end 

num=floor(Etime*100/dt); 
if(abs(num)>100)
    num=100;
elseif(num<=1)
    num=1;
end

xO=[Sxint(1,num) Sxint(2,num)];

pos_vp=Sxint(1,num);
vel_vp=(pos_vp-Prepos_vp)/dt;
Prepos_vp=pos_vp;

lambda2=Sxint(4,num);

if(abs(Sxint(2,num))>vmax_vp)
   vmax_vp=abs(Sxint(2,num));
end

if(abs(Sxint(1,num))>pmax_vp)
   pmax_vp=abs(Sxint(1,num));
end

if(Sdt>=Tp)
    break;
end

end

fclose(fid);

setPlots;

figure(2)    
subplot(2,1,1)
plot(keep_data(9,1:i),keep_data(2,1:i),'b','LineWidth',2);                              
grid on
hold on 
plot(keep_data(9,1:i),keep_data(1,1:i),'r','LineWidth',2);legend('VP','HP');
grid on
hold on 
xlabel('t');
ylabel('Position');
axis([0 Tp -1 1]);



%Compute relative phase with protophase method

data=importdata('Time_HP_VP.txt');

phaseVP = evaluatePhase(data(:,3));
phaseHP = evaluatePhase(data(:,2));

global relativePhase;
relativePhase = phaseHP-phaseVP;

relativePhase = fixPhase(relativePhase);

subplot(2,1,2)
plot(data(:,1),relativePhase,'b','LineWidth',2);
grid on
hold on
line([0 Sdt],[0 0],'color','r','LineStyle','--','LineWidth',2);
grid on
hold on
xlabel('t');
ylabel('Relative Phase');
axis([0 Tp -4 4]);

% compute CV

Sum=[0 0];
for j=1:numel(relativePhase)
    Sum=Sum+[cos(relativePhase(j)) sin(relativePhase(j))];
end

CV = norm(Sum/numel(relativePhase)),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(4)
[g, xi]=ksdensity(vd);
plot(xi,g,'c','LineWidth',2);
grid on
hold on
[g, xi]=ksdensity(keep_data(4,1:i));
plot(xi,g,'b','LineWidth',2);
grid on
hold on
[g, xi]=ksdensity(keep_data(7,1:i));
plot(xi,g,'r','LineWidth',2);legend('Sig','VP','HP');
grid on
hold on
xlabel('Velocity');
ylabel('PDF');
axis([-2 2 0 2]);

% compute EMD

data1=keep_data(3,1:i);
data2=keep_data(4,1:i);
N=numel(data1);
max_bin=3.5;
min_bin=-3.5;
bin_range=max_bin-min_bin;
bins_data=linspace(min_bin,max_bin,200);
bin_width=(max_bin-min_bin)/200;
[h_data1,~]=hist(data1,bins_data);
[h_data2,~]=hist(data2,bins_data);

EMD_Sig_VP = sum(abs(cumsum(h_data1/N)-cumsum(h_data2/N)))*bin_width/bin_range,

data1=keep_data(4,1:i);
data2=keep_data(7,1:i);
N=numel(data1);
max_bin=3.5;
min_bin=-3.5;
bins_data=linspace(min_bin,max_bin,200);
bin_width=(max_bin-min_bin)/200;
[h_data1,~]=hist(data1,bins_data);
[h_data2,~]=hist(data2,bins_data);

EMD_VP_HP = sum(abs(cumsum(h_data1/N)-cumsum(h_data2/N)))*bin_width/bin_range,

data1=keep_data(3,1:i);
data2=keep_data(7,1:i);
N=numel(data1);
max_bin=3.5;
min_bin=-3.5;
bins_data=linspace(min_bin,max_bin,200);
bin_width=(max_bin-min_bin)/200;
[h_data1,~]=hist(data1,bins_data);
[h_data2,~]=hist(data2,bins_data);

EMD_Sig_HP = sum(abs(cumsum(h_data1/N)-cumsum(h_data2/N)))*bin_width/bin_range,

% compute RMS

RMS=0;
for j=1:i
   RMS=RMS+(keep_data(1,j)-keep_data(2,j))^2;            
end
RMS = sqrt(RMS/i),


Au=0;

for j=1:i
    Au=Au+abs(keep_data(10,j));
end

Au = Au/i,

TL=timeLag(keep_data(1,1:i),keep_data(2,1:i)),

phase_mean = mean(relativePhase),
phase_std = std(relativePhase),
    
    
end
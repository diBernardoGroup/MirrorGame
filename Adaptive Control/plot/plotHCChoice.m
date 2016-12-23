% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function plotHCChoice(leaderState,followerState)

global t T relativePhase

clc;
display('[1] -> Plot the time series of the position of leader and follower');
display('[2] -> Plot the time series of the velocity of leader and follower');
display('[3] -> Plot the PDF of the position of leader and follower');
display('[4] -> Plot the PDF of the velocity of leader and follower');
display('[5] -> Plot the time series of the relative phase between leader and follower');
display('[6] -> Plot the PDF of the relative phase between leader and follower');
display('[7] -> Stop plotting');

endChoice = 7;
pick = 0;
fig = 0;

leaderState(2,:) = smooth(leaderState(2,:));

% The relative phase should be defined as phase_HP - phase_VP
[relativePhase] = phaseEvaluation(leaderState(1,:),followerState(1,:));
        
while pick<endChoice
    
    fig = fig+1;
    pick = input('Choice: ');
    
    if pick==1
        figure(fig);
        plot(t,followerState(1,:),t,leaderState(1,:)),grid;
        title('position');
        xlabel('$t$');
        ylabel('$x(t)$');
        legend('follower','leader');
       
    elseif pick==2
        figure(fig);
        plot(t,followerState(2,:),t,leaderState(2,:)),grid;
        title('velocity');
        xlabel('$t$');
        ylabel('$\dot{x}(t)$');
        legend('follower','leader'); 
        
    elseif pick==3
        myPdf(followerState(1,:),fig,'b');
        hold on;
        grid on;
        myPdf(leaderState(1,:),fig,'g');
        xlabel('$x$');
        ylabel('PDF');
        axis([ -1 1 0 1]);
        legend('follower','leader');
        title('Position - Probability density function');
        
    elseif pick==4
        myPdf(followerState(2,:),fig,'b');
        hold on;
        grid on;
        myPdf(leaderState(2,:),fig,'g');            
        xlabel('$\dot{x}$');
        ylabel('PDF');
        axis([ -3 3 0 1]);
        legend('follower','leader');
        title('Velocity - Probability density function');
      
        
    elseif pick==5
        average_phase = mean(relativePhase)*ones(1,length(t));
        figure(fig);
        plot(t,relativePhase,t,average_phase,t,zeros(1,length(t)),'r--'),grid;
        title('relative phase time series');
        legend('relative phase','average value');
        
        xlabel('$t$');
        ylabel('$\phi(t) = \phi_{HP}(t) - \phi_{VP}(t)$');
        axis([0 T -4 4]);
        
    elseif pick==6
        figure(fig);
        myPdf(relativePhase,fig,'b');
        grid on;
        title('relative phase PDF');
        axis([-4 4 0 1]);
        xlabel('$\phi(t) = \phi_{HP}(t) - \phi_{VP}(t)$');
        ylabel('PDF');
    
    end
    
end

close all;

end
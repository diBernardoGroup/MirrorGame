% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function phase = fixPhase(phase)

% Map the phase into the interval [-pi,pi]

e = pi;
de = 2*pi;
phase = mod(phase,de);

for j=1:length(phase);
    if abs(phase(j))>e
        phase(j) = phase(j) - sign(phase(j))*de;
    end
end

end
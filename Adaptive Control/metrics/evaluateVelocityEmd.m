% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function emd = evaluateVelocityEmd(vel1,vel2)

% Normalized EMD

l = length(vel1);

% sine signal (leader velocity)
data1 = vel1;

% avatar signal (follower velocity)
data2 = vel2;

% bins for histograms
max_bin = 3.5;
min_bin = -max_bin;
intervals = 200;
bins_data = linspace(min_bin,max_bin,intervals);
bin_width = (max_bin-min_bin)/intervals;

% histograms
[h_data1,~] = hist(data1,bins_data);
[h_data2,~] = hist(data2,bins_data);

% cumsum(h_data1/N) is an approximation of CDF
emd = sum(abs(cumsum(h_data1/l)-cumsum(h_data2/l)))*bin_width;

end
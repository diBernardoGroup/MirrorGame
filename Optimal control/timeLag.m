% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

function xcr_opt = timeLag (x1,x2)

global dt

dt=mean(dt);

% 10 second window (you can change it), here both signals should have the
% same sampling frequency

window = ceil(10/dt);   %10

% consider only time lags shorter than 1.5 sec
max_lag = ceil(1.5/dt);

lg = length(x1);

xcr_vec = zeros(1,lg-window);
for i=1:lg-window
            i_end = i+window;
            crcov = xcov(x1(i:i_end)',x2(i:i_end)',max_lag,'coeff');
            [~,xcr] = max(crcov);
            xcr = xcr-(max_lag+1);
            xcr_vec(i) = xcr;
end
% xcr_win = xcr_vec(1:lg-window);

% optimal
crcov_opt = xcov(x2',x1',max_lag,'coeff');
[~,xcr_opt] = max(crcov_opt);
xcr_opt = xcr_opt-(max_lag+1);

xcr_opt = xcr_opt * dt;

end
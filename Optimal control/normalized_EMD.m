% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

data1=data_Ref1;
data2=data_Ref2;

N1=numel(data1);
N2=numel(data2);

max_bin=3.5;
min_bin=-3.5;

max_emd=max_bin-min_bin;

bins_data=linspace(min_bin,max_bin,200);
bin_width=(max_bin-min_bin)/200;
[h_data1,pos1]=hist(data1,bins_data);
[h_data2,pos2]=hist(data2,bins_data);

EMD_Ref1_Ref2 = sum(abs(cumsum(h_data1/N1)-cumsum(h_data2/N2)))*bin_width/max_emd,
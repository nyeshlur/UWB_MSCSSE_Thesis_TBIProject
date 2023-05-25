% load("Max_Min_Vector.mat")
% 
% x = transpose(max_min(1, :));
% 
% 
% % histogram(x, edges);
% 
% pd = fitdist(x,'Normal');
% 
% m = mean(pd);
% 
% x_pdf = [1:1:30];
% y = pdf(pd,x_pdf);
% 
% figure
% histogram(x, edges)
% % line(x_pdf,y)

% cc

% clear;
% load("/Users/nayanayeshlur/Downloads/Correlations/CC_Healthy_DoD124.mat")
% corr = [cc_RA(1,2); cc_LC(1,2); cc_LA(1,2)];


% combine

% healthy = load("/Users/nayanayeshlur/Downloads/Concatenated/Concatenated_Healthy_LC.mat");
% iph = load("/Users/nayanayeshlur/Downloads/Concatenated_TBI_JustIPH_LC.mat");
% cc = [healthy.cc;iph.cc];
% save("Concatenated_Healthy_IPH_LC.mat", "cc")
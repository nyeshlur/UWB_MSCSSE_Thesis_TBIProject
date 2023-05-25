clear; clc;
load("/Users/nayanayeshlur/Downloads/Concatenated/Concatenated_LC.mat")

[nrows, ncols] = size(cc);

cov_i = cov(cc);

X = zeros([nrows,ncols]);

ss_i = zeros([1,ncols]);   % you could use this for the scree plot
ss_cu = zeros([1,ncols]);  % you could use this for the cumulative scree plot 


means = mean(cc);
vars = var(cc);
stdevs = std(cc);
minimum = min(cc);
maximum = max(cc);
STDEVM = stdevs;
for i = 1: ncols
    STDEVM(1,i) = STDEVM(1,i) / means(1,i);
end

% Mean center data
% This is necessary so that everything is mean centered at 0
% facilitates statistical and hypothesis analysis

for i=1:ncols
    for j=1:nrows
        X(j,i) = -(means(:,i) - cc(j,i));
    end
end


% Scale data 
% This is necessary so that all data has the same order, e.g.,  
% should not compare values in the thousands vs. values between 0 and 1 

for i=1:ncols
    for j=1:nrows
        X(j,i) = X(j,i) / stdevs(:,i);
    end
end


% svd
% X is the original dataset
% Ur will be the transformed dataset
% S is covariance matrix (not normalized)

[U, S, V] = svd(X,0); 


% Number of features to use, in this case its the columns
nfeatures = ncols;
f_to_use = nfeatures;
feature_vector = 1:f_to_use;

% r = Ur;  % make a copy of Ur to preserve it, we will randomize r

% Obtain the necessary information for Scree Plots 
% Obtain S^2 (and can also use to normalize S)   

S2 = S^2; 

weights2 = zeros(nfeatures,1); 

sumS2 = sum(sum(S2)); 

weightsum2 = 0; 

 
for i=1:nfeatures 
    weights2(i) = S2(i,i)/sumS2; 
    weightsum2 = weightsum2 + weights2(i); 
    weight_c2(i) = weightsum2; 
end 

Ur = U*S; % regular scores


fig = figure; 
plot(weights2,'x:b'); 
grid; 
title('Scree Plot'); 
% saveas(fig, "ScreePlot.png")

 

fig = figure; 
plot(weight_c2,'x:r'); 
grid; 
title('Scree Plot Cumulative'); 
% saveas(fig, "ScreePlotCumulative.png")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:nfeatures 
    for j=1:nfeatures 
        Vsquare(i,j) = V(i,j)^2; 
        if V(i,j)<0 
            Vsquare(i,j) = Vsquare(i,j)*-1; 
        else  
            Vsquare(i,j) = Vsquare(i,j)*1; 
        end 
    end 
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nfeatures 
    fig = figure; 
    bar(Vsquare(:,i),0.5); 
    grid; 
    ymin = min(Vsquare(:,i)) + (min(Vsquare(:,i))/10); 
    ymax = max(Vsquare(:,i)) + (max(Vsquare(:,i))/10); 
    axis([0 nfeatures ymin ymax]);
    xticks(0:1:30);
    xlabel('Feature index'); 
    ylabel('Importance of feature'); 
    [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
    title(chart_title); 
    % saveas(fig, chart_title + ".png")
end

% Loading_Vector_Average = abs(Vsquare);



%%%%%%%%%%%%%%%%%%
%pc scatter
%%%%%%%%%%%%%%%%%%

% % RA
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC3'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC3 ");
% scatter3(Ur(1:88, 1), Ur(1:88, 2), Ur(1:88, 3), 'r.')
% scatter3(Ur(89:1898, 1), Ur(89:1898, 2), Ur(89:1898, 3), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:88, 1), Ur(1:88, 2), Ur(1:88, 4), 'r.')
% scatter3(Ur(89:1898, 1), Ur(89:1898, 2), Ur(89:1898, 4), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:88, 1), Ur(1:88, 3), Ur(1:88, 4), 'r.')
% scatter3(Ur(89:1898, 1), Ur(89:1898, 3), Ur(89:1898, 4), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC4'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:88, 2), Ur(1:88, 3), Ur(1:88, 4), 'r.')
% scatter3(Ur(89:1898, 2), Ur(89:1898, 3), Ur(89:1898, 4), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:88, 1), Ur(1:88, 2), Ur(1:88, 5), 'r.')
% scatter3(Ur(89:1898, 1), Ur(89:1898, 2), Ur(89:1898, 5), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:88, 1), Ur(1:88, 3), Ur(1:88, 5), 'r.')
% scatter3(Ur(89:1898, 1), Ur(89:1898, 3), Ur(89:1898, 5), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC4 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:88, 1), Ur(1:88, 4), Ur(1:88, 5), 'r.')
% scatter3(Ur(89:1898, 1), Ur(89:1898, 4), Ur(89:1898, 5), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:88, 2), Ur(1:88, 3), Ur(1:88, 5), 'r.')
% scatter3(Ur(89:1898, 2), Ur(89:1898, 3), Ur(89:1898, 5), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC4 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:88, 2), Ur(1:88, 4), Ur(1:88, 5), 'r.')
% scatter3(Ur(89:1898, 2), Ur(89:1898, 4), Ur(89:1898, 5), 'bo')


% % RC
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC3'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC3 ");
% scatter3(Ur(1:87, 1), Ur(1:87,2), Ur(1:87,3), 'r.')
% scatter3(Ur(88:1806, 1), Ur(88:1806,2), Ur(88:1806,3), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:87, 1), Ur(1:87,2), Ur(1:87,4), 'r.')
% scatter3(Ur(88:1806, 1), Ur(88:1806,2), Ur(88:1806,4), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:87, 1), Ur(1:87,3), Ur(1:87,4), 'r.')
% scatter3(Ur(88:1806, 1), Ur(88:1806,3), Ur(88:1806,4), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC4'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:87, 2), Ur(1:87,3), Ur(1:87,4), 'r.')
% scatter3(Ur(88:1806, 2), Ur(88:1806,3), Ur(88:1806,4), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:87, 1), Ur(1:87, 2), Ur(1:87, 5), 'r.')
% scatter3(Ur(88:1806, 1), Ur(88:1806, 2), Ur(88:1806, 5), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:87, 1), Ur(1:87,3), Ur(1:87,5), 'r.')
% scatter3(Ur(88:1806, 1), Ur(88:1806, 3), Ur(88:1806, 5), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC4 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:87, 1), Ur(1:87,4), Ur(1:87,5), 'r.')
% scatter3(Ur(88:1806, 1), Ur(88:1806, 4), Ur(88:1806, 5), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:87, 2), Ur(1:87,3), Ur(1:87,5), 'r.')
% scatter3(Ur(88:1806, 2), Ur(88:1806, 3), Ur(88:1806, 5), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC4 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:87, 2), Ur(1:87,4), Ur(1:87,5), 'r.')
% scatter3(Ur(88:1806, 2), Ur(88:1806, 4), Ur(88:1806, 5), 'bo')



% % LA

% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC3'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC3 ");
% scatter3(Ur(1:96, 1), Ur(1:96,2), Ur(1:96,3), 'r.')
% scatter3(Ur(97:1873, 1), Ur(97:1873,2), Ur(97:1873,3), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:96, 1), Ur(1:96,2), Ur(1:96,4), 'r.')
% scatter3(Ur(97:1873, 1), Ur(97:1873,2), Ur(97:1873,4), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:96, 1), Ur(1:96,3), Ur(1:96,4), 'r.')
% scatter3(Ur(97:1873, 1), Ur(97:1873,3), Ur(97:1873,4), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC4'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:96, 2), Ur(1:96,3), Ur(1:96,4), 'r.')
% scatter3(Ur(97:1873, 2), Ur(97:1873,3), Ur(97:1873,4), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:96, 1), Ur(1:96,2), Ur(1:96,5), 'r.')
% scatter3(Ur(97:1873, 1), Ur(97:1873,2), Ur(97:1873,5), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:96, 1), Ur(1:96,3), Ur(1:96,5), 'r.')
% scatter3(Ur(97:1873, 1), Ur(97:1873,3), Ur(97:1873,5), 'bo')
% 
% figure; 
% hold on; 
% title('PC1 vs PC4 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:96, 1), Ur(1:96,4), Ur(1:96,5), 'r.')
% scatter3(Ur(97:1873, 1), Ur(97:1873,4), Ur(97:1873,5), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:96, 2), Ur(1:96,3), Ur(1:96,5), 'r.')
% scatter3(Ur(97:1873, 2), Ur(97:1873,3), Ur(97:1873,5), 'bo')
% 
% figure; 
% hold on; 
% title('PC2 vs PC4 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:96, 2), Ur(1:96,4), Ur(1:96,5), 'r.')
% scatter3(Ur(97:1873, 2), Ur(97:1873,4), Ur(97:1873,5), 'bo')


% LC

% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC3'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC3 ");
% scatter3(Ur(1:84, 1), Ur(1:84, 2), Ur(1:84, 3), 'bo')
% scatter3(Ur(85:1816, 1), Ur(85:1816, 2), Ur(85:1816, 3), 'r.')
% 
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:84, 1), Ur(1:84, 2), Ur(1:84, 4), 'bo')
% scatter3(Ur(85:1816, 1), Ur(85:1816, 2), Ur(85:1816, 4), 'r.')
% 
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:84, 1), Ur(1:84, 3), Ur(1:84, 4), 'bo')
% scatter3(Ur(85:1816, 1), Ur(85:1816, 3), Ur(85:1816, 4), 'r.')
% 
% 
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC4'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:84, 2), Ur(1:84, 3), Ur(1:84, 4), 'bo')
% scatter3(Ur(85:1816, 2), Ur(85:1816, 3), Ur(85:1816, 4), 'r.')
% 
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:84, 1), Ur(1:84, 2), Ur(1:84, 5), 'bo')
% scatter3(Ur(85:1816, 1), Ur(85:1816, 2), Ur(85:1816, 5), 'r.')
% 
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:84, 1), Ur(1:84, 3), Ur(1:84, 5), 'bo')
% scatter3(Ur(85:1816, 1), Ur(85:1816, 3), Ur(85:1816, 5), 'r.')
% 
% 
% figure; 
% hold on; 
% title('PC1 vs PC4 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:84, 1), Ur(1:84, 4), Ur(1:84, 5), 'bo')
% scatter3(Ur(85:1816, 1), Ur(85:1816, 4), Ur(85:1816, 5), 'r.')
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:84, 2), Ur(1:84, 3), Ur(1:84, 5), 'bo')
% scatter3(Ur(85:1816, 2), Ur(85:1816, 3), Ur(85:1816, 5), 'r.')
% 
% figure; 
% hold on; 
% title('PC2 vs PC4 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:84, 2), Ur(1:84, 4), Ur(1:84, 5), 'bo')
% scatter3(Ur(85:1816, 2), Ur(85:1816, 4), Ur(85:1816, 5), 'r.')

%%%%%%%%%%%%%%%%%%
